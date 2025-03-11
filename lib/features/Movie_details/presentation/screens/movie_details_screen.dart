import 'package:flutter/material.dart';
import 'package:movieapp/features/Movie_details/data/repositories/movie_details_repository.dart';
import 'package:movieapp/features/Movie_details/presentation/cubits/Movie_details_cubit/movie_details_cubit.dart';
import 'package:movieapp/features/Movie_details/presentation/cubits/Movie_details_cubit/movie_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            print(state.errorMessage);
            return Center(
              child: Text(state.errorMessage),
            );
          } else if (state is MovieDetailsLoaded) {
            print(state.movieDetails.id);
            return Scaffold(
              body: Stack(
                children: [
                  SizedBox(
                    height: screenHeight,
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppTheme.black.withOpacity(0.6),
                            AppTheme.black,
                          ],
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.srcATop,
                      child: Image.asset(
                        'assets/images/failureloading.png',
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset("assets/images/failureloading.png",
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: double.infinity);
                        },
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SafeArea(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: AppTheme.white,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.bookmark_outline_rounded,
                                size: 30,
                                color: AppTheme.white,
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            )
                          ],
                        ),
                      ),
                      Center(
                        child: Text(
                          state.movieDetails.title,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.white),
                        ),
                      ),
                      SizedBox(height: 8),
                      SizedBox(height: 16),
                      Expanded(
                          child: SimilarWidget(
                        id: state.movieDetails.id,
                      ))
                    ],
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
