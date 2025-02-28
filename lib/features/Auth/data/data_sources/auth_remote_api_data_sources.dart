import 'package:dio/dio.dart';
import 'package:movieapp/core/constans.dart';
import 'package:movieapp/core/error/exception.dart';
import 'package:movieapp/features/Auth/data/data_sources/auth_remote_data_sources.dart';
import 'package:movieapp/features/Auth/data/models/register_request.dart';
import 'package:movieapp/features/Auth/data/models/register_response.dart';

class AuthRemoteApiDataSources implements AuthRemoteDataSources {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ConstansApi.BASE_URL,
    ),
  );

  @override
  Future<RegisterResponse> register(RegisterRequest registerRequest) async {
    try {
      final response = await _dio.post(
        ConstansApi.REGISTER,
        data: registerRequest.toJson(),
      );
      return RegisterResponse.fromJson(response.data);
    } on DioException catch (e) {
      String errorMessage = e.response?.data['message'] ?? 'An error occurred';
      throw RemoteException(errorMessage);
    }
  }
}
