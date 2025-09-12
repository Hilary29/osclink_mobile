import 'package:flutter_bloc/flutter_bloc.dart';
import 'projects_event.dart';
import 'projects_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  ProjectsBloc() : super(ProjectsInitial()) {
    on<ProjectsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
