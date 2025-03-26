import '../models/category_movies_data_model.dart';

abstract class CategoryMoviesDataSourceAbstract {
  Future<List<Movie>> fetchMoviesByGenre(String genre);
  Future<List<String>> fetchGenres();
  Future<List<Movie>> fetchNewestMovies(
      String currentYear, String previousYear);
}
