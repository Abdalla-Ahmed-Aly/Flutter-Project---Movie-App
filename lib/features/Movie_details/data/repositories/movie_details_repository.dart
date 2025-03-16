import 'package:movieapp/features/Movie_details/data/data_sources/Movie_details_data_source/movie_details_data_source.dart';
import 'package:movieapp/features/Movie_details/data/models/Movie_details_model/movie_details_respone.dart';

class MovieDetailsRepository {
  final MovieDetailsDataSource movieDetailsDataSource;
  MovieDetailsRepository({required this.movieDetailsDataSource});
  Future<MovieDetails> getMovieDetails(int movieId) {
    return movieDetailsDataSource.getMovieDetails(movieId);
  }
}
