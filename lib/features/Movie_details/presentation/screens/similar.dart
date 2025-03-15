import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/features/Movie_details/data/data_sources/movie_suggestions_data-source/movie_suggestions_data_source_impl.dart';
import 'package:movieapp/features/Movie_details/data/repositories/movie_suggestions_repository.dart';
import 'package:movieapp/features/Movie_details/presentation/cubits/movie_suggestions_cubit/movie_suggestions_cubit.dart';
import 'package:movieapp/features/Movie_details/presentation/cubits/movie_suggestions_cubit/movie_suggestions_state.dart';
import 'package:movieapp/theme/apptheme.dart';
import '../../../../core/widgets/movie_item.dart';
import 'movie_details_screen.dart';

class SimilarWidget extends StatelessWidget {
  final int id;

  const SimilarWidget({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieSuggestionsCubit>(
      create: (context) => MovieSuggestionsCubit(
        movieSuggestionsRepository: MovieSuggestionsRepository(
          movieSuggestionsDataSource: MovieSuggestionsDataSourceImpl(),
        ),
      )..loadMovieSuggestions(id),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Similar Movies',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          BlocBuilder<MovieSuggestionsCubit, MovieSuggestionsState>(
            builder: (context, state) {
              if (state is MovieSuggestionsLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.white,
                  ),
                );
              } else if (state is MovieSuggestionsError) {
                return Center(child: Text(state.errorMessage));
              } else if (state is MovieSuggestionsLoaded) {
                final movies = state.movieSuggestionList;
                return GridView.builder(
                  padding: EdgeInsets.all(8),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                MovieDetailsScreen(id: movie.id ?? 1),
                          ),
                        );
                      },
                      child: MovieItem(
                        movieImageUrl: movie.mediumCoverImage ?? " ",
                        movieRating: movie.rating ?? 1,
                        movie_id: movie.id,
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.white,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
