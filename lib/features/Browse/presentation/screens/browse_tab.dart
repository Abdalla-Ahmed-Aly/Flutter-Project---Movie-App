import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/features/Browse/presentation/cubit/load_movie_by_genera_cubit.dart';
import 'package:movieapp/features/Browse/presentation/cubit/load_movie_by_genera_state.dart';
import 'package:movieapp/features/Browse/presentation/screens/widget/shimmer_for_genera_bar.dart';
import 'package:movieapp/features/Browse/presentation/screens/widget/tab_bar_for_browse.dart';
import 'package:movieapp/features/Home/data/repositories/category_movies_repository.dart';
import 'package:movieapp/features/Home/presentation/cubit/category_movies_cubit.dart';
import 'package:movieapp/features/Home/presentation/cubit/category_movies_state.dart';
import '../../../../core/widgets/movie_item.dart';
import '../../../Home/data/data_sources/category_movies_data_source.dart';
import '../../../Home/presentation/widgets/see_more_shimmer.dart';

class BrowseTab extends StatefulWidget {
  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  late MovieCubit movieCubit ;
  late LoadMovieByGeneraCubit loadMovieByGeneraCubit ;
  List<String>generaList=[];
  int currentIndex = 0;
  @override
  void initState() {
    movieCubit=MovieCubit(movieRepository: MovieRepository(dataSource: MovieDataSource()));
    loadMovieByGeneraCubit=LoadMovieByGeneraCubit(movieRepository: MovieRepository(dataSource: MovieDataSource()));
    movieCubit.loadGenres();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Padding(
        padding:  const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            BlocProvider(create:(context) => movieCubit,child:
            BlocBuilder<MovieCubit,MovieState>(builder: (context, state) {
              if(state is GenreLoading ){


                return ShimmerForGeneraBar();
              }else if(state is GenreError){

                return Center(child: Text(state.message));
              }else if (state is GenreLoaded){
                generaList=state.genres;
                loadMovieByGeneraCubit.loadMoviesByGenre(generaList[currentIndex]);



                return  DefaultTabController(
                    length: generaList.length,
                    child: TabBar(
                        onTap: (index) {
                          if (currentIndex == index) return;
                          currentIndex = index;

                          setState(() {});

                        },
                        isScrollable: true,
                        indicatorColor: Colors.transparent,
                        dividerColor: Colors.transparent,
                        tabAlignment: TabAlignment.start,
                        padding: EdgeInsets.only(left: 16),
                        labelPadding: EdgeInsets.only(right: 8),
                        tabs: generaList
                            .map(
                              (genera) => TabBarForBrowse(
                              label: genera,
                              isSelected:
                              currentIndex == generaList.indexOf(genera)),
                        )
                            .toList()));

              }
              else{
                return SizedBox();
              }
            },
            )),
            BlocProvider(create: (context) => loadMovieByGeneraCubit,child:
            Expanded(
              child: BlocBuilder<LoadMovieByGeneraCubit,LoadMovieByGeneraState>(builder: (context, state) {
                if (state is LoadMovieByGeneraLoading){
                  return BuildLoadShimmerMoviesSeeMore();

                }else if (state is LoadMovieByGeneraError){

                  return Center(
                    child: Text(state.message),
                  );


                }else if(state is LoadMovieByGeneraLoaded){



                  final movies = state.movies;

                  return  GridView.builder(

                    padding: EdgeInsets.only(left: 16,top:25),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: screenWidth * 0.023,
                      mainAxisSpacing: screenWidth * 0.023,
                      childAspectRatio: screenWidth / (screenHeight * 0.7),
                    ),
                    itemCount:movies.length,
                    itemBuilder: (context, index) {
                      return MovieItem(movieImageUrl: movies[index].imageUrl, movieRating: movies[index].rating, movie_id: movies[index].id);
                    },
                  );

                }else{

                  return Padding(
                    padding: const EdgeInsets.only(top:2 ),
                    child: BuildLoadShimmerMoviesSeeMore(),
                  );
                }
              },),
            ))
          ],
        ),
      ),
    );


  }
}