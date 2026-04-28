import 'package:osclink_mobile/2_home/data/services/mock_data.dart';
import '../models/profile_model.dart';

class ProfileMockData {
  static UserProfile getCurrentUserProfile() {
    return UserProfile(
      id: 'me',
      name: 'Hilary D',
      username: '@hilary_osc',
      avatarUrl: 'https://i.pravatar.cc/150?img=10',
      coverUrl: 'https://picsum.photos/seed/osclink/800/300',
      isVerified: true,
      bio:
          'Civil Society Advocate · NGO Director · Building bridges between communities and policy makers 🌍',
      location: 'Yaoundé, Cameroun',
      website: 'osclink.org',
      joinedAt: DateTime(2023, 3, 15),
      postsCount: 142,
      followersCount: 2840,
      followingCount: 318,
      organizationType: 'ONG / Société Civile',
      posts: MockData.getPosts(),
    );
  }
}
