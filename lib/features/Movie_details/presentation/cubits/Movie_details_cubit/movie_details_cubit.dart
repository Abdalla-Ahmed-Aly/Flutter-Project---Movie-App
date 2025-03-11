import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/features/Movie_details/data/repositories/movie_details_repository.dart';
import 'package:movieapp/features/Movie_details/presentation/cubits/Movie_details_cubit/movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  MovieDetailsRepository movieDetailsRepository;

  MovieDetailsCubit({required this.movieDetailsRepository})
      : super(MovieDetailsInitial());
  Future<void> getMovieDetails(int movieId) async {
    emit(MovieDetailsLoading());
    try {
      final movieDetails =
          await movieDetailsRepository.getMovieDetails(movieId);
      emit(MovieDetailsLoaded(movieDetails: movieDetails));
    } catch (error) {
      emit(MovieDetailsError(errorMessage: error.toString()));
    }
  }
}
