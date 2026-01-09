import '../models/user_model.dart';
import '../models/post_model.dart';

class MockData {
  static final List<User> users = [
    User(
      id: '1',
      name: 'Martha Craig',
      username: '@craig_love',
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
      isVerified: false,
    ),
    User(
      id: '2',
      name: 'Maximmilian',
      username: '@maxjacobson',
      avatarUrl: 'https://i.pravatar.cc/150?img=2',
      isVerified: false,
    ),
    User(
      id: '3',
      name: 'Tabitha Potter',
      username: '@mis_potter',
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
      isVerified: true,
    ),
    User(
      id: '4',
      name: 'karennne',
      username: '@karennne',
      avatarUrl: 'https://i.pravatar.cc/150?img=4',
      isVerified: false,
    ),
  ];

  static List<Post> getPosts() {
    final now = DateTime.now();

    return [
      Post(
        id: '1',
        author: users[0],
        content:
            'UXR/UX: You can only bring one item to a remote island to assist your research of native use of tools and usability. What do you bring? #TellMeAboutYou',
        timestamp: now.subtract(const Duration(hours: 12)),
        commentsCount: 28,
        retweetsCount: 5,
        likesCount: 21,
        sharesCount: 0,
      ),
      Post(
        id: '2',
        author: users[1],
        content: 'Y\'all ready for this next post?',
        timestamp: now.subtract(const Duration(hours: 3)),
        commentsCount: 46,
        retweetsCount: 18,
        likesCount: 363,
        sharesCount: 0,
      ),
      Post(
        id: '3',
        author: users[2],
        content: '',
        mediaUrl: 'https://picsum.photos/400/300',
        timestamp: now.subtract(const Duration(hours: 14)),
        commentsCount: 7,
        retweetsCount: 1,
        likesCount: 11,
        sharesCount: 0,
      ),
      Post(
        id: '4',
        author: users[3],
        content:
            'Name a show where the lead character is the worst character on the show I\'ll get Sabrina Spellman',
        timestamp: now.subtract(const Duration(hours: 10)),
        commentsCount: 1906,
        retweetsCount: 1249,
        likesCount: 7461,
        sharesCount: 0,
      ),
    ];
  }
}
