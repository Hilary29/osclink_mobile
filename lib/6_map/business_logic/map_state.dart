abstract class MapState {}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapLoaded extends MapState {
  final dynamic data;
  
  MapLoaded(this.data);
}

class MapError extends MapState {
  final String message;
  
  MapError(this.message);
}
