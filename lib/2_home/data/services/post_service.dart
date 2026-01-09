import '../models/post_model.dart';
import 'mock_data.dart';

class PostService {
  Future<List<Post>> fetchPosts() async {
    return MockData.getPosts();
  }
}
