import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/error/exception.dart';
import 'package:movieapp/features/Auth/data/data_sources/auth_remote_api_data_sources.dart';
import 'package:movieapp/features/Auth/data/models/data.dart';
import 'package:movieapp/features/Auth/data/models/get_data_response.dart';
import 'package:movieapp/features/Auth/data/models/register_request.dart';
import 'package:movieapp/features/Auth/data/models/login_request.dart';

import 'package:movieapp/features/Auth/data/repositories/auth_repository.dart';
import 'package:movieapp/features/Auth/presentation/cubit/auth_state.dart';
import 'package:movieapp/features/onboarding/services/sharedpreferencekeys.dart';
import 'package:movieapp/features/onboarding/services/sharedpreferences.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final AuthRepository _authRepository =
      AuthRepository(AuthRemoteApiDataSources());

  Data? userData;
  String? token;
  String? message;
  GetDataResponse? data;

  Future<void> register(RegisterRequest registerRequest) async {
    try {
      emit(AuthLoading());
      userData = await _authRepository.register(registerRequest);
      emit(AuthSuccess());
    } on AppException catch (e) {
      emit(AuthError(e.message));
      // rethrow;
    }
  }
  Future<void> getData() async {
    try {
      emit(AuthLoading());
      data = await _authRepository.getData();
      emit(AuthDataSuccess(data!));
    } on AppException catch (e) {
      emit(AuthError(e.message));
      // rethrow;
    }
  }

  Future<void> login(LoginRequest loginRequest) async {
    try {
      emit(AuthLoading());
      final loginResponse = await _authRepository.login(loginRequest);
      await LocalStorageServices.setString(
        LocalStorageKeys.authToken,
        loginResponse.token,
      );
      token = loginResponse.token;
      message = loginResponse.message;

      emit(AuthLoginSuccess(token!));
    } on AppException catch (e) {
      emit(AuthError(e.message));
      // rethrow;
    }
  }

  Future<void> initializeAuth() async {
    emit(AuthLoading()); // Optional: Show loading during check
    final storedToken =
        LocalStorageServices.getString(LocalStorageKeys.authToken);
    if (storedToken != null && storedToken.isNotEmpty) {
      token = storedToken;
      emit(AuthLoginSuccess(storedToken));
    } else {
      emit(AuthError(
          'No token found')); // Trigger navigation to login/onboarding
    }
  }

  Future<void> logout() async {
    await LocalStorageServices.setString(LocalStorageKeys.authToken, '');
    token = null;
    userData = null;
    emit(AuthInitial());
  }
}
