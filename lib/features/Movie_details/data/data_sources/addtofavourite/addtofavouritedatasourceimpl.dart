import 'package:dio/dio.dart';
import 'package:movieapp/core/constans.dart';
import 'package:movieapp/core/error/exception.dart';
import 'package:movieapp/features/Movie_details/data/data_sources/addtofavourite/addtofavouritedatasource.dart';
import 'package:movieapp/features/Movie_details/data/models/favourite_movie/addtofavouriteresponse.dart';
import 'package:movieapp/features/Movie_details/data/models/favourite_movie/addtofavouritrequest.dart';
import 'package:movieapp/features/onboarding/services/sharedpreferencekeys.dart';
import 'package:movieapp/features/onboarding/services/sharedpreferences.dart';

class AddToFavouriteDataSourceImpl implements AddToFavouriteDataSource {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ConstansApi.BASE_URL,
    ),
  );

  AddToFavouriteDataSourceImpl() {
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
  Future<AddToFavouriteResponse> addToFavourite(
      AddToFavouriteRequest request) async {
    try {
      final body = request.toJson();

      final response = await _dio.post(
        ConstansApi.AddToFavourite,
        data: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return AddToFavouriteResponse.fromJson(response.data);
      } else {
        throw Exception("API Error: ${response.statusCode}");
      }
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
      throw Exception(errorMessage);
    }
  }

  Future<bool> isMovieFavourite(String movieId) async {
    try {
      final response = await _dio.get("${ConstansApi.IsItFavourite}$movieId");

      if (response.statusCode == 200) {
        return response.data["data"] ?? false;
      } else {
        throw Exception("API Error: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception(
          "Failed to check favorite status: ${e.response?.data ?? e.message}");
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
