import 'package:movieapp/features/Profile/data/models/whatch_list_response.dart';

class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final WhatchListResponse data;
  AuthSuccess(this.data);
}

class AuthSuccessdelete extends AuthState {}

class Authloadingdelete extends AuthState {}

class AuthErrordlete extends AuthState {
  String error;
  AuthErrordlete(this.error);
}

class AuthError extends AuthState {
  String error;
  AuthError(this.error);
}
