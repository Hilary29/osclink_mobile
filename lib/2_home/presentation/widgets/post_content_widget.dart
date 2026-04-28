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
              fontSize: 16,
              height: 1.25,
              color: Color(0xFF141619),
              letterSpacing: -0.3,
            ),
          ),
        if (mediaUrl != null) ...[
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                mediaUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFFCED5DC),
                  child: const Icon(Icons.image_outlined,
                      size: 48, color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
