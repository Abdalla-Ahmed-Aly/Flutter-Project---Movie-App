import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/features/Movie_details/data/repositories/movie_suggestions_repository.dart';
import 'package:movieapp/features/Movie_details/presntation/cubits/movie_suggestions_cubit/movie_suggestions_state.dart';

class MovieSuggestionsCubit extends Cubit<MovieSuggestionsState> {
MovieSuggestionsRepository movieSuggestionsRepository;
  MovieSuggestionsCubit({required this.movieSuggestionsRepository}) : super(MovieSuggestionsInitial());
  Future<void>loadMovieSuggestions(int movieId) async{
    emit(MovieSuggestionsLoading());
    try{
      final movieSuggestionsList=await movieSuggestionsRepository.getMovieSuggestionsList(movieId);
emit(MovieSuggestionsLoaded(movieSuggestionList: movieSuggestionsList));
    }catch(error){
      emit(MovieSuggestionsError(errorMessage: error.toString()));



    }


  }

}