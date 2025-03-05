class Movie {
  final int id;
  final String title;
  final double rating;
  final String imageUrl;
  final int year;

  Movie({
    required this.id,
    required this.title,
    required this.rating,
    required this.imageUrl,
    required this.year,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title_english'],
      rating: (json['rating'] as num).toDouble(),
      imageUrl: json['medium_cover_image'],
      year: json['year'],
    );
  }
}
