import 'package:movieapp/features/Auth/data/data_sources/auth_remote_data_sources.dart';
import 'package:movieapp/features/Auth/data/models/data.dart';
import 'package:movieapp/features/Auth/data/models/get_data_response.dart';
import 'package:movieapp/features/Auth/data/models/register_request.dart';
import 'package:movieapp/features/Auth/data/models/login_request.dart';
import 'package:movieapp/features/Auth/data/models/login_response.dart';

class AuthRepository {
  final AuthRemoteDataSources _remoteDataSources;

  AuthRepository(this._remoteDataSources);

  Future<Data> register(RegisterRequest registerRequest) async {
    final registerResponse = await _remoteDataSources.register(registerRequest);
    return registerResponse.data!;
  }

  Future<LoginResponse> login(LoginRequest loginRequest) async {
    final loginResponse = await _remoteDataSources.login(loginRequest);
    return loginResponse;
  }

  Future<GetDataResponse> getData() async {
    final getDataResponse = await _remoteDataSources.getData();
    return getDataResponse;
  }
}
