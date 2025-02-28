import 'package:movieapp/features/Auth/data/data_sources/auth_remote_data_sources.dart';
import 'package:movieapp/features/Auth/data/models/data.dart';
import 'package:movieapp/features/Auth/data/models/register_request.dart';

class AuthRepository {
  final AuthRemoteDataSources _remoteDataSources;

  AuthRepository(this._remoteDataSources);

  Future<Data> register(RegisterRequest registerRequest) async {
   
      final registerResponse =
          await _remoteDataSources.register(registerRequest);

      return registerResponse.data!;
    }
}
