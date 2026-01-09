import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';

class PostHeaderWidget extends StatelessWidget {
  final User author;
  final String timeAgo;

  const PostHeaderWidget({
    super.key,
    required this.author,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 27.5,
          backgroundImage: NetworkImage(author.avatarUrl),
          backgroundColor: const Color(0xFFCED5DC),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Row(
            children: [
              Flexible(
                child: Text(
                  author.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF141619),
                    letterSpacing: -0.3,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (author.isVerified) ...[
                const SizedBox(width: 4),
                Container(
                  width: 14,
                  height: 14,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4C9EEB),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 10,
                    color: Colors.white,
                  ),
                ),
              ],
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  '${author.username} · $timeAgo',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF687684),
                    letterSpacing: -0.3,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        Icon(
          Icons.keyboard_arrow_down,
          size: 18,
          color: const Color(0xFFBDC5CD),
        ),
      ],
    );
  }
}
