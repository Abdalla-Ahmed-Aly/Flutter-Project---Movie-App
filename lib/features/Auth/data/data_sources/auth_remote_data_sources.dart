import 'package:movieapp/features/Auth/data/models/get_data_response.dart';
import 'package:movieapp/features/Auth/data/models/register_request.dart';
import 'package:movieapp/features/Auth/data/models/register_response.dart';
import 'package:movieapp/features/Auth/data/models/login_request.dart';
import 'package:movieapp/features/Auth/data/models/login_response.dart';
import 'package:movieapp/features/Auth/data/models/reset_password_request.dart';
import 'package:movieapp/features/Auth/data/models/reset_password_response.dart';

abstract class AuthRemoteDataSources {
  Future<RegisterResponse> register(RegisterRequest registerRequest);
  Future<LoginResponse> login(LoginRequest loginRequest);
  Future<GetDataResponse> getData();
  Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest resetPasswordRequest);
}
