import 'package:movieapp/features/Auth/data/models/register_request.dart';
import 'package:movieapp/features/Auth/data/models/register_response.dart';

abstract class AuthRemoteDataSources {
  Future<RegisterResponse> register(RegisterRequest registerRequest);
}
