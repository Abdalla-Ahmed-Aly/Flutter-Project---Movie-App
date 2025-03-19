import 'package:movieapp/features/Search/data/datasources/searchmovieidatasourceabstract.dart';
import 'package:movieapp/features/Search/data/models/moviemodel.dart';

class SearchMovieRepository {
  final SearchMoviesDataSourceAbstract dataSource;

  SearchMovieRepository({required this.dataSource});

  Future<List<MovieModel>> searchMovies(String query) async {
    return await dataSource.searchMovies(query);
  }
}
