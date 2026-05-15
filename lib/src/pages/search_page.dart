import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../design_system/colors.dart';
import '../design_system/typography.dart';
import '../design_system/spacing.dart';
import 'profile_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();
  String _term = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    setState(() {
      _term = value.trim();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final searchTerm = _term.toLowerCase();
    final users = searchTerm.isEmpty ? [] : state.searchUsers(searchTerm);
    final posts = searchTerm.isEmpty ? [] : state.searchPosts(searchTerm);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Explorar',
              style: AppTypography.headingLg,
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _controller,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Buscar usuários ou posts...',
                prefixIcon: const Icon(Icons.search_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.md),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            if (searchTerm.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    'Procure por pessoas, posts ou temas relevantes para a sua comunidade.',
                    style: AppTypography.bodyMd.copyWith(
                      color: AppColors.textLightSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            else ...[
              if (users.isNotEmpty) ...[
                Text('Usuários', style: AppTypography.headingMd),
                const SizedBox(height: AppSpacing.sm),
                Expanded(
                  child: ListView.separated(
                    itemCount: users.length,
                    separatorBuilder: (context, index) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final user = users[index];
                      final following = state.isFollowing(user.id);
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: AppSpacing.sm),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.avatarUrl),
                        ),
                        title: Text(user.name, style: AppTypography.bodyLg.copyWith(fontWeight: FontWeight.w600)),
                        subtitle: Text('@${user.username}'),
                        trailing: ElevatedButton(
                          onPressed: () => state.toggleFollow(user.id),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: following ? AppColors.primary.withAlpha(26) : AppColors.primary,
                            foregroundColor: following ? AppColors.primary : Colors.white,
                            elevation: 0,
                          ),
                          child: Text(following ? 'Seguindo' : 'Seguir'),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ProfilePage(userId: user.id),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
              if (posts.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.lg),
                Text('Posts', style: AppTypography.headingMd),
                const SizedBox(height: AppSpacing.sm),
                Expanded(
                  child: ListView.separated(
                    itemCount: posts.length,
                    separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.lg),
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSpacing.lg),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.lg),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(post.author.avatarUrl),
                                  ),
                                  const SizedBox(width: AppSpacing.md),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(post.author.name, style: AppTypography.bodyLg.copyWith(fontWeight: FontWeight.w600)),
                                      Text('@${post.author.username}', style: AppTypography.bodySm.copyWith(color: AppColors.textLightSecondary)),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppSpacing.md),
                              Text(post.content, style: AppTypography.bodyMd),
                              if (post.imageUrl != null) ...[
                                const SizedBox(height: AppSpacing.md),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(AppSpacing.md),
                                  child: Image.network(post.imageUrl!, fit: BoxFit.cover),
                                ),
                              ],
                              const SizedBox(height: AppSpacing.md),
                              Row(
                                children: [
                                  Icon(Icons.favorite, size: 16, color: AppColors.error),
                                  const SizedBox(width: AppSpacing.xs),
                                  Text('${post.likes}', style: AppTypography.bodySm),
                                  const SizedBox(width: AppSpacing.lg),
                                  Icon(Icons.comment_outlined, size: 16, color: AppColors.textLightSecondary),
                                  const SizedBox(width: AppSpacing.xs),
                                  Text('${post.comments}', style: AppTypography.bodySm),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
              if (users.isEmpty && posts.isEmpty)
                Expanded(
                  child: Center(
                    child: Text(
                      'Nenhum resultado encontrado para "$_term".',
                      style: AppTypography.bodyMd.copyWith(color: AppColors.textLightSecondary),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
