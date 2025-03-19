class MovieModel {
  final int id;
  final String title;
  final double rating;
  final String imageUrl;
  final int year;

  MovieModel({
    required this.id,
    required this.title,
    required this.rating,
    required this.imageUrl,
    required this.year,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title_english'],
      rating: (json['rating'] as num).toDouble(),
      imageUrl: json['medium_cover_image'],
      year: json['year'],
    );
  }
}
