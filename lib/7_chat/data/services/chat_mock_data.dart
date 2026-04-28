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
          name: 'Amara Diallo',
          username: '@amara_diallo',
          avatarUrl: 'https://i.pravatar.cc/150?img=1',
        ),
        lastMessage: 'Ravi d\'être en contact avec vous !',
        timestamp: now.subtract(const Duration(minutes: 5)),
        unreadCount: 2,
        isOnline: true,
      ),
      ChatConversation(
        id: 'c2',
        contact: User(
          id: '3',
          name: 'Fatou Ndiaye',
          username: '@fatou_ndiaye',
          avatarUrl: 'https://i.pravatar.cc/150?img=3',
          isVerified: true,
        ),
        lastMessage: 'Impatiente de démarrer le projet !',
        timestamp: now.subtract(const Duration(hours: 1)),
        unreadCount: 0,
        isOnline: true,
      ),
      ChatConversation(
        id: 'c3',
        contact: User(
          id: '2',
          name: 'Kofi Mensah',
          username: '@kofi_mensah',
          avatarUrl: 'https://i.pravatar.cc/150?img=2',
        ),
        lastMessage: 'On peut prévoir un appel cette semaine ?',
        timestamp: now.subtract(const Duration(hours: 3)),
        unreadCount: 1,
        isOnline: false,
      ),
      ChatConversation(
        id: 'c4',
        contact: User(
          id: '4',
          name: 'Chioma Okafor',
          username: '@chioma_osc',
          avatarUrl: 'https://i.pravatar.cc/150?img=4',
        ),
        lastMessage: 'Merci pour le partage de cette ressource',
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
          content: 'Bonjour ! J\'ai vu votre publication sur le travail de la société civile',
          timestamp: now.subtract(const Duration(hours: 2)),
        ),
        ChatMessage(
          id: 'm2',
          senderId: currentUserId,
          content: 'Bonjour Amara ! Oui, je travaille dessus depuis un moment maintenant',
          timestamp: now.subtract(const Duration(hours: 1, minutes: 55)),
        ),
        ChatMessage(
          id: 'm3',
          senderId: '1',
          content: 'C\'est formidable ! J\'aimerais beaucoup collaborer sur quelque chose',
          timestamp: now.subtract(const Duration(hours: 1, minutes: 30)),
        ),
        ChatMessage(
          id: 'm4',
          senderId: currentUserId,
          content: 'Absolument, connectons-nous pour discuter des détails',
          timestamp: now.subtract(const Duration(minutes: 10)),
        ),
        ChatMessage(
          id: 'm5',
          senderId: '1',
          content: 'Ravi d\'être en contact avec vous !',
          timestamp: now.subtract(const Duration(minutes: 5)),
        ),
      ],
      'c2': [
        ChatMessage(
          id: 'm1',
          senderId: '3',
          content: 'Participez-vous à la conférence OSC du mois prochain ?',
          timestamp: now.subtract(const Duration(hours: 3)),
        ),
        ChatMessage(
          id: 'm2',
          senderId: currentUserId,
          content: 'Oui ! Je me suis inscrit la semaine dernière. Et vous ?',
          timestamp: now.subtract(const Duration(hours: 2, minutes: 45)),
        ),
        ChatMessage(
          id: 'm3',
          senderId: '3',
          content: 'Impatiente de démarrer le projet !',
          timestamp: now.subtract(const Duration(hours: 1)),
        ),
      ],
      'c3': [
        ChatMessage(
          id: 'm1',
          senderId: currentUserId,
          content: 'Bonjour Kofi, excellent contenu publié aujourd\'hui !',
          timestamp: now.subtract(const Duration(hours: 5)),
        ),
        ChatMessage(
          id: 'm2',
          senderId: '2',
          content: 'Merci beaucoup ! J\'apprécie vraiment le retour',
          timestamp: now.subtract(const Duration(hours: 4)),
        ),
        ChatMessage(
          id: 'm3',
          senderId: '2',
          content: 'On peut prévoir un appel cette semaine ?',
          timestamp: now.subtract(const Duration(hours: 3)),
        ),
      ],
    };

    return data[conversationId] ?? [
      ChatMessage(
        id: 'default1',
        senderId: 'other',
        content: 'Bonjour !',
        timestamp: now.subtract(const Duration(minutes: 30)),
      ),
      ChatMessage(
        id: 'default2',
        senderId: currentUserId,
        content: 'Bonjour, comment puis-je vous aider ?',
        timestamp: now.subtract(const Duration(minutes: 25)),
      ),
    ];
  }
}
