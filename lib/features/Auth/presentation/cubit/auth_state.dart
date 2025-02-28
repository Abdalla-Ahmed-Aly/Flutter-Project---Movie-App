
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthSuccess extends AuthState {

  AuthSuccess();
}
class AuthLoading extends AuthState {}
class AuthError extends AuthState {
  final String message;

  AuthError(this.message);  
}
