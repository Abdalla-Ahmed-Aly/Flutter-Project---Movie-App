import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/features/Search/data/repository/searchmovierepo.dart';
import 'package:movieapp/features/Search/presentation/cubit/searchmoviestates.dart';

class SearchMovieCubit extends Cubit<SearchMovieState> {
  final SearchMovieRepository searchmovieRepository;
  bool _isLoading = false;

  SearchMovieCubit({required this.searchmovieRepository})
      : super(MovieInitial());

  Future<void> searchMovies(String query) async {
    if (_isLoading) return;

    _isLoading = true;
    emit(SearchMoviesLoading());

    try {
      final movies = await searchmovieRepository.searchMovies(query);
      emit(SearchMoviesLoaded(movies));
    } catch (e) {
      emit(
        SearchMoviesError(
          e.toString(),
        ),
      );
    } finally {
      _isLoading = false;
    }
  }
}
