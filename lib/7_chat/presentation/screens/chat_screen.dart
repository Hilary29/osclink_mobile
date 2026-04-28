import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osclink_mobile/1_common/presentation/themes/app_colors.dart';
import '../../business_logic/chat_bloc.dart';
import '../../business_logic/chat_event.dart';
import '../../business_logic/chat_state.dart';
import '../../data/models/chat_models.dart';
import '../widgets/conversation_tile.dart';
import '../widgets/message_bubble.dart';

// ─────────────────────────────────────────────
// ChatScreen — Liste des conversations
// ─────────────────────────────────────────────

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(LoadConversationsEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openConversation(BuildContext context, ChatConversation conv) {
    final bloc = context.read<ChatBloc>();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: bloc,
          child: ChatDetailScreen(conversationId: conv.id),
        ),
      ),
    ).then((_) {
      if (!mounted) return;
      bloc.add(LoadConversationsEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Messages'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Nouveau message',
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _SearchBar(
            controller: _searchController,
            onChanged: (v) => setState(() => _searchQuery = v.toLowerCase()),
          ),
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading || state is ChatInitial) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }

                if (state is ChatError) {
                  return _ErrorView(message: state.message);
                }

                if (state is ConversationsLoaded) {
                  final conversations = _searchQuery.isEmpty
                      ? state.conversations
                      : state.conversations
                          .where((c) =>
                              c.contact.name
                                  .toLowerCase()
                                  .contains(_searchQuery) ||
                              c.lastMessage
                                  .toLowerCase()
                                  .contains(_searchQuery))
                          .toList();

                  if (conversations.isEmpty) {
                    return const Center(
                      child: Text(
                        'Aucune conversation trouvée',
                        style: TextStyle(color: Color(0xFF757575)),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: conversations.length,
                    itemBuilder: (context, index) {
                      return ConversationTile(
                        conversation: conversations[index],
                        onTap: () =>
                            _openConversation(context, conversations[index]),
                      );
                    },
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _SearchBar({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Rechercher une conversation...',
          hintStyle:
              const TextStyle(color: Color(0xFF757575), fontSize: 14),
          prefixIcon: const Icon(Icons.search, color: Color(0xFF757575), size: 20),
          filled: true,
          fillColor: AppColors.background,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;

  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(message, style: const TextStyle(color: Color(0xFF757575))),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// ChatDetailScreen — Conversation individuelle
// ─────────────────────────────────────────────

class ChatDetailScreen extends StatefulWidget {
  final String conversationId;

  const ChatDetailScreen({super.key, required this.conversationId});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _canSend = false;

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(LoadMessagesEvent(widget.conversationId));
    _messageController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final canSend = _messageController.text.trim().isNotEmpty;
    if (canSend != _canSend) setState(() => _canSend = canSend);
  }

  void _sendMessage() {
    final content = _messageController.text.trim();
    if (content.isEmpty) return;
    context
        .read<ChatBloc>()
        .add(SendMessageEvent(widget.conversationId, content));
    _messageController.clear();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _scrollToBottom());
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is MessagesLoaded) {
          WidgetsBinding.instance
              .addPostFrameCallback((_) => _scrollToBottom());
        }
      },
      builder: (context, state) {
        final conversation =
            state is MessagesLoaded ? state.conversation : null;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            titleSpacing: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 18),
              onPressed: () => Navigator.pop(context),
            ),
            title: conversation != null
                ? _AppBarTitle(conversation: conversation)
                : const SizedBox(),
            actions: [
              IconButton(
                icon: const Icon(Icons.videocam_outlined),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.phone_outlined),
                onPressed: () {},
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(child: _buildMessagesList(state)),
              _MessageInputBar(
                controller: _messageController,
                canSend: _canSend,
                onSend: _sendMessage,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMessagesList(ChatState state) {
    if (state is MessagesLoaded) {
      if (state.messages.isEmpty) {
        return const Center(
          child: Text(
            'Commencez la conversation !',
            style: TextStyle(color: Color(0xFF757575)),
          ),
        );
      }
      return ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: state.messages.length,
        itemBuilder: (context, index) =>
            MessageBubble(message: state.messages[index]),
      );
    }
    return const Center(
      child: CircularProgressIndicator(color: AppColors.primary),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  final ChatConversation conversation;

  const _AppBarTitle({required this.conversation});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage:
                  NetworkImage(conversation.contact.avatarUrl),
              backgroundColor: const Color(0xFFCED5DC),
            ),
            if (conversation.isOnline)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                conversation.contact.name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF141619),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                conversation.isOnline ? 'En ligne' : 'Hors ligne',
                style: TextStyle(
                  fontSize: 11,
                  color: conversation.isOnline
                      ? AppColors.primary
                      : const Color(0xFF757575),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MessageInputBar extends StatelessWidget {
  final TextEditingController controller;
  final bool canSend;
  final VoidCallback onSend;

  const _MessageInputBar({
    required this.controller,
    required this.canSend,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom > 0 ? 8.0 : 20.0;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
          left: 8, right: 8, top: 8, bottom: bottomPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline,
                color: Color(0xFF757575)),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: controller,
              minLines: 1,
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: 'Écrire un message...',
                hintStyle: const TextStyle(
                    color: Color(0xFF757575), fontSize: 14),
                filled: true,
                fillColor: AppColors.background,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: canSend
                ? IconButton(
                    key: const ValueKey('send'),
                    icon: const Icon(Icons.send_rounded,
                        color: AppColors.primary),
                    onPressed: onSend,
                  )
                : IconButton(
                    key: const ValueKey('mic'),
                    icon: const Icon(Icons.mic_outlined,
                        color: Color(0xFF757575)),
                    onPressed: () {},
                  ),
          ),
        ],
      ),
    );
  }
}
