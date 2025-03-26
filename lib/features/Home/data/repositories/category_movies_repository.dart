import '../data_sources/category_movies_data_source_abstract.dart';
import '../models/category_movies_data_model.dart';

class MovieRepository {
  final CategoryMoviesDataSourceAbstract dataSource;

  MovieRepository({required this.dataSource});

  Future<List<String>> fetchGenres() {
    return dataSource.fetchGenres();
  }

  Future<List<Movie>> fetchMoviesByGenre(String genre) async {
    return await dataSource.fetchMoviesByGenre(genre);
  }

  Future<List<Movie>> fetchNewestMovies(
      String currentYear, String previousYear) async {
    return await dataSource.fetchNewestMovies(currentYear, previousYear);
  }
}
