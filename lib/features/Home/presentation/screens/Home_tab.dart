import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/widgets/movie_item.dart';
import 'package:movieapp/features/Home/data/data_sources/category_movies_data_source.dart';
import 'package:movieapp/features/Home/data/models/category_movies_data_model.dart';
import 'package:movieapp/features/Home/data/repositories/category_movies_repository.dart';
import 'package:movieapp/features/Home/presentation/cubit/category_movies_cubit.dart';
import 'package:movieapp/features/Home/presentation/cubit/category_movies_state.dart';
import 'package:movieapp/features/Home/presentation/screens/Category_and_movies.dart';
import 'package:movieapp/theme/apptheme.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int currentIndex = 0;
  List<Movie> myMovies = [];
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => MovieCubit(
          movieRepository: MovieRepository(dataSource: MovieDataSource()))
        ..loadNewestMovies(),
      child: BlocBuilder<MovieCubit, MovieState>(builder: (context, state) {
        if (state is NewestMoviesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NewestMoviesLoaded) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Stack(
                alignment: Alignment.center,
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
                      child: Image.network(
                        state.movies[currentIndex].imageUrl,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SafeArea(
                        child: Center(
                          child: Image.asset(
                            'assets/images/Available Now.png',
                          ),
                        ),
                      ),
                      CarouselSlider.builder(
                        options: CarouselOptions(
                          height: screenHeight * 0.4,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.2,
                          enableInfiniteScroll: true,
                          viewportFraction: 0.6,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                        ),
                        itemCount: state.movies.length,
                        itemBuilder: (context, index, realIndex) {
                          myMovies = state.movies;

                          final movie = state.movies[index];
                          return MovieItem(
                            movieImageUrl: movie.imageUrl,
                            movieRating: movie.rating,
                            screenwidth: screenWidth * 0.8,
                          );
                        },
                      ),
                      Center(
                        child: SizedBox(
                            width: screenWidth * 0.85,
                            height: screenHeight * 0.15,
                            child: Image.asset("assets/images/Watch Now.png")),
                      ),
                      CategoryAndMovies(),
                      SizedBox(
                        height: screenHeight * 0.02,
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        } else if (state is NewestMoviesError) {
          return Center(child: Text(state.message));
        } else {
          return const Placeholder();
        }
      }),
    );
  }
}
