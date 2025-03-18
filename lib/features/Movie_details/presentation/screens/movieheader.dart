import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movieapp/core/widgets/customButton.dart';
import 'package:movieapp/features/Movie_details/presentation/cubits/addtofavouritecubit/addtofavouritecubit.dart';
import 'package:movieapp/features/Movie_details/presentation/cubits/addtofavouritecubit/addtofavouritestate.dart';
import 'package:movieapp/features/onboarding/services/sharedpreferencekeys.dart';
import 'package:movieapp/theme/apptheme.dart';
import 'package:movieapp/features/Movie_details/data/models/favourite_movie/addtofavouritrequest.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Profile/presentation/cubit/history/history_cubit.dart';
import '../../../Profile/presentation/cubit/history/history_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MovieHeader extends StatefulWidget {
  const MovieHeader({
    super.key,
    required this.screenHeight,
    required this.textTheme,
    required this.imageurl,
    required this.rating,
    required this.likes,
    required this.timecount,
    required this.title,
    required this.releaseDate,
    required this.screenwidth,
    required this.uRL,
    required this.movieId,
  });

  final double screenHeight;
  final double screenwidth;
  final TextTheme textTheme;
  final String imageurl;
  final double rating;
  final int likes;
  final int timecount;
  final String title;
  final int releaseDate;
  final String uRL;
  final String movieId;

  @override
  State<MovieHeader> createState() => _MovieHeaderState();
}

class _MovieHeaderState extends State<MovieHeader> {
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    context.read<AddToFavouritCubit>().checkIfMovieIsFavourite(widget.movieId);
  }

  Future<void> openMovieWebsite(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  void _addToFavourites(BuildContext context) {
    context.read<AddToFavouritCubit>().addToFavourite(
          AddToFavouriteRequest(
            movieId: widget.movieId,
            title: widget.title,
            imageUrl: widget.imageurl,
            year: widget.releaseDate.toString(),
            rating: widget.rating.toInt(),
          ),
        );
  }

  void removFromFavourite(String movieId) async {
    AddToFavouritCubit addToFavouritCubitCubit =
        context.read<AddToFavouritCubit>();
    isBookmarked = !await addToFavouritCubitCubit.deleteWatchList(
      movieId,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddToFavouritCubit, AddToFavouriteState>(
      listener: (context, state) {
        switch (state) {
          case AddToFavouriteError():
            Fluttertoast.showToast(
              msg: 'Failed to add "${widget.title}" to favorites',
              fontSize: 16,
              backgroundColor: AppTheme.primary,
              textColor: Colors.black,
              toastLength: Toast.LENGTH_SHORT,
            );
            break;

          case AddToFavouriteSuccess():
            Fluttertoast.showToast(
              msg: '"${widget.title}" added to favorites',
              fontSize: 16,
              backgroundColor: AppTheme.primary,
              textColor: Colors.black,
              toastLength: Toast.LENGTH_SHORT,
            );
            setState(() {
              isBookmarked = true;
            });
            break;

          case AddToFavouriteLoaded(
              :final isFavourite
            ): // Dart 3 pattern matching
            setState(() {
              isBookmarked = isFavourite;
            });
            print(isFavourite);
            break;

          case FavouriteSuccessdelete():
            Fluttertoast.showToast(
              msg: '"${widget.title}" removed from favorites',
              fontSize: 16,
              backgroundColor: AppTheme.primary,
              textColor: Colors.black,
              toastLength: Toast.LENGTH_SHORT,
            );
            break;

          case FavouriteErrordlete():
            Fluttertoast.showToast(
              msg: 'Failed to remove "${widget.title}" from favorites',
              fontSize: 16,
              backgroundColor: AppTheme.primary,
              textColor: Colors.black,
              toastLength: Toast.LENGTH_SHORT,
            );
            break;

          default:
            break;
        }
      },
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              height: widget.screenHeight * 0.64,
              width: double.infinity,
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppTheme.black.withOpacity(0.5),
                      AppTheme.black,
                    ],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcATop,
                child: Image.network(
                  widget.imageurl,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset("assets/images/failureloading.png",
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: double.infinity);
                  },
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: BlocBuilder<AddToFavouritCubit, AddToFavouriteState>(
                    builder: (context, state) {
                      bool isLoading = state is AddToFavouriteLoading;

                      return Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: AppTheme.white,

                              size: 30,
                            ),
                          ),

                          SizedBox(
                            height: widget.screenHeight * 0.068,
                            width: widget.screenwidth * 0.15,
                            child: isLoading
                                ? Center(
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: AppTheme.white,
                                        strokeWidth: 4,
                                      ),
                                    ),
                                  )
                                : IconButton(
                                    onPressed: () {
                                      if (!isBookmarked) {
                                        _addToFavourites(context);
                                      } else {
                                        removFromFavourite(widget.movieId);
                                      }
                                    },
                                    icon: Icon(
                                      isBookmarked
                                          ? Icons.bookmark_rounded
                                          : Icons.bookmark_outline_rounded,
                                      color: AppTheme.white,
                                      size: 40,
                                    ),
                                  ),
                          )
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: widget.screenHeight * 0.175),
                InkWell(
                  onTap: () { 
                    context.read<HistoryCubit>().addMovieID(widget.movieId);
                    openMovieWebsite(widget.uRL);}
                  child: Image.asset('assets/images/displaybutton.png'),
                ),
                SizedBox(height: widget.screenHeight * 0.15),
                Text(
                  widget.title,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${widget.releaseDate}',
                  style: widget.textTheme.displaySmall?.copyWith(
                    color: AppTheme.gray,
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CustomButton(
                      buttonTitle: AppLocalizations.of(context)!.watch,
                      buttonColor: AppTheme.red,
                      fontColor: AppTheme.white,
                      onPressed: () {
                        openMovieWebsite(widget.uRL);
                        context.read<HistoryCubit>().addMovieID(widget.movieId);
                        print(LocalStorageKeys.authToken);
                        print(widget.movieId);
                      }),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: widget.screenwidth * 0.30,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.gray,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/heart.png',
                              height: 25,
                              width: 28,
                            ),
                            SizedBox(width: 8),
                            Text(
                              '${widget.likes}',
                              style: widget.textTheme.displayMedium,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: widget.screenwidth * 0.28,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.gray,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/clock.png',
                              height: 25,
                              width: 28,
                            ),
                            SizedBox(width: 8),
                            Text(
                              '${widget.timecount}',
                              style: widget.textTheme.displayMedium,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: widget.screenwidth * 0.28,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.gray,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/star.png',
                              height: 25,
                              width: 28,
                            ),
                            SizedBox(width: 8),
                            Text(
                              '${widget.rating}',
                              style: widget.textTheme.displayMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );


  }
}
