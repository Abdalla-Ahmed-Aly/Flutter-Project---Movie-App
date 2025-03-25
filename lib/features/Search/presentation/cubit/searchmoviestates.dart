import 'package:movieapp/features/Search/data/models/moviemodel.dart';

abstract class SearchMovieState {}

class MovieInitial extends SearchMovieState {}

class MovieListLoading extends SearchMovieState {}

class MoviesListLoaded extends SearchMovieState {
  final List<MovieModel> movies;
  MoviesListLoaded(this.movies);
}

class MovieListError extends SearchMovieState {
  final String message;
  MovieListError(this.message);
}

class SearchMoviesLoading extends SearchMovieState {}

class SearchMoviesLoaded extends SearchMovieState {
  final List<MovieModel> movies;
  SearchMoviesLoaded(this.movies);
}

class SearchMoviesError extends SearchMovieState {
  final String message;
  SearchMoviesError(this.message);
}
