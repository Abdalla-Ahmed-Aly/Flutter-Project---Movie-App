import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/theme/apptheme.dart';
import '../../data/data_sources/category_movies_data_source.dart';
import '../../data/repositories/category_movies_repository.dart';
import '../cubit/category_movies_cubit.dart';
import '../cubit/category_movies_state.dart';
import 'movielist.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieCubit(
        movieRepository: MovieRepository(dataSource: MovieDataSource()),
      )..loadGenres(),
      child: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          if (state is GenreLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            );
          } else if (state is GenreError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is GenreLoaded) {
            List<String> shuffledGenres = List.from(state.genres)..shuffle();
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Image.asset("assets/images/Available Now.png")),
                    Center(child: Image.asset("assets/images/Watch Now.png")),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            shuffledGenres.isNotEmpty
                                ? shuffledGenres[0]
                                : 'No genres available',
                            style: TextStyle(
                                fontSize: 20,
                                color: AppTheme.white,
                                fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("See More",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.amber)),
                                  Icon(
                                    Icons.arrow_forward,
                                    size: 16,
                                    color: Colors.amber,
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                    MovieList(genre: shuffledGenres[0]),
                  ],
                ),
              ),
            );
          }
          return const Center(child: Text("Unknown State"));
        },
      ),
    );
  }
}
