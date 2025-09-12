import 'package:flutter_bloc/flutter_bloc.dart';
import 'common_event.dart';
import 'common_state.dart';

class CommonBloc extends Bloc<CommonEvent, CommonState> {
  CommonBloc() : super(CommonInitial()) {
    on<CommonEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}