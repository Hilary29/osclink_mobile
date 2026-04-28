import 'package:flutter/material.dart';
import 'package:osclink_mobile/1_common/presentation/themes/app_dimens.dart';
import '../../data/models/post_model.dart';
import 'post_header_widget.dart';
import 'post_content_widget.dart';
import 'post_actions_widget.dart';

class PostCardWidget extends StatelessWidget {
  final Post post;

  const PostCardWidget({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFCED5DC), width: 0.33),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.horizontalPadding(context),
        vertical: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostHeaderWidget(
            author: post.author,
            timeAgo: post.getTimeAgo(),
          ),
          const SizedBox(height: 12),
          PostContentWidget(
            content: post.content,
            mediaUrl: post.mediaUrl,
          ),
          const SizedBox(height: 12),
          PostActionsWidget(
            commentsCount: post.commentsCount.toString(),
            retweetsCount: post.retweetsCount.toString(),
            likesCount: post.likesCount.toString(),
            sharesCount: post.sharesCount.toString(),
            isLiked: post.isLiked,
            isRetweeted: post.isRetweeted,
          ),
        ],
      ),
    );
  }
}
