/// Post Card Component
/// Card de postagem com bordas arredondadas, padding e sombra premium

import 'package:flutter/material.dart';
import '../design_system/colors.dart';
import '../design_system/spacing.dart';

class PostCard extends StatelessWidget {
  final String authorName;
  final String authorAvatar;
  final String content;
  final String? imageUrl;
  final DateTime timestamp;
  final int likes;
  final int comments;
  final bool isLikedByMe;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onShare;

  const PostCard({
    required this.authorName,
    required this.authorAvatar,
    required this.content,
    required this.timestamp,
    this.imageUrl,
    this.likes = 0,
    this.comments = 0,
    this.isLikedByMe = false,
    required this.onLike,
    required this.onComment,
    required this.onShare,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.lg),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: isDark ? 0.3 : 0.08,
            ),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(authorAvatar),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authorName,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        _formatTime(timestamp),
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(
                              color: isDark
                                  ? AppColors.textDarkSecondary
                                  : AppColors.textLightSecondary,
                            ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton(
                  itemBuilder: (_) => [
                    const PopupMenuItem(
                      child: Text('Reportar'),
                    ),
                    const PopupMenuItem(
                      child: Text('Copiar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Text(
              content,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          // Image
          if (imageUrl != null)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              height: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(imageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          const SizedBox(height: AppSpacing.md),
          // Stats
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$likes curtidas',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Text(
                  '$comments comentários',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
          const Divider(height: AppSpacing.xl),
          // Actions
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _ActionButton(
                  icon: isLikedByMe ? Icons.favorite : Icons.favorite_border,
                  label: 'Curtir',
                  color: isLikedByMe ? AppColors.error : null,
                  onPressed: onLike,
                ),
                _ActionButton(
                  icon: Icons.chat_bubble_outline,
                  label: 'Comentar',
                  onPressed: onComment,
                ),
                _ActionButton(
                  icon: Icons.share_outlined,
                  label: 'Compartilhar',
                  onPressed: onShare,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) {
      return 'Agora';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m atrás';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h atrás';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d atrás';
    } else {
      return '${time.day}/${time.month}/${time.year}';
    }
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = color ?? (isDark ? AppColors.textDarkSecondary : AppColors.textLightSecondary);

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            Icon(icon, color: textColor, size: 20),
            const SizedBox(width: AppSpacing.xs),
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
