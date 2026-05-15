import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final DateFormat dateFormat;
  final VoidCallback onLike;
  final VoidCallback onComment;

  const PostCard({
    super.key,
    required this.post,
    required this.dateFormat,
    required this.onLike,
    required this.onComment,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(post.author.avatarUrl),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.author.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(dateFormat.format(post.createdAt), style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(post.content, style: const TextStyle(fontSize: 16, height: 1.4)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: onLike,
                      child: Icon(
                        post.likedByMe ? Icons.favorite : Icons.favorite_border,
                        color: post.likedByMe ? const Color(0xFFEF4444) : Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text('${post.likes}'),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: onComment,
                      child: const Icon(Icons.comment_outlined, color: Colors.grey),
                    ),
                    const SizedBox(width: 6),
                    Text('${post.comments}'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
