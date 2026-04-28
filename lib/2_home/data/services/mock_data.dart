import '../models/user_model.dart';
import '../models/post_model.dart';

class MockData {
  static final List<User> users = [
    User(
      id: '1',
      name: 'Amara Diallo',
      username: '@amara_diallo',
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
      isVerified: false,
    ),
    User(
      id: '2',
      name: 'Kofi Mensah',
      username: '@kofi_mensah',
      avatarUrl: 'https://i.pravatar.cc/150?img=2',
      isVerified: false,
    ),
    User(
      id: '3',
      name: 'Fatou Ndiaye',
      username: '@fatou_ndiaye',
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
      isVerified: true,
    ),
    User(
      id: '4',
      name: 'Chioma Okafor',
      username: '@chioma_osc',
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
            'La société civile joue un rôle crucial dans la promotion des droits humains en Afrique de l\'Ouest. Comment renforcer notre impact collectif ? #OSCLink #SociétéCivile',
        timestamp: now.subtract(const Duration(hours: 12)),
        commentsCount: 28,
        retweetsCount: 5,
        likesCount: 21,
        sharesCount: 0,
      ),
      Post(
        id: '2',
        author: users[1],
        content:
            'Retour sur l\'atelier de renforcement des capacités des OSC au Ghana 🇬🇭 — des échanges enrichissants sur la gouvernance participative et la mobilisation communautaire.',
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
            'Quelle organisation de la société civile africaine a eu, selon vous, le plus grand impact ces 10 dernières années ? Partagez votre avis ! 🌍 #Afrique #OSC',
        timestamp: now.subtract(const Duration(hours: 10)),
        commentsCount: 1906,
        retweetsCount: 1249,
        likesCount: 7461,
        sharesCount: 0,
      ),
    ];
  }
}
