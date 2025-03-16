import '../../../Home/data/models/category_movies_data_model.dart';

abstract class LoadMovieByGeneraState {}
class LoadMovieByGeneraInitial extends LoadMovieByGeneraState{

}
class LoadMovieByGeneraLoaded extends LoadMovieByGeneraState{
  final List<Movie> movies;
  LoadMovieByGeneraLoaded(this.movies);
}
class LoadMovieByGeneraLoading extends LoadMovieByGeneraState{

}
class LoadMovieByGeneraError extends LoadMovieByGeneraState{
  final String message;
  LoadMovieByGeneraError(this.message);

}