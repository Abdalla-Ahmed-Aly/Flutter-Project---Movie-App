import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/features/Home/presentation/screens/see_more.dart';
import 'package:movieapp/theme/apptheme.dart';
import '../../data/data_sources/category_movies_data_source.dart';
import '../../data/repositories/category_movies_repository.dart';
import '../cubit/category_movies_cubit.dart';
import '../cubit/category_movies_state.dart';
import '../widgets/categoey_movies_shimmer.dart';
import 'movielist.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryAndMovies extends StatefulWidget {
  const CategoryAndMovies({super.key});

  @override
  State<CategoryAndMovies> createState() => _CategoryAndMoviesState();
}

class _CategoryAndMoviesState extends State<CategoryAndMovies> {
  late MovieCubit _movieCubit;
  List<String> shuffledGenres = [];

  @override
  void initState() {
    super.initState();
    _movieCubit = MovieCubit(
        movieRepository: MovieRepository(dataSource: MovieDataSource()));
    _movieCubit.loadGenres();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider.value(
      value: _movieCubit,
      child: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          if (state is GenreLoading) {
            return CategoryMoviesShimmer();
          } else if (state is GenreError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(fontSize: screenWidth * 0.04),
              ),
            );
          } else if (state is GenreLoaded) {
            if (shuffledGenres.isEmpty) {
              shuffledGenres = List.from(state.genres)..shuffle();
            }
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
                                AppLocalizations.of(context)!.seemore,
                                style: TextStyle(color: AppTheme.primary),
                              ),
                              SizedBox(width: screenWidth * 0.01),
                              Icon(
                                Icons.arrow_forward,
                                color: AppTheme.primary,
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
          return CategoryMoviesShimmer();
        },
      ),
    );
  }

  @override
  void dispose() {
    _movieCubit.close();
    super.dispose();
  }
}
