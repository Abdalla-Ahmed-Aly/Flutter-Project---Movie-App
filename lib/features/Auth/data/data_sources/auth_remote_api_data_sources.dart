import 'package:dio/dio.dart';
import 'package:movieapp/core/constans.dart';
import 'package:movieapp/core/error/exception.dart';
import 'package:movieapp/features/Auth/data/data_sources/auth_remote_data_sources.dart';
import 'package:movieapp/features/Auth/data/models/get_data_response.dart';
import 'package:movieapp/features/Auth/data/models/register_request.dart';
import 'package:movieapp/features/Auth/data/models/register_response.dart';
import 'package:movieapp/features/Auth/data/models/login_request.dart';
import 'package:movieapp/features/Auth/data/models/login_response.dart';
import 'package:movieapp/features/Auth/data/models/reset_password_request.dart';
import 'package:movieapp/features/Auth/data/models/reset_password_response.dart';
import 'package:movieapp/features/onboarding/services/sharedpreferencekeys.dart';
import 'package:movieapp/features/onboarding/services/sharedpreferences.dart';

class AuthRemoteApiDataSources implements AuthRemoteDataSources {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ConstansApi.BASE_URL,
    ),
  );

  AuthRemoteApiDataSources() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final token =
            LocalStorageServices.getString(LocalStorageKeys.authToken);
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));
  }

  @override
  Future<RegisterResponse> register(RegisterRequest registerRequest) async {
    try {
      final response = await _dio.post(
        ConstansApi.REGISTER,
        data: registerRequest.toJson(),
      );
      return RegisterResponse.fromJson(response.data);
    } on DioException catch (e) {
      final dynamic errorData = e.response?.data;
      String errorMessage = 'An error occurred';
      if (errorData is Map<String, dynamic>) {
        final messages = errorData['message'];

        if (messages is List) {
          errorMessage = messages.join(', ');
        } else if (messages is String) {
          errorMessage = messages;
        }
      }
      throw RemoteException(errorMessage);
    }
  }

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    try {
      final response = await _dio.post(
        ConstansApi.LOGIN,
        data: loginRequest.toJson(),
      );
      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      final dynamic errorData = e.response?.data;
      String errorMessage = 'An error occurred';
      if (errorData is Map<String, dynamic>) {
        final messages = errorData['message'];

        if (messages is List) {
          errorMessage = messages.join(', ');
        } else if (messages is String) {
          errorMessage = messages;
        }
      }
      throw RemoteException(errorMessage);
    }
  }

  @override
  Future<GetDataResponse> getData() async {
    try {
      final response = await _dio.get(ConstansApi.GET_DATA);
      return GetDataResponse.fromJson(response.data);
    } on DioException catch (errorMessage) {
      throw RemoteException(errorMessage.message.toString());
    }
  }

  @override
  Future<ResetPasswordResponse> resetPassword(
      ResetPasswordRequest resetPasswordRequest) async {
    try {
      final response = await _dio.patch(ConstansApi.resetPassword,
          data: resetPasswordRequest.toJson());
      return ResetPasswordResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw RemoteException(e.toString());
    }
  }
}
