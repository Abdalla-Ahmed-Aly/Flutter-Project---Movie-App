import '../../../data/models/favourite_movie/addtofavouriteresponse.dart';

abstract class AddToFavouriteState {}

class AddToFavouriteInitial extends AddToFavouriteState {}

class AddToFavouriteLoading extends AddToFavouriteState {}

class AddToFavouriteLoaded extends AddToFavouriteState {
  final bool isFavourite;
  final bool isLoading;
  final String? errorMessage;

  AddToFavouriteLoaded({
    this.isFavourite = false,
    this.isLoading = false,
    this.errorMessage,
  });

  AddToFavouriteLoaded copyWith({
    bool? isFavourite,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AddToFavouriteLoaded(
      isFavourite: isFavourite ?? this.isFavourite,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class AddToFavouriteSuccess extends AddToFavouriteState {
  final AddToFavouriteResponse response;
  AddToFavouriteSuccess({required this.response});
}

class AddToFavouriteError extends AddToFavouriteState {
  final String errorMessage;
  AddToFavouriteError({required this.errorMessage});
}

class FavouriteSuccessdelete extends AddToFavouriteState {}

class Favouriteloadingdelete extends AddToFavouriteState {}

class FavouriteErrordlete extends AddToFavouriteState {
  String error;
  FavouriteErrordlete(this.error);
}
