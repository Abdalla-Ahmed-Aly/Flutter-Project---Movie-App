import 'package:dartz/dartz.dart';
import 'package:movieapp/core/error/failure.dart';
import 'package:movieapp/core/error/serverfailure.dart';
import 'package:movieapp/features/Movie_details/data/data_sources/addtofavourite/addtofavouritedatasource.dart';
import 'package:movieapp/features/Movie_details/data/models/favourite_movie/addtofavouriteresponse.dart';
import 'package:movieapp/features/Movie_details/data/models/favourite_movie/addtofavouritrequest.dart';
import 'package:movieapp/features/onboarding/services/sharedpreferencekeys.dart';
import 'package:movieapp/features/onboarding/services/sharedpreferences.dart';

class AddToFavouriteRepository {
  final AddToFavouriteDataSource addToFavouriteDataSource;
  AddToFavouriteRepository({required this.addToFavouriteDataSource});

  Future<Either<Failure, AddToFavouriteResponse>> addToFavourite(
      AddToFavouriteRequest request) async {
    try {
      final response = await addToFavouriteDataSource.addToFavourite(request);
      final token = LocalStorageServices.getString(LocalStorageKeys.authToken);
      print(token);
      return Right(response);
    } catch (e) {
      return Left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, bool>> isMovieFavourite(String movieId) async {
    try {
      final response = await addToFavouriteDataSource.isMovieFavourite(movieId);
      return Right(response);
    } catch (e) {
      return Left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, void>> deleteWatchList(int movieId) async {
    try {
      await addToFavouriteDataSource.deleteWatchList(movieId);
      return const Right(null);
    } catch (e) {
      return Left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }
}
