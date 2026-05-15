import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../app_state.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final notifications = state.notifications;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Notificações',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (notifications.any((n) => !n.isRead))
                TextButton(
                  onPressed: () => state.markAllNotificationsRead(),
                  child: const Text('Marcar todas como lidas'),
                ),
            ],
          ),
        ),
        Expanded(
          child: notifications.isEmpty
              ? const Center(child: Text('Nenhuma notificação'))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final item = notifications[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      color: item.isRead ? Colors.white : const Color(0xFFEFF6FF),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: _getNotificationColor(item.type),
                          child: Icon(
                            _getNotificationIcon(item.type),
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        title: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(text: item.fromUserName),
                              const TextSpan(
                                text: ' ',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              ),
                              TextSpan(
                                text: item.content ?? '',
                                style: const TextStyle(fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                        subtitle: Text(
                          _formatTimeAgo(item.timestamp),
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                          ),
                        ),
                        onTap: () => state.markNotificationRead(item.id),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'like':
        return Icons.favorite;
      case 'comment':
        return Icons.comment;
      case 'follow':
        return Icons.person_add;
      case 'mention':
        return Icons.alternate_email;
      default:
        return Icons.notifications;
    }
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case 'like':
        return Colors.red;
      case 'comment':
        return Colors.blue;
      case 'follow':
        return Colors.green;
      case 'mention':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 7) {
      return DateFormat('dd/MM/yy').format(dateTime);
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