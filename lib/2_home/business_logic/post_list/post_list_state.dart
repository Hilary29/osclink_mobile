part of 'post_list_bloc.dart';

abstract class PostListState {}

class PostListInitial extends PostListState {}

class PostListLoading extends PostListState {}

class PostListLoaded extends PostListState {
  final List<Post> posts;

  PostListLoaded(this.posts);
}

class PostListError extends PostListState {
  final String message;

  PostListError(this.message);
}
