import 'package:dio/dio.dart';
import 'package:movieapp/core/constans.dart';
import 'package:movieapp/core/error/exception.dart';
import 'package:movieapp/features/Profile/data/data_sources/auth_remote_data_sources.dart';
import 'package:movieapp/features/Profile/data/models/whatch_list_response.dart';
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
  Future<WhatchListResponse> getWatchList() async {
    try {
      final response = await _dio.get(
        ConstansApi.WatchList,
      );
      return WhatchListResponse.fromJson(response.data);
    } on DioException catch (e) {
      final dynamic errorData = e.response?.data['message'];
      throw RemoteException(errorData);
    }
  }

  @override
  Future<void> deleteWatchList(int Movie_id) async {
    try {
      await _dio.delete(
        '${ConstansApi.DeleteWatchList}/$Movie_id',
      );
    } on DioException catch (e) {
      throw RemoteException(e.message!);
    }
  }
}
