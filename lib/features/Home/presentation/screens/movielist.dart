import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/data_sources/category_movies_data_source.dart';
import '../../data/repositories/category_movies_repository.dart';
import '../cubit/category_movies_cubit.dart';
import '../cubit/category_movies_state.dart';

class MovieList extends StatefulWidget {
  final String genre;

  MovieList({required this.genre});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieCubit(
        movieRepository: MovieRepository(dataSource: MovieDataSource()),
      ),
      child: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          context.read<MovieCubit>().loadMoviesByGenre(widget.genre);

          if (state is MovieListLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            );
          } else if (state is MovieListError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is MoviesListLoaded) {
            final movies = state.movies;
            return Container(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 10),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return Container(
                    width: 160,
                    margin: EdgeInsets.only(right: 10),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              movie.imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          left: 10,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "${movie.rating}⭐",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            return Center(
              child: Text('Loading...'),
            );
          }
        },
      ),
    );
  }
}
