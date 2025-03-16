import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Home/data/repositories/category_movies_repository.dart';
import 'load_movie_by_genera_state.dart';

class LoadMovieByGeneraCubit extends Cubit<LoadMovieByGeneraState> {
  final MovieRepository movieRepository;
  bool _isLoading = false;
  bool _hasLoadedMovies = false;

  LoadMovieByGeneraCubit({required this.movieRepository}):super(LoadMovieByGeneraInitial());
  Future<void> loadMoviesByGenre(String genre) async {



    emit(LoadMovieByGeneraLoading());

    try {
      final movies = await movieRepository.fetchMoviesByGenre(genre);
      _hasLoadedMovies = true;
      emit(LoadMovieByGeneraLoaded(movies));
    } catch (e) {
      emit(LoadMovieByGeneraError(e.toString()));
    } finally {
      _isLoading = false;
    }
  }


}