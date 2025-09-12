abstract class AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;
  
  AuthLoginEvent(this.email, this.password);
}

class AuthRegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;
  
  AuthRegisterEvent(this.email, this.password, this.name);
}

class AuthLogoutEvent extends AuthEvent {}