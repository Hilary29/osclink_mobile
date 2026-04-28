import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/chat_models.dart';
import '../data/services/chat_mock_data.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<LoadConversationsEvent>(_onLoadConversations);
    on<LoadMessagesEvent>(_onLoadMessages);
    on<SendMessageEvent>(_onSendMessage);
  }

  Future<void> _onLoadConversations(
    LoadConversationsEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    await Future.delayed(const Duration(milliseconds: 300));
    emit(ConversationsLoaded(ChatMockData.getConversations()));
  }

  Future<void> _onLoadMessages(
    LoadMessagesEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    final conversations = ChatMockData.getConversations();
    final conversation = conversations.firstWhere(
      (c) => c.id == event.conversationId,
      orElse: () => conversations.first,
    );
    emit(MessagesLoaded(conversation, ChatMockData.getMessages(event.conversationId)));
  }

  void _onSendMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) {
    if (state is! MessagesLoaded) return;
    final current = state as MessagesLoaded;
    final newMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: ChatMockData.currentUserId,
      content: event.content,
      timestamp: DateTime.now(),
    );
    emit(MessagesLoaded(current.conversation, [...current.messages, newMessage]));
  }
}
