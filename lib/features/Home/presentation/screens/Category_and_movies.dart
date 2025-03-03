import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/features/Home/presentation/screens/see_more.dart';
import 'package:movieapp/theme/apptheme.dart';
import '../../data/data_sources/category_movies_data_source.dart';
import '../../data/repositories/category_movies_repository.dart';
import '../cubit/category_movies_cubit.dart';
import '../cubit/category_movies_state.dart';
import 'movielist.dart';

class CategoryAndMovies extends StatefulWidget {
  @override
  State<CategoryAndMovies> createState() => _CategoryAndMoviesState();
}

class _CategoryAndMoviesState extends State<CategoryAndMovies> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double baseWidth = 430.0;
    final double baseHeight = 932.0;

    return BlocProvider(
      create: (context) => MovieCubit(
        movieRepository: MovieRepository(dataSource: MovieDataSource()),
      )..loadGenres(),
      child: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          if (state is GenreLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
                strokeWidth: screenWidth * 0.01,
              ),
            );
          } else if (state is GenreError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(fontSize: screenWidth * 0.04),
              ),
            );
          } else if (state is GenreLoaded) {
            List<String> shuffledGenres = List.from(state.genres)..shuffle();
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.025,
                      vertical: screenHeight * 0.015,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          shuffledGenres.isNotEmpty
                              ? shuffledGenres[0]
                              : 'No genres available',
                          style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            color: AppTheme.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SeeMore(genre: shuffledGenres[0]),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                "See More",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  color: Colors.amber,
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.01),
                              Icon(
                                Icons.arrow_forward,
                                size: screenWidth * 0.045,
                                color: Colors.amber,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  MovieList(genre: shuffledGenres[0]),
                ],
              ),
            );
          }
          return Center(
            child: Text(
              "Unknown State",
              style: TextStyle(fontSize: screenWidth * 0.045),
            ),
          );
        },
      ),
    );
  }
}
