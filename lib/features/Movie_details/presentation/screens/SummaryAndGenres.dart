import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/features/Movie_details/data/repositories/movie_details_repository.dart';
import 'package:movieapp/features/Movie_details/presentation/cubits/Movie_details_cubit/movie_details_cubit.dart';
import 'package:movieapp/features/Movie_details/presentation/cubits/Movie_details_cubit/movie_details_state.dart';
import 'package:movieapp/theme/apptheme.dart';
import '../../data/data_sources/Movie_details_data_source/movie_details_data_source_impl.dart';

class SummaryAndGenres extends StatelessWidget {
  final int id;

  const SummaryAndGenres(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (context) => MovieDetailsCubit(
        movieDetailsRepository: MovieDetailsRepository(
          movieDetailsDataSource: MovieDetailsDataSourceImpl(),
        ),
      )..getMovieDetails(id),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
          builder: (context, state) {
            if (state is MovieDetailsLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Summary',
                    style: textTheme.displayMedium,
                  ),
                  const SizedBox(height: 8),
                  if (state.movieDetails.descriptionIntro?.isNotEmpty == true)
                    Text(
                      state.movieDetails.descriptionIntro!,
                      style: textTheme.titleSmall,
                    )
                  else
                    Text(
                      'No available summary',
                      style: textTheme.titleSmall,
                    ),
                  SizedBox(height: 20),
                  Text(
                    'Genres',
                    style: textTheme.displayMedium,
                  ),
                  SizedBox(height: 10),
                  if (state.movieDetails.genres.isNotEmpty == true)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 3,
                      ),
                      itemCount: state.movieDetails.genres.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              color: AppTheme.gray,
                              borderRadius: BorderRadius.circular(100),
                              shape: BoxShape.rectangle),
                          child: Center(
                            child: Text(
                              state.movieDetails.genres[index],
                              style: textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    )
                  else
                    Text(
                      'No genres available',
                      style: textTheme.titleSmall,
                    ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
