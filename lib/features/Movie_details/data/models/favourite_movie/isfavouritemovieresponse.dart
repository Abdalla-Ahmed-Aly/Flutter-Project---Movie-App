class IsMovieFavouriteResponse {
  final bool isFavourite;
  final String message;

  IsMovieFavouriteResponse({
    required this.isFavourite,
    required this.message,
  });

  factory IsMovieFavouriteResponse.fromJson(Map<String, dynamic> json) {
    return IsMovieFavouriteResponse(
      isFavourite: json["data"] ?? false,
      message: json["message"] ?? "",
    );
  }
}
