import 'package:movieapp/features/Update_Profile/data/models/update_data_request.dart';

class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}


class AuthUpdateSuccess extends AuthState {
  final UpdateDataResponse dataResponse;
  AuthUpdateSuccess(this.dataResponse);
}
class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}