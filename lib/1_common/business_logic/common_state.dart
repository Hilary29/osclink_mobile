abstract class CommonState {}

class CommonInitial extends CommonState {}

class CommonLoading extends CommonState {}

class CommonError extends CommonState {
  final String message;
  
  CommonError(this.message);
}

class CommonSuccess extends CommonState {}