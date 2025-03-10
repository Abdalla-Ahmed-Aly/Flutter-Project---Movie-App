import 'package:dio/dio.dart';
import 'package:movieapp/core/constans.dart';
import 'package:movieapp/features/Movie_details/data/models/Movie_details_model/movie_details_respone.dart';
import 'movie_details_data_source.dart';

class MovieDetailsDataSourceImpl implements MovieDetailsDataSource {
  final Dio _dio = Dio();
  @override
  Future<MovieDetails> getMovieDetails(int movieId) async {
    try {
      final response = await _dio.get(
        ConstansApi.MovieDetails,
        queryParameters: {"movie_id": movieId},
      );

      if (response.statusCode == 200) {
        final data = response.data['data']['movie'];

        if (data != null) {
          return MovieDetails.fromJson(data);
        } else {
          throw Exception("Invalid response data format.");
        }
      } else {
        throw Exception(
            "Failed to load movie details. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print('Error occurred: $error'); // For debugging
      throw Exception('Error occurred: $error');
    }
  }
}
