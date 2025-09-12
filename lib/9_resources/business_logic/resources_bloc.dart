import 'package:flutter_bloc/flutter_bloc.dart';
import 'resources_event.dart';
import 'resources_state.dart';

class ResourcesBloc extends Bloc<ResourcesEvent, ResourcesState> {
  ResourcesBloc() : super(ResourcesInitial()) {
    on<ResourcesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
