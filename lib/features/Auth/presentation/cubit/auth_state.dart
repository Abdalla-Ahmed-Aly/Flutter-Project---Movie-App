import 'package:movieapp/features/Auth/data/models/get_data_response.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthLoginSuccess extends AuthState {
  final String token;
  AuthLoginSuccess(this.token);
}
class AuthDataSuccess extends AuthState {
  final GetDataResponse dataResponse;
  AuthDataSuccess(this.dataResponse);
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}
