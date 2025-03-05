import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movieapp/core/widgets/movie_item.dart';
import 'package:movieapp/features/Home/data/data_sources/category_movies_data_source.dart';
import 'package:movieapp/features/Home/data/models/category_movies_data_model.dart';
import 'package:movieapp/features/Home/data/repositories/category_movies_repository.dart';
import 'package:movieapp/features/Home/presentation/cubit/category_movies_cubit.dart';
import 'package:movieapp/features/Home/presentation/cubit/category_movies_state.dart';

class MostRecentMovies extends StatelessWidget {
  MostRecentMovies({super.key, required this.movies});
  List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => MovieCubit(
          movieRepository: MovieRepository(dataSource: MovieDataSource()))
        ..loadNewestMovies(),
      child: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          if (state is NewestMoviesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NewestMoviesLoaded) {
            return CarouselSlider.builder(
              options: CarouselOptions(
                height: 300,
                enlargeCenterPage: true,
                enlargeFactor: 0.2,
                enableInfiniteScroll: true,
                viewportFraction: 0.6,
              ),
              itemCount: state.movies.length,
              itemBuilder: (context, index, realIndex) {
                final movie = state.movies[index];
                return MovieItem(
                  movieImageUrl: movie.imageUrl,
                  movieRating: movie.rating,
                  screenwidth: screenWidth * 0.8,
                );
              },
            );
          } else if (state is NewestMoviesError) {
            return Center(child: Text(state.message));
          } else {
            return const Placeholder();
          }
        },
      ),
    );
  }
}
