abstract class FeedState {}

class FeedInitial extends FeedState {}

class FeedLoading extends FeedState {}

class FeedLoaded extends FeedState {
  final dynamic data;
  
  FeedLoaded(this.data);
}

class FeedError extends FeedState {
  final String message;
  
  FeedError(this.message);
}
