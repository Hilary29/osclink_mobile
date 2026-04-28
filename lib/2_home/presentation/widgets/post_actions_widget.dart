import 'package:flutter/material.dart';

class PostActionsWidget extends StatefulWidget {
  final String commentsCount;
  final String retweetsCount;
  final String likesCount;
  final String sharesCount;
  final bool isLiked;
  final bool isRetweeted;

  const PostActionsWidget({
    super.key,
    required this.commentsCount,
    required this.retweetsCount,
    required this.likesCount,
    required this.sharesCount,
    this.isLiked = false,
    this.isRetweeted = false,
  });

  @override
  State<PostActionsWidget> createState() => _PostActionsWidgetState();
}

class _PostActionsWidgetState extends State<PostActionsWidget> {
  late bool _isLiked;
  late bool _isRetweeted;
  late int _likesCount;
  late int _retweetsCount;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.isLiked;
    _isRetweeted = widget.isRetweeted;
    _likesCount = int.tryParse(widget.likesCount) ?? 0;
    _retweetsCount = int.tryParse(widget.retweetsCount) ?? 0;
  }

  void _toggleLike() =>
      setState(() {
        _isLiked = !_isLiked;
        _likesCount += _isLiked ? 1 : -1;
      });

  void _toggleRetweet() =>
      setState(() {
        _isRetweeted = !_isRetweeted;
        _retweetsCount += _isRetweeted ? 1 : -1;
      });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ActionButton(
            icon: Icons.chat_bubble_outline,
            count: widget.commentsCount,
            color: const Color(0xFF687684),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: _toggleRetweet,
            behavior: HitTestBehavior.opaque,
            child: _ActionButton(
              icon: Icons.repeat,
              count: _format(_retweetsCount),
              color: _isRetweeted ? Colors.green : const Color(0xFF687684),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: _toggleLike,
            behavior: HitTestBehavior.opaque,
            child: _ActionButton(
              icon: _isLiked ? Icons.favorite : Icons.favorite_border,
              count: _format(_likesCount),
              color: _isLiked ? Colors.red : const Color(0xFF687684),
            ),
          ),
        ),
        Expanded(
          child: _ActionButton(
            icon: Icons.share_outlined,
            count: widget.sharesCount,
            color: const Color(0xFF687684),
          ),
        ),
      ],
    );
  }

  String _format(int n) => n >= 1000 ? '${(n / 1000).toStringAsFixed(1)}k' : '$n';
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String count;
  final Color color;

  const _ActionButton({
    required this.icon,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 150),
          child: Icon(icon, key: ValueKey(icon), size: 15, color: color),
        ),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            count,
            style: TextStyle(
              fontSize: 12,
              color: color,
              letterSpacing: -0.3,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
