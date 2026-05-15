import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../app_state.dart';

class PremiumPostCard extends StatelessWidget {
  final Post post;
  final VoidCallback? onLike;
  final Function(String)? onComment;
  final Function(String, String)? onCommentLike;

  const PremiumPostCard({
    super.key,
    required this.post,
    this.onLike,
    this.onComment,
    this.onCommentLike,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho do post
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: post.userAvatar != null && post.userAvatar!.isNotEmpty
                      ? NetworkImage(post.userAvatar!)
                      : null,
                  child: post.userAvatar == null || post.userAvatar!.isEmpty
                      ? Text(
                          post.userName[0].toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.userName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        _formatTime(post.timestamp),
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_horiz),
                  onPressed: () {},
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Conteúdo do post
            Text(
              post.content,
              style: const TextStyle(fontSize: 15, height: 1.4),
            ),
            
            if (post.imageUrl != null && post.imageUrl!.isNotEmpty) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  post.imageUrl!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Center(child: Icon(Icons.error)),
                  ),
                ),
              ),
            ],
            
            const SizedBox(height: 16),
            
            // Estatísticas
            Row(
              children: [
                // Likes
                _buildStatItem(
                  icon: post.isLiked ? Icons.favorite : Icons.favorite_border,
                  color: post.isLiked ? Colors.red : Colors.grey,
                  count: post.likes.length.toString(),
                  onTap: onLike,
                ),
                const SizedBox(width: 24),
                
                // Comentários
                _buildStatItem(
                  icon: Icons.comment_outlined,
                  color: Colors.grey,
                  count: post.comments.length.toString(),
                  onTap: () => _showCommentDialog(context),
                ),
                
                const Spacer(),
                
                // Compartilhar
                IconButton(
                  icon: const Icon(Icons.share_outlined),
                  color: Colors.grey,
                  onPressed: () {},
                ),
              ],
            ),
            
            // Lista de comentários
            if (post.comments.isNotEmpty) ...[
              const Divider(height: 24),
              Text(
                'Comentários (${post.comments.length})',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              ...post.comments.take(3).map((comment) => _buildCommentItem(comment, context)),
              if (post.comments.length > 3)
                TextButton(
                  onPressed: () {},
                  child: Text('Ver todos os ${post.comments.length} comentários'),
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required Color color,
    required String count,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 4),
            Text(
              count,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentItem(Comment comment, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: Colors.grey[300],
            child: Text(
              comment.userName[0].toUpperCase(),
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment.userName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    comment.content,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          if (onCommentLike != null)
            IconButton(
              icon: Icon(
                comment.likes.isNotEmpty ? Icons.favorite : Icons.favorite_border,
                size: 16,
                color: comment.likes.isNotEmpty ? Colors.red : Colors.grey,
              ),
              onPressed: () => onCommentLike!(post.id, comment.id),
            ),
        ],
      ),
    );
  }

  void _showCommentDialog(BuildContext context) {
    final commentController = TextEditingController();
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: commentController,
                        decoration: InputDecoration(
                          hintText: 'Adicione um comentário...',
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
                      onPressed: () {
                        final text = commentController.text.trim();
                        if (text.isNotEmpty && onComment != null) {
                          onComment!(text);
                          Navigator.pop(context);
                        }
                      },
                      icon: const Icon(Icons.send),
                      color: const Color(0xFF2563EB),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 7) {
      return DateFormat('dd/MM/yyyy').format(dateTime);
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d atrás';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h atrás';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}min atrás';
    } else {
      return 'Agora mesmo';
    }
  }
}