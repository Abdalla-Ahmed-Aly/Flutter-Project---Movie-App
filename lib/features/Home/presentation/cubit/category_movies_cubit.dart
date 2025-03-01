import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/category_movies_repository.dart';
import 'category_movies_state.dart';


class MovieCubit extends Cubit<MovieState> {
  final MovieRepository movieRepository;
  bool _isLoading = false;
  bool _hasLoadedMovies = false;

  MovieCubit({required this.movieRepository}) : super(MovieInitial());

  Future<void> loadGenres() async {
    try {
      emit(GenreLoading());
      final genres = await movieRepository.fetchGenres();
      emit(GenreLoaded(genres));
    } catch (e) {
      emit(GenreError(e.toString()));
    }
  }

  Future<void> loadMoviesByGenre(String genre) async {
    if (_hasLoadedMovies || _isLoading) return;

    _isLoading = true;
    emit(MovieListLoading());

    try {
      final movies = await movieRepository.fetchMoviesByGenre(genre);
      _hasLoadedMovies = true;
      emit(MoviesListLoaded(movies));
    } catch (e) {
      emit(MovieListError(e.toString()));
    } finally {
      _isLoading = false;
    }
  }
}
