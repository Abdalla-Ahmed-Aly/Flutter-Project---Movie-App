import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movieapp/core/widgets/customButton.dart';
import 'package:movieapp/features/Movie_details/data/repositories/movie_details_repository.dart';
import 'package:movieapp/features/Movie_details/presentation/cubits/Movie_details_cubit/movie_details_cubit.dart';
import 'package:movieapp/features/Movie_details/presentation/cubits/Movie_details_cubit/movie_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/features/Movie_details/presentation/screens/movieheader.dart';
import 'package:movieapp/features/Movie_details/presentation/screens/similar.dart';
import 'package:movieapp/theme/apptheme.dart';
import '../../data/data_sources/Movie_details_data_source/movie_details_data_source_impl.dart';
import '../shimmerUi.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const String routeName = 'movieDetails';
  final int id;

  MovieDetailsScreen({super.key, required this.id});

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
            return Scaffold(
              body: Center(
                child: Text(state.errorMessage),
              ),
            );
          } else if (state is MovieDetailsLoaded) {
            return Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          MovieHeader(
                            screenHeight: screenHeight,
                            screenwidth: screenwidth,
                            textTheme: textTheme,
                            imageurl: state.movieDetails.largeCoverImage,
                            rating: state.movieDetails.rating,
                            likes: state.movieDetails.likeCount,
                            timecount: state.movieDetails.runtime,
                            title: state.movieDetails.title,
                            releaseDate: state.movieDetails.year,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            height: 300,
                            child: SimilarWidget(
                              id: state.movieDetails.id,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
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
