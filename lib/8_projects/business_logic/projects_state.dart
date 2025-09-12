abstract class ProjectsState {}

class ProjectsInitial extends ProjectsState {}

class ProjectsLoading extends ProjectsState {}

class ProjectsLoaded extends ProjectsState {
  final dynamic data;
  
  ProjectsLoaded(this.data);
}

class ProjectsError extends ProjectsState {
  final String message;
  
  ProjectsError(this.message);
}
