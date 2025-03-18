import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/error/exception.dart';
import 'package:movieapp/features/Movie_details/data/models/favourite_movie/addtofavouritrequest.dart';
import 'package:movieapp/features/Movie_details/data/repositories/addtofavouriterepo.dart';
import 'package:movieapp/features/Movie_details/presentation/cubits/addtofavouritecubit/addtofavouritestate.dart';
import 'package:movieapp/features/Profile/data/repositories/whtchListrepository.dart';
import 'package:movieapp/features/Profile/data/data_sources/auth_remote_api_data_sources.dart';

class AddToFavouritCubit extends Cubit<AddToFavouriteState> {
  final AddToFavouriteRepository addToFavouriteRepository;
  final Whtchlistrepository watchListRepository =
      Whtchlistrepository(AuthRemoteApiDataSources());

  AddToFavouritCubit({required this.addToFavouriteRepository})
      : super(AddToFavouriteInitial());

  Future<void> addToFavourite(AddToFavouriteRequest request) async {
    emit(AddToFavouriteLoading());
    try {
      final result = await addToFavouriteRepository.addToFavourite(request);
      result.fold(
        (failure) {
          emit(AddToFavouriteError(errorMessage: failure.message));
        },
        (response) {
          emit(AddToFavouriteSuccess(response: response));
        },
      );
    } catch (e) {
      emit(AddToFavouriteError(errorMessage: e.toString()));
    }
  }

  Future<bool> deleteWatchList(String movieId) async {
    try {
      emit(AddToFavouriteLoading());
      await watchListRepository.deleteWatchList(
        int.parse(movieId),
      );
      emit(FavouriteSuccessdelete());
      return true;
    } on AppException catch (e) {
      emit(FavouriteErrordlete(e.message));
      return false;
    }
  }

  Future<void> checkIfMovieIsFavourite(String movieId) async {
    emit(AddToFavouriteLoading());

    final result = await addToFavouriteRepository.isMovieFavourite(movieId);
    result.fold(
      (failure) {
        emit(AddToFavouriteError(errorMessage: failure.message));
      },
      (isFavourite) {
        emit(AddToFavouriteLoaded(isFavourite: isFavourite));
      },
    );
  }
}
