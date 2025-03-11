import '../../../data/models/Movie_details_model/movie_details_respone.dart';
abstract class MovieDetailsState {}
class MovieDetailsInitial extends MovieDetailsState{}
class MovieDetailsLoading extends MovieDetailsState{}
class MovieDetailsLoaded extends MovieDetailsState{
  final MovieDetails movieDetails;
  MovieDetailsLoaded({required this.movieDetails});

}
class MovieDetailsError extends MovieDetailsState{
  String errorMessage;
  MovieDetailsError({required this.errorMessage});



}



