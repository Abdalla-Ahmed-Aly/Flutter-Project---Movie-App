class AddToFavouriteRequest {
  final String movieId;
  final String title;
  final String imageUrl;
  final String year;
  final int rating;

  AddToFavouriteRequest({
    required this.movieId,
    required this.title,
    required this.imageUrl,
    required this.year,
    required this.rating,
  });

  Map<String, dynamic> toJson() {
    return {
      "movieId": movieId,
      "name": title,
      "rating": rating,
      "imageURL": imageUrl,
      "year": year,
    };
  }
}
