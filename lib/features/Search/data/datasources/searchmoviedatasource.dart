import 'package:dio/dio.dart';
import 'package:movieapp/features/Search/data/datasources/searchmovieidatasourceabstract.dart';
import 'package:movieapp/features/Search/data/models/moviemodel.dart';

class SearchMovieDataSource implements SearchMoviesDataSourceAbstract {
  static const String apiUrl = "https://yts.mx/api/v2/list_movies.json/";
  final Dio dio = Dio();

  Future<List<MovieModel>> searchMovies(String query) async {
    try {
      final response = await dio.get(apiUrl, queryParameters: {
        "query_term": query,
        "sort_by": "year",
        "order_by": "desc",
      });

      if (response.statusCode == 200) {
        final data = response.data;
        final List movies = data['data']['movies'] ?? [];
        return movies.map((json) => MovieModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load movies by search query");
      }
    } catch (e) {
      throw Exception("Error fetching movies by search query: $e");
    }
  }
}
