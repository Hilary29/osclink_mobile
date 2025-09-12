abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final dynamic data;
  
  ChatLoaded(this.data);
}

class ChatError extends ChatState {
  final String message;
  
  ChatError(this.message);
}
