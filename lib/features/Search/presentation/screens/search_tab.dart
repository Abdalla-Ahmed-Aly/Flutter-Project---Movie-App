import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/widgets/movie_item.dart';
import 'package:movieapp/features/Search/data/datasources/searchmoviedatasource.dart';
import 'package:movieapp/features/Search/data/repository/searchmovierepo.dart';
import 'package:movieapp/features/Search/presentation/cubit/searchmoviecubit.dart';
import 'package:movieapp/features/Search/presentation/cubit/searchmoviestates.dart';
import 'package:movieapp/theme/apptheme.dart';
import '../../../../core/widgets/cutomTextFormField.dart';

class SearchTab extends StatefulWidget {
  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final SearchMovieRepository searchMovieRepository = SearchMovieRepository(
    dataSource: SearchMovieDataSource(),
  );
  TextEditingController searchEditingController = TextEditingController();
  bool ischanged = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 21, right: 16, left: 16),
        child: Column(
          children: [
            TextFormFieldCustom(
              hintText: "Search",
              prefixIconPath: "assets/icons/search.svg",
              color: ischanged ? AppTheme.primary : null,
              controller: searchEditingController,
              onChanged: (query) {
                context.read<SearchMovieCubit>().searchMovies(query);
                ischanged = query.isNotEmpty;
                if (query.length <= 1) {
                  setState(() {});
                }
              },
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(child: BlocBuilder<SearchMovieCubit, SearchMovieState>(
              builder: (context, state) {
                if (state is SearchMoviesLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is SearchMoviesLoaded) {
                  final movies = state.movies;
                  return searchEditingController.text.isNotEmpty
                      ? Column(
                          children: [
                            Expanded(
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: screenWidth * 0.023,
                                  mainAxisSpacing: screenWidth * 0.023,
                                  childAspectRatio:
                                      screenWidth / (screenHeight * 0.7),
                                ),
                                itemCount: movies.length,
                                itemBuilder: (context, index) {
                                  final movie = movies[index];
                                  return InkWell(
                                    onTap: () {},
                                    child: MovieItem(
                                      movieImageUrl: movie.imageUrl,
                                      movieRating: movie.rating,
                                      movie_id: movie.id,
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            )
                          ],
                        )
                      : Center(
                          child: Text(
                            'No Results Yet',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  color: AppTheme.primary,
                                ),
                          ),
                        );
                } else if (state is SearchMoviesError) {
                  return Center(child: Text(state.message));
                } else {
                  return Center(
                    child: Text(
                      'No Results Yet',
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                color: AppTheme.primary,
                              ),
                    ),
                  );
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
