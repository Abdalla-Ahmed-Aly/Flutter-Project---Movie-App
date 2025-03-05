import 'package:movieapp/features/Update_Profile/data/models/update_data_request.dart';

class UpdateAuthState {}

class UpdateAuthInitial extends UpdateAuthState {}

class UpdateAuthLoading extends UpdateAuthState {}

class UpdateAuthUpdateSuccess extends UpdateAuthState {
  final UpdateDataResponse dataResponse;
  UpdateAuthUpdateSuccess(this.dataResponse);
}

class UpdateAuthdeletSuccess extends UpdateAuthState {}

class UpdateAuthError extends UpdateAuthState {
  final String message;

  UpdateAuthError(this.message);
}
