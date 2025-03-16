import 'package:movieapp/features/Movie_details/data/models/Movie_details_model/movie_details_respone.dart';

abstract class MovieDetailsDataSource {
  Future<MovieDetails> getMovieDetails(int movieId);
}
