import 'package:movieapp/features/Auth/data/models/data.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthSuccess extends AuthState {
  final Data userData; 

  AuthSuccess(this.userData);
}
class AuthLoading extends AuthState {}
class AuthError extends AuthState {
  final String message;

  AuthError(this.message);  
}
