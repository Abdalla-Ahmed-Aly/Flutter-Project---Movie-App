import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/theme/apptheme.dart';
import '../../data/data_sources/category_movies_data_source.dart';
import '../../data/repositories/category_movies_repository.dart';
import '../cubit/category_movies_cubit.dart';
import '../cubit/category_movies_state.dart';
import '../widgets/see_more_shimmer.dart';

class SeeMore extends StatefulWidget {
  final String genre;

  SeeMore({required this.genre});

  @override
  State<SeeMore> createState() => _SeeMoreState();
}

class _SeeMoreState extends State<SeeMore> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.genre),
        centerTitle: true,
        foregroundColor: AppTheme.white,
        backgroundColor: AppTheme.black,
      ),
      body: BlocProvider(
        create: (context) => MovieCubit(
          movieRepository: MovieRepository(dataSource: MovieDataSource()),
        ),
        child: BlocBuilder<MovieCubit, MovieState>(
          builder: (context, state) {
            context.read<MovieCubit>().loadMoviesByGenre(widget.genre);

            if (state is MovieListLoading) {
              return BuildLoadShimmerMoviesSeeMore();
            } else if (state is MovieListError) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is MoviesListLoaded) {
              final movies = state.movies;
              return Padding(
                padding: EdgeInsets.all(screenWidth * 0.023),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: screenWidth * 0.023,
                    mainAxisSpacing: screenWidth * 0.023,
                    childAspectRatio: screenWidth / (screenHeight * 0.9),
                  ),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return InkWell(
                      onTap: () {},
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(screenWidth * 0.025),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Image.network(
                              movie.imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                            Positioned(
                              top: screenHeight * 0.01,
                              left: screenWidth * 0.023,
                              child: Container(
                                padding: EdgeInsets.all(screenWidth * 0.014),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(
                                      screenWidth * 0.025),
                                ),
                                child: Text(
                                  "${movie.rating}⭐",
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.032,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return BuildLoadShimmerMoviesSeeMore();
            }
          },
        ),
      ),
    );
  }
}
