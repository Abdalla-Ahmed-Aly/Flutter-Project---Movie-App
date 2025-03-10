import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/features/Movie_details/data/data_sources/movie_suggestions_data-source/movie_suggestions_data_source_impl.dart';
import 'package:movieapp/features/Movie_details/data/repositories/movie_suggestions_repository.dart';
import 'package:movieapp/features/Movie_details/presntation/cubits/movie_suggestions_cubit/movie_suggestions_cubit.dart';

import '../cubits/movie_suggestions_cubit/movie_suggestions_state.dart';

class MovieDetailsScreen extends StatefulWidget {

static const String routeName="sdf";
  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => MovieSuggestionsCubit(movieSuggestionsRepository: MovieSuggestionsRepository(movieSuggestionsDataSource: MovieSuggestionsDataSourceImpl()))..loadMovieSuggestions(1),
      child:BlocBuilder<MovieSuggestionsCubit,MovieSuggestionsState>(builder: (context, state) {
        if(state is MovieSuggestionsLoading){
          return const Center(child: CircularProgressIndicator());

        }else if(state is MovieSuggestionsLoaded){
          return Scaffold(
            body: Center(
              child: Text(state.movieSuggestionList[0].title!),

            ),

          );

        }else if(state is MovieSuggestionsError){
          return Center(child: Text(state.errorMessage));

        }else{
          return SizedBox();
        }

      },)



    );
  }
}
