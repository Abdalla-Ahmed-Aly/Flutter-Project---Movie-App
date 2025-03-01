import '../../data/models/category_movies_data_model.dart';

abstract class MovieState {}

class MovieInitial extends MovieState {}

class GenreLoading extends MovieState {}

class GenreLoaded extends MovieState {
  final List<String> genres;
  GenreLoaded(this.genres);
}

class GenreError extends MovieState {
  final String message;
  GenreError(this.message);
}

class MovieListLoading extends MovieState {}

class MoviesListLoaded extends MovieState {
  final List<Movie> movies;
  MoviesListLoaded(this.movies);
}

class MovieListError extends MovieState {
  final String message;
  MovieListError(this.message);
}
