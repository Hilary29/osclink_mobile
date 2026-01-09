import 'package:flutter/material.dart';

class PostActionsWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    const iconColor = Color(0xFF687684);
    const textStyle = TextStyle(
      fontSize: 12,
      color: Color(0xFF687684),
      letterSpacing: -0.3,
    );

    return Row(
      children: [
        Expanded(
          child: _ActionButton(
            icon: Icons.chat_bubble_outline,
            count: commentsCount,
            iconColor: iconColor,
            textStyle: textStyle,
          ),
        ),
        Expanded(
          child: _ActionButton(
            icon: Icons.repeat,
            count: retweetsCount,
            iconColor: isRetweeted ? Colors.green : iconColor,
            textStyle: textStyle,
          ),
        ),
        Expanded(
          child: _ActionButton(
            icon: isLiked ? Icons.favorite : Icons.favorite_border,
            count: likesCount,
            iconColor: isLiked ? Colors.red : iconColor,
            textStyle: textStyle,
          ),
        ),
        Expanded(
          child: _ActionButton(
            icon: Icons.share_outlined,
            count: sharesCount,
            iconColor: iconColor,
            textStyle: textStyle,
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String count;
  final Color iconColor;
  final TextStyle textStyle;

  const _ActionButton({
    required this.icon,
    required this.count,
    required this.iconColor,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: iconColor),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            count,
            style: textStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
