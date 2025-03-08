import 'package:movieapp/features/Movie_details/data/models/movie_suggestions_model/movie_suggestions_respone.dart';

import '../data_sources/movie_suggestions_data-source/movie_suggestions_data_source.dart';

class MovieSuggestionsRepository {
  MovieSuggestionsDataSource movieSuggestionsDataSource;
  MovieSuggestionsRepository({required this.movieSuggestionsDataSource});
  Future<List<MovieSuggestions>>getMovieSuggestionsList(String movieId){
    return movieSuggestionsDataSource.getMovieSuggestions(movieId);


}


}