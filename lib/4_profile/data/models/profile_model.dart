import 'package:osclink_mobile/2_home/data/models/post_model.dart';
import 'package:osclink_mobile/2_home/data/models/user_model.dart';

class UserProfile {
  final String id;
  final String name;
  final String username;
  final String avatarUrl;
  final String? coverUrl;
  final bool isVerified;
  final String bio;
  final String? location;
  final String? website;
  final DateTime joinedAt;
  final int postsCount;
  final int followersCount;
  final int followingCount;
  final String organizationType;
  final List<Post> posts;

  const UserProfile({
    required this.id,
    required this.name,
    required this.username,
    required this.avatarUrl,
    this.coverUrl,
    this.isVerified = false,
    required this.bio,
    this.location,
    this.website,
    required this.joinedAt,
    required this.postsCount,
    required this.followersCount,
    required this.followingCount,
    required this.organizationType,
    required this.posts,
  });

  User toUser() => User(
        id: id,
        name: name,
        username: username,
        avatarUrl: avatarUrl,
        isVerified: isVerified,
      );

  UserProfile copyWith({
    String? name,
    String? bio,
    String? location,
    String? website,
    String? avatarUrl,
    String? coverUrl,
  }) {
    return UserProfile(
      id: id,
      name: name ?? this.name,
      username: username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      coverUrl: coverUrl ?? this.coverUrl,
      isVerified: isVerified,
      bio: bio ?? this.bio,
      location: location ?? this.location,
      website: website ?? this.website,
      joinedAt: joinedAt,
      postsCount: postsCount,
      followersCount: followersCount,
      followingCount: followingCount,
      organizationType: organizationType,
      posts: posts,
    );
  }
}
