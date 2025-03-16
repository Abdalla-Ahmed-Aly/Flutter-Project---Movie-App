class MoviesData {
  final String movieTitle;
  final int movieId;
  final String movieOverview;

  MoviesData(
      {required this.movieTitle,
      required this.movieId,
      required this.movieOverview});

  Map<String, dynamic> toFireBase() {
    return {
      'title': movieTitle,
      'id': movieId,
      'overview': movieOverview,
    };
  }

  factory MoviesData.fromFirebase(Map<String, dynamic> json) {
    return MoviesData(
      movieTitle: json['title'],
      movieId: json['id'],
      movieOverview: json['overview'],
    );
  }
}
