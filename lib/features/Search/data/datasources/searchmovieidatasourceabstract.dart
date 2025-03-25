import 'package:movieapp/features/Search/data/models/moviemodel.dart';

abstract class SearchMoviesDataSourceAbstract {
  Future<List<MovieModel>> searchMovies(String query);
}
