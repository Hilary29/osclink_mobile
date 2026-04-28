import 'package:osclink_mobile/2_home/data/models/user_model.dart';

class ChatConversation {
  final String id;
  final User contact;
  final String lastMessage;
  final DateTime timestamp;
  final int unreadCount;
  final bool isOnline;

  const ChatConversation({
    required this.id,
    required this.contact,
    required this.lastMessage,
    required this.timestamp,
    required this.unreadCount,
    this.isOnline = false,
  });

  String getTimeAgo() {
    final diff = DateTime.now().difference(timestamp);
    if (diff.inMinutes < 1) return 'maintenant';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    if (diff.inDays < 7) return '${diff.inDays}j';
    return '${timestamp.day}/${timestamp.month}';
  }
}

class ChatMessage {
  final String id;
  final String senderId;
  final String content;
  final DateTime timestamp;

  const ChatMessage({
    required this.id,
    required this.senderId,
    required this.content,
    required this.timestamp,
  });
}
