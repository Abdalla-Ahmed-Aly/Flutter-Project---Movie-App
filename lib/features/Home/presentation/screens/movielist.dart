import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/widgets/movie_item.dart';
import '../../data/data_sources/category_movies_data_source.dart';
import '../../data/repositories/category_movies_repository.dart';
import '../cubit/category_movies_cubit.dart';
import '../cubit/category_movies_state.dart';
import '../widgets/build_load_shimmer.dart';

class MovieList extends StatefulWidget {
  final String genre;

  MovieList({required this.genre});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => MovieCubit(
        movieRepository: MovieRepository(dataSource: MovieDataSource()),
      ),
      child: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          context.read<MovieCubit>().loadMoviesByGenre(widget.genre);

          if (state is MovieListLoading) {
            return BuildLoadShimmerMovies();
          } else if (state is MovieListError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is MoviesListLoaded) {
            final movies = state.movies;
            return Container(
              height: screenHeight * 0.27,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.023),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return MovieItem(movieImageUrl: movie.imageUrl, movieRating: movie.rating);
                },
              ),
            );
          } else {
            return BuildLoadShimmerMovies();
          }
        },
      ),
    );
  }
}
