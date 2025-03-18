import '../../../data/models/Movie_details_model/movie_details_respone.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsLoaded extends MovieDetailsState {
  final MovieDetails movieDetails;

  final String? errorMessage;

  MovieDetailsLoaded({
    required this.movieDetails,
    this.errorMessage,
  });
}

class MovieDetailsError extends MovieDetailsState {
  final String errorMessage;
  MovieDetailsError({required this.errorMessage});
}
