import 'package:dio/dio.dart';
import 'package:movieapp/features/Home/data/data_sources/category_movies_data_source_abstract.dart';

import '../models/category_movies_data_model.dart';

class MovieDataSource implements CategoryMoviesDataSourceAbstract {
  static const String apiUrl = "https://yts.mx/api/v2/list_movies.json/";
  final Dio dio = Dio();

  Future<List<Movie>> fetchMoviesByGenre(String genre) async {
    try {
      final response = await dio.get(apiUrl, queryParameters: {
        "genre": genre,
      });
      if (response.statusCode == 200) {
        final data = response.data;
        final List movies = data['data']['movies'] ?? [];
        return movies.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load movies by genre");
      }
    } catch (e) {
      throw Exception("Error fetching movies by genre: $e");
    }
  }

  Future<List<String>> fetchGenres() async {
    try {
      final response = await dio.get(apiUrl);
      if (response.statusCode == 200) {
        final data = response.data;
        final List movies = data['data']['movies'] ?? [];

        final Set<String> genreSet = {};

        for (var movie in movies) {
          if (movie['genres'] != null) {
            genreSet.addAll(List<String>.from(movie['genres']));
          }
        }

        return genreSet.toList()..sort();
      } else {
        throw Exception("Failed to load genres");
      }
    } catch (e) {
      throw Exception("Error fetching genres: $e");
    }
  }
}
