import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osclink_mobile/2_home/data/models/post_model.dart';
import '../../data/repositories/post_repository.dart';

part 'post_list_event.dart';
part 'post_list_state.dart';
class PostListBloc extends Bloc<PostListEvent, PostListState> {
  final PostRepository _repository;

  PostListBloc({PostRepository? repository})
      : _repository = repository ?? PostRepositoryImpl(),
        super(PostListInitial()) {
    on<LoadPostsEvent>(_onLoadPosts);
  }

  Future<void> _onLoadPosts(
    LoadPostsEvent event,
    Emitter<PostListState> emit,
  ) async {
    emit(PostListLoading());

    try {
      final posts = await _repository.getPosts();
      emit(PostListLoaded(posts));
    } catch (e) {
      emit(PostListError(e.toString()));
    }
  }
}
