import 'user_model.dart';

class Post {
  final String id;
  final User author;
  final String content;
  final String? mediaUrl;
  final DateTime timestamp;
  final int commentsCount;
  final int retweetsCount;
  final int likesCount;
  final int sharesCount;
  final bool isLiked;
  final bool isRetweeted;

  Post({
    required this.id,
    required this.author,
    required this.content,
    this.mediaUrl,
    required this.timestamp,
    this.commentsCount = 0,
    this.retweetsCount = 0,
    this.likesCount = 0,
    this.sharesCount = 0,
    this.isLiked = false,
    this.isRetweeted = false,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as String,
      author: User.fromJson(json['author'] as Map<String, dynamic>),
      content: json['content'] as String,
      mediaUrl: json['mediaUrl'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
      commentsCount: json['commentsCount'] as int? ?? 0,
      retweetsCount: json['retweetsCount'] as int? ?? 0,
      likesCount: json['likesCount'] as int? ?? 0,
      sharesCount: json['sharesCount'] as int? ?? 0,
      isLiked: json['isLiked'] as bool? ?? false,
      isRetweeted: json['isRetweeted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author': author.toJson(),
      'content': content,
      'mediaUrl': mediaUrl,
      'timestamp': timestamp.toIso8601String(),
      'commentsCount': commentsCount,
      'retweetsCount': retweetsCount,
      'likesCount': likesCount,
      'sharesCount': sharesCount,
      'isLiked': isLiked,
      'isRetweeted': isRetweeted,
    };
  }

  Post copyWith({
    String? id,
    User? author,
    String? content,
    String? mediaUrl,
    DateTime? timestamp,
    int? commentsCount,
    int? retweetsCount,
    int? likesCount,
    int? sharesCount,
    bool? isLiked,
    bool? isRetweeted,
  }) {
    return Post(
      id: id ?? this.id,
      author: author ?? this.author,
      content: content ?? this.content,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      timestamp: timestamp ?? this.timestamp,
      commentsCount: commentsCount ?? this.commentsCount,
      retweetsCount: retweetsCount ?? this.retweetsCount,
      likesCount: likesCount ?? this.likesCount,
      sharesCount: sharesCount ?? this.sharesCount,
      isLiked: isLiked ?? this.isLiked,
      isRetweeted: isRetweeted ?? this.isRetweeted,
    );
  }

  @override
  String toString() {
    return 'Post(id: $id, author: $author, content: $content, timestamp: $timestamp)';
  }
}
