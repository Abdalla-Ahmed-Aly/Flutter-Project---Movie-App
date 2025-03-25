import 'package:movieapp/features/Auth/data/models/get_data_response.dart';
import 'package:movieapp/features/Auth/data/models/reset_password_response.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}
class AuthRegisterLoading extends AuthState {}

class AuthSuccess extends AuthState {}
class AuthRegisterSuccess extends AuthState {}

class AuthLoginSuccess extends AuthState {
  final String token;
  AuthLoginSuccess(this.token);
}

class AuthDataSuccess extends AuthState {
  final GetDataResponse dataResponse;
  AuthDataSuccess(this.dataResponse);
}

class ResetPasswordSuccess extends AuthState {
  final ResetPasswordResponse resetPasswordResponse;
  ResetPasswordSuccess(this.resetPasswordResponse);
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}
class AuthRegisterError extends AuthState {
  final String message;

  AuthRegisterError(this.message);
}
