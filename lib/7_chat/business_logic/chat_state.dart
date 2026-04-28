import '../data/models/chat_models.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ConversationsLoaded extends ChatState {
  final List<ChatConversation> conversations;
  ConversationsLoaded(this.conversations);
}

class MessagesLoaded extends ChatState {
  final ChatConversation conversation;
  final List<ChatMessage> messages;
  MessagesLoaded(this.conversation, this.messages);
}

class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}
