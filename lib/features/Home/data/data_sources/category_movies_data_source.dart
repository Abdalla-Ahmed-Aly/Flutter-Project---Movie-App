import 'package:dio/dio.dart';
import 'package:movieapp/features/Home/data/data_sources/category_movies_data_source_abstract.dart';
import '../models/category_movies_data_model.dart';

class MovieDataSource implements CategoryMoviesDataSourceAbstract {
  static const String apiUrl = "https://yts.mx/api/v2/list_movies.json/";
  final Dio dio = Dio();

  @override
  Future<List<Movie>> fetchMoviesByGenre(String genre) async {
    try {
      final response = await dio.get(apiUrl, queryParameters: {"genre": genre});
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

  @override
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

  @override
  Future<List<Movie>> fetchNewestMovies() async {
    try {
      final response2024 = await dio.get(apiUrl, queryParameters: {
        "sort_by": "year",
        "order_by": "desc",
        "limit": 50,
        "query_term": "2024",
      });

      final response2025 = await dio.get(apiUrl, queryParameters: {
        "sort_by": "year",
        "order_by": "desc",
        "limit": 50,
        "query_term": "2025",
      });

      if (response2024.statusCode == 200 && response2025.statusCode == 200) {
        final data2024 = response2024.data;
        final data2025 = response2025.data;

        final List movies2024 = data2024['data']['movies'] ?? [];
        final List movies2025 = data2025['data']['movies'] ?? [];

        final List<Movie> allMovies = [
          ...movies2024.map((json) => Movie.fromJson(json)),
          ...movies2025.map((json) => Movie.fromJson(json)),
        ];

        allMovies.sort((a, b) => b.year.compareTo(a.year));

        return allMovies;
      } else {
        throw Exception("Failed to load newest movies");
      }
    } catch (e) {
      throw Exception("Error fetching newest movies: $e");
    }
  }
}
