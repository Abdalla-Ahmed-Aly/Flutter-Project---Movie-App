import 'package:dio/dio.dart';
import 'package:movieapp/core/constans.dart';
import 'package:movieapp/features/Movie_details/data/models/movie_suggestions_model/movie_suggestions_respone.dart';

import 'movie_suggestions_data_source.dart';

class MovieSuggestionsDataSourceImpl implements MovieSuggestionsDataSource {
  Dio dio = Dio();
  @override
  Future<List<MovieSuggestions>> getMovieSuggestions(int movieId) async {
    try {
      final response = await dio.get(ConstansApi.movieSuggestions,
          queryParameters: {"movie_id": movieId});

      if (response.statusCode == 200) {
        final data = response.data;
        final List movies = data['data']['movies'] ?? [];
        return movies.map((json) => MovieSuggestions.fromJson(json)).toList();
      } else {
        throw Exception(
            "Failed to load movies. Status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.message}");
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }
}
