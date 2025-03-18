import 'package:movieapp/features/Movie_details/data/models/favourite_movie/addtofavouriteresponse.dart';
import 'package:movieapp/features/Movie_details/data/models/favourite_movie/addtofavouritrequest.dart';

abstract class AddToFavouriteDataSource {
  Future<AddToFavouriteResponse> addToFavourite(AddToFavouriteRequest request);
  Future<bool> isMovieFavourite(String movieId);
  Future<void> deleteWatchList(int Movie_id);
}
