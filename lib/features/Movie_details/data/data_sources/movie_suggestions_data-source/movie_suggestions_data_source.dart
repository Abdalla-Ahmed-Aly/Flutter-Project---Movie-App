import 'package:movieapp/features/Movie_details/data/models/movie_suggestions_model/movie_suggestions_respone.dart';

abstract class MovieSuggestionsDataSource {
  Future<List<MovieSuggestions>> getMovieSuggestions(int movieId);
}
