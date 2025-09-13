import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        automaticallyImplyLeading: false,
      ),
      body: const Center(
        child: Text('Chat Screen'),
      ),
    );
  }
}

class ChatDetailScreen extends StatelessWidget {
  final String chatId;

  const ChatDetailScreen({
    super.key,
    required this.chatId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat $chatId'),
      ),
      body: Center(
        child: Text('Chat Detail Screen for ID: $chatId'),
      ),
    );
  }
}