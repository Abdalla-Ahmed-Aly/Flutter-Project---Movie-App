import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/features/Movie_details/data/repositories/movie_details_repository.dart';
import 'package:movieapp/features/Movie_details/presentation/cubits/Movie_details_cubit/movie_details_cubit.dart';
import 'package:movieapp/features/Movie_details/presentation/cubits/Movie_details_cubit/movie_details_state.dart';
import 'package:movieapp/features/Movie_details/presentation/screens/SummaryAndGenres.dart';
import 'package:movieapp/features/Movie_details/presentation/screens/movieheader.dart';
import 'package:movieapp/features/Movie_details/presentation/screens/similar.dart';
import '../../data/data_sources/Movie_details_data_source/movie_details_data_source_impl.dart';
import '../shimmerUi.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const String routeName = 'movieDetails';
  final int id;

  const MovieDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenwidth = MediaQuery.of(context).size.width;
    TextTheme textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) => MovieDetailsCubit(
        movieDetailsRepository: MovieDetailsRepository(
          movieDetailsDataSource: MovieDetailsDataSourceImpl(),
        ),
      )..getMovieDetails(id),
      child: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
        builder: (context, state) {
          if (state is MovieDetailsLoading) {
            return BuildLoadShimmerMovieDetails();
          } else if (state is MovieDetailsError) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else if (state is MovieDetailsLoaded) {
            return Scaffold(
              body: ListView(
                children: [
                  MovieHeader(
                    id: state.movieDetails.id,
                    screenHeight: screenHeight,
                    screenwidth: screenwidth,
                    textTheme: textTheme,
                    imageurl: state.movieDetails.largeCoverImage,
                    rating: state.movieDetails.rating,
                    likes: state.movieDetails.likeCount,
                    timecount: state.movieDetails.runtime,
                    title: state.movieDetails.title,
                    releaseDate: state.movieDetails.year,
                    uRL: state.movieDetails.url,
                  ),
                  SizedBox(height: 50),
                  SimilarWidget(id: state.movieDetails.id),
                  SizedBox(height: 16),
                  SummaryAndGenres(state.movieDetails.id),
                ],
              ),
            );
          } else {
            return BuildLoadShimmerMovieDetails();
          }
        },
      ),
    );
  }
}
