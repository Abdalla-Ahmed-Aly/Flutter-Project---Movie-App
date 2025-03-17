import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/theme/apptheme.dart';
import '../../../../core/widgets/movie_item.dart';
import '../../../Home/presentation/widgets/see_more_shimmer.dart';
import '../../../Movie_details/data/data_sources/Movie_details_data_source/movie_details_data_source_impl.dart';
import '../../../Movie_details/data/repositories/movie_details_repository.dart';
import '../../../Movie_details/presentation/cubits/Movie_details_cubit/movie_details_cubit.dart';
import '../../../Movie_details/presentation/cubits/Movie_details_cubit/movie_details_state.dart';
import '../cubit/history/history_cubit.dart';
import '../cubit/history/history_state.dart';

class HistoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    double childAspectRatio = (screenWidth * 0.45) / (screenHeight * 0.3);

    return Container(
      child: BlocProvider(
        create: (context) => HistoryCubit()..loadMovies(),
        child: BlocBuilder<HistoryCubit, HistoryState>(
          builder: (context, state) {
            if (state is HistoryLoading) {
              return BuildLoadShimmerMoviesSeeMore(
                columnNumber: 3,
              );
            } else if (state is HistoryFailure) {
              return Center(child: Text(state.error));
            } else if (state is HistorySuccess) {
              final List<int> movieIds = state.movies;
              return movieIds.isEmpty
                  ? Center(
                      child:
                          Image.asset("assets/images/login_screen_header.png"))
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: screenWidth * 0.02,
                        mainAxisSpacing: screenHeight * 0.015,
                        childAspectRatio: childAspectRatio,
                      ),
                      itemCount: movieIds.length,
                      itemBuilder: (context, index) {
                        return BlocProvider(
                          create: (context) => MovieDetailsCubit(
                            movieDetailsRepository: MovieDetailsRepository(
                              movieDetailsDataSource:
                                  MovieDetailsDataSourceImpl(),
                            ),
                          )..getMovieDetails(movieIds[index]),
                          child:
                              BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
                            builder: (context, state) {
                              if (state is MovieDetailsLoading) {
                                return Center(
                                    child: CircularProgressIndicator(
                                  color: AppTheme.white,
                                ));
                              } else if (state is MovieDetailsError) {
                                return Center(
                                  child: Text(state.errorMessage),
                                );
                              } else if (state is MovieDetailsLoaded) {
                                var movieDetails = state.movieDetails;
                                return Stack(
                                  children: [
                                    MovieItem(
                                      movieImageUrl:
                                          movieDetails.mediumCoverImage,
                                      movie_id: movieDetails.id,
                                      movieRating: movieDetails.rating,
                                    ),
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          color: AppTheme.white,
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          context
                                              .read<HistoryCubit>()
                                              .removeMovieID(movieIds[index]);
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return Center(
                                    child: CircularProgressIndicator(
                                  color: AppTheme.white,
                                ));
                              }
                            },
                          ),
                        );
                      },
                    );
            } else {
              return Image.asset("assets/images/login_screen_header.png");
            }
          },
        ),
      ),
    );
  }
}
