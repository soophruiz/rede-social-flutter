import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../components/premium_post_card.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final _postController = TextEditingController();

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  void _publishPost(AppState state) {
    final content = _postController.text.trim();
    if (content.isNotEmpty) {
      state.addPost(content);
      _postController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final posts = state.feedPosts;
    final suggestions = state.suggestedUsers;
    final user = state.currentUser;

    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              // Criar post
              SliverToBoxAdapter(
                child: _buildCreatePost(user, state),
              ),

              // Sugestões de usuários
              if (suggestions.isNotEmpty)
                SliverToBoxAdapter(
                  child: _buildSuggestions(suggestions, state),
                ),

              // Lista de posts
              if (posts.isEmpty)
                const SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'Nenhum post encontrado.\nSiga pessoas para ver conteúdo!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final post = posts[index];
                      return PremiumPostCard(
                        post: post,
                        onLike: () => state.toggleLike(post.id),
                        onComment: (commentText) => state.addComment(post.id, commentText),
                        onCommentLike: (postId, commentId) => state.toggleCommentLike(postId, commentId),
                      );
                    },
                    childCount: posts.length,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCreatePost(UserModel? user, AppState state) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.grey[300],
              backgroundImage: user?.avatarUrl != null && user!.avatarUrl!.isNotEmpty
                  ? NetworkImage(user.avatarUrl!)
                  : null,
              child: user?.avatarUrl == null || user!.avatarUrl!.isEmpty
                  ? Text(
                      user?.name.isNotEmpty == true ? user!.name[0].toUpperCase() : '?',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _postController,
                decoration: InputDecoration(
                  hintText: 'No que você está pensando?',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 12),
            IconButton(
              onPressed: () => _publishPost(state),
              icon: const Icon(Icons.send_rounded),
              color: const Color(0xFF2563EB),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestions(List<UserModel> suggestions, AppState state) {
    return SizedBox(
      height: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Sugestões para você',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                final userSuggestion = suggestions[index];
                final isFollowing = state.isFollowing(userSuggestion.id);
                
                return Container(
                  width: 180,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.grey[300],
                            backgroundImage: userSuggestion.avatarUrl != null && userSuggestion.avatarUrl!.isNotEmpty
                                ? NetworkImage(userSuggestion.avatarUrl!)
                                : null,
                            child: userSuggestion.avatarUrl == null || userSuggestion.avatarUrl!.isEmpty
                                ? Text(
                                    userSuggestion.name[0].toUpperCase(),
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  )
                                : null,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            userSuggestion.name,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          ElevatedButton(
                            onPressed: () => state.toggleFollow(userSuggestion.id),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isFollowing ? Colors.grey[300] : const Color(0xFF2563EB),
                              foregroundColor: isFollowing ? Colors.black : Colors.white,
                              minimumSize: const Size(80, 30),
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                            ),
                            child: Text(isFollowing ? 'Seguindo' : 'Seguir'),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}