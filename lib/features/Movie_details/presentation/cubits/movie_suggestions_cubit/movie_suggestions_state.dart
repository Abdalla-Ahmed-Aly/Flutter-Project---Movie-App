import '../../../data/models/movie_suggestions_model/movie_suggestions_respone.dart';

abstract class MovieSuggestionsState {}

class MovieSuggestionsInitial extends MovieSuggestionsState {}

class MovieSuggestionsLoading extends MovieSuggestionsState {}

class MovieSuggestionsLoaded extends MovieSuggestionsState {
  final List<MovieSuggestions> movieSuggestionList;
  MovieSuggestionsLoaded({required this.movieSuggestionList});
}

class MovieSuggestionsError extends MovieSuggestionsState {
  String errorMessage;
  MovieSuggestionsError({required this.errorMessage});
}
