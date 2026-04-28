import 'package:osclink_mobile/2_home/data/models/user_model.dart';
import '../models/chat_models.dart';

class ChatMockData {
  static const String currentUserId = 'me';

  static List<ChatConversation> getConversations() {
    final now = DateTime.now();
    return [
      ChatConversation(
        id: 'c1',
        contact: User(
          id: '1',
          name: 'Martha Craig',
          username: '@craig_love',
          avatarUrl: 'https://i.pravatar.cc/150?img=1',
        ),
        lastMessage: 'Great to connect with you!',
        timestamp: now.subtract(const Duration(minutes: 5)),
        unreadCount: 2,
        isOnline: true,
      ),
      ChatConversation(
        id: 'c2',
        contact: User(
          id: '3',
          name: 'Tabitha Potter',
          username: '@mis_potter',
          avatarUrl: 'https://i.pravatar.cc/150?img=3',
          isVerified: true,
        ),
        lastMessage: 'Looking forward to the project!',
        timestamp: now.subtract(const Duration(hours: 1)),
        unreadCount: 0,
        isOnline: true,
      ),
      ChatConversation(
        id: 'c3',
        contact: User(
          id: '2',
          name: 'Maximmilian',
          username: '@maxjacobson',
          avatarUrl: 'https://i.pravatar.cc/150?img=2',
        ),
        lastMessage: 'Can we schedule a call?',
        timestamp: now.subtract(const Duration(hours: 3)),
        unreadCount: 1,
        isOnline: false,
      ),
      ChatConversation(
        id: 'c4',
        contact: User(
          id: '4',
          name: 'karennne',
          username: '@karennne',
          avatarUrl: 'https://i.pravatar.cc/150?img=4',
        ),
        lastMessage: 'Thanks for sharing that resource',
        timestamp: now.subtract(const Duration(days: 1)),
        unreadCount: 0,
        isOnline: false,
      ),
    ];
  }

  static List<ChatMessage> getMessages(String conversationId) {
    final now = DateTime.now();
    final Map<String, List<ChatMessage>> data = {
      'c1': [
        ChatMessage(
          id: 'm1',
          senderId: '1',
          content: 'Hi! I saw your post about civil society work',
          timestamp: now.subtract(const Duration(hours: 2)),
        ),
        ChatMessage(
          id: 'm2',
          senderId: currentUserId,
          content: "Hello Martha! Yes, I've been working on it for a while now",
          timestamp: now.subtract(const Duration(hours: 1, minutes: 55)),
        ),
        ChatMessage(
          id: 'm3',
          senderId: '1',
          content: "That's amazing! Would love to collaborate on something",
          timestamp: now.subtract(const Duration(hours: 1, minutes: 30)),
        ),
        ChatMessage(
          id: 'm4',
          senderId: currentUserId,
          content: 'Absolutely, let\'s connect and discuss the details',
          timestamp: now.subtract(const Duration(minutes: 10)),
        ),
        ChatMessage(
          id: 'm5',
          senderId: '1',
          content: 'Great to connect with you!',
          timestamp: now.subtract(const Duration(minutes: 5)),
        ),
      ],
      'c2': [
        ChatMessage(
          id: 'm1',
          senderId: '3',
          content: 'Hey, are you joining the OSC conference next month?',
          timestamp: now.subtract(const Duration(hours: 3)),
        ),
        ChatMessage(
          id: 'm2',
          senderId: currentUserId,
          content: 'Yes! I registered last week. Will you be there?',
          timestamp: now.subtract(const Duration(hours: 2, minutes: 45)),
        ),
        ChatMessage(
          id: 'm3',
          senderId: '3',
          content: 'Looking forward to the project!',
          timestamp: now.subtract(const Duration(hours: 1)),
        ),
      ],
      'c3': [
        ChatMessage(
          id: 'm1',
          senderId: currentUserId,
          content: 'Hi Maximmilian, great content you posted today!',
          timestamp: now.subtract(const Duration(hours: 5)),
        ),
        ChatMessage(
          id: 'm2',
          senderId: '2',
          content: 'Thank you! Really appreciate the feedback',
          timestamp: now.subtract(const Duration(hours: 4)),
        ),
        ChatMessage(
          id: 'm3',
          senderId: '2',
          content: 'Can we schedule a call?',
          timestamp: now.subtract(const Duration(hours: 3)),
        ),
      ],
    };

    return data[conversationId] ?? [
      ChatMessage(
        id: 'default1',
        senderId: 'other',
        content: 'Hello!',
        timestamp: now.subtract(const Duration(minutes: 30)),
      ),
      ChatMessage(
        id: 'default2',
        senderId: currentUserId,
        content: 'Hi there!',
        timestamp: now.subtract(const Duration(minutes: 25)),
      ),
    ];
  }
}
