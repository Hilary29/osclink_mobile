import '../models/post_model.dart';
import '../services/post_service.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts();
}

class PostRepositoryImpl implements PostRepository {
  final PostService _postService;

  PostRepositoryImpl({PostService? postService})
      : _postService = postService ?? PostService();

  @override
  Future<List<Post>> getPosts() async {
    return await _postService.fetchPosts();
  }
}
