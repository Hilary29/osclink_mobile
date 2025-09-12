abstract class ResourcesState {}

class ResourcesInitial extends ResourcesState {}

class ResourcesLoading extends ResourcesState {}

class ResourcesLoaded extends ResourcesState {
  final dynamic data;
  
  ResourcesLoaded(this.data);
}

class ResourcesError extends ResourcesState {
  final String message;
  
  ResourcesError(this.message);
}
