import 'package:movieapp/features/Auth/data/models/register_request.dart';
import 'package:movieapp/features/Auth/data/models/register_response.dart';
import 'package:movieapp/features/Auth/data/models/login_request.dart';
import 'package:movieapp/features/Auth/data/models/login_response.dart';

abstract class AuthRemoteDataSources {
  Future<RegisterResponse> register(RegisterRequest registerRequest);
  Future<LoginResponse> login(LoginRequest loginRequest);
}
