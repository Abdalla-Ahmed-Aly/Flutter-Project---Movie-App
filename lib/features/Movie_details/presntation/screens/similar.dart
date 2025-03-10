import 'package:flutter/material.dart';
import 'package:movieapp/features/Movie_details/data/data_sources/movie_suggestions_data-source/movie_suggestions_data_source_impl.dart';
import 'package:movieapp/features/Movie_details/data/repositories/movie_suggestions_repository.dart';
import 'package:movieapp/features/Movie_details/presntation/cubits/movie_suggestions_cubit/movie_suggestions_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/theme/apptheme.dart';
import '../../../../core/widgets/movie_item.dart';
import '../../../Home/presentation/widgets/see_more_shimmer.dart';
import '../cubits/movie_suggestions_cubit/movie_suggestions_state.dart';
import 'movie_details_screen.dart';

class SimilarWidget extends StatefulWidget {
  static const String routeName = 'similar';
  final int id;

  SimilarWidget({super.key, required this.id});

  @override
  State<SimilarWidget> createState() => _SimilarWidgetState();
}

class _SimilarWidgetState extends State<SimilarWidget> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider<MovieSuggestionsCubit>(
      create: (context) => MovieSuggestionsCubit(
        movieSuggestionsRepository: MovieSuggestionsRepository(
          movieSuggestionsDataSource: MovieSuggestionsDataSourceImpl(),
        ),
      )..loadMovieSuggestions(widget.id),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Similar',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: BlocBuilder<MovieSuggestionsCubit, MovieSuggestionsState>(
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
            ),
          ],
        ),
      ),
    );
  }
}
