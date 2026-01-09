import 'package:flutter/material.dart';

class PostContentWidget extends StatelessWidget {
  final String content;
  final String? mediaUrl;

  const PostContentWidget({
    super.key,
    required this.content,
    this.mediaUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (content.isNotEmpty)
          Text(
            content,
            style: const TextStyle(
              fontFamily: 'SF Pro Text',
              fontSize: 16,
              height: 1.25,
              color: Color(0xFF141619),
              letterSpacing: -0.3,
            ),
          ),
        if (mediaUrl != null) ...[
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              mediaUrl!,
              width: 232,
              height: 169,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 232,
                  height: 169,
                  color: const Color(0xFFCED5DC),
                  child: const Icon(Icons.image, size: 50, color: Colors.grey),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}
