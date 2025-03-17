import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/widgets/movie_item.dart';
import 'package:movieapp/theme/apptheme.dart';
import '../../data/data_sources/category_movies_data_source.dart';
import '../../data/repositories/category_movies_repository.dart';
import '../cubit/category_movies_cubit.dart';
import '../cubit/category_movies_state.dart';
import '../../../../core/widgets/gridviewMoviesShimmer.dart';

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

    double childAspectRatio = (screenWidth * 0.45) / (screenHeight * 0.3);

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
        )..loadMoviesByGenre(widget.genre),
        child: BlocBuilder<MovieCubit, MovieState>(
          builder: (context, state) {
            if (state is MovieListLoading) {
              return   BuildLoadShimmerMoviesSeeMore(columnNumber: 2,);
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
                    crossAxisSpacing: screenWidth * 0.02,
                    mainAxisSpacing: screenHeight * 0.015,
                    childAspectRatio: childAspectRatio,
                  ),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return MovieItem(
                      movieImageUrl: movie.imageUrl,
                      movie_id: movie.id,
                      movieRating: movie.rating,
                    );
                  },
                ),
              );
            } else {
              return   BuildLoadShimmerMoviesSeeMore(columnNumber: 2,);
            }
          },
        ),
      ),
    );
  }
}
