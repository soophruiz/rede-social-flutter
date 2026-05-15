// Thomas e Sophia DEVB
import 'package:flutter/material.dart';
import '../widgets/app_state.dart';

class CommentItem extends StatelessWidget {
  final Comment comment;
  final VoidCallback? onLike;

  const CommentItem({
    super.key,
    required this.comment,
    this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.grey[300],
            child: Text(
              comment.userName[0].toUpperCase(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
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
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    comment.content,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          if (onLike != null)
            IconButton(
              icon: Icon(
                comment.likes.isNotEmpty ? Icons.favorite : Icons.favorite_border,
                size: 18,
                color: comment.likes.isNotEmpty ? Colors.red : Colors.grey,
              ),
              onPressed: onLike,
            ),
        ],
      ),
    );
  }
}
