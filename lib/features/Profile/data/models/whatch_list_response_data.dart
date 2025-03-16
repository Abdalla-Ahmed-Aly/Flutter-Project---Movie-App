class WhatchListResponseData {
  final String? movieId;
  final String? name;
  final double? rating;
  final String? imageUrl;
  final String? year;

  const WhatchListResponseData({
    this.movieId,
    this.name,
    this.rating,
    this.imageUrl,
    this.year,
  });

  factory WhatchListResponseData.fromJson(Map<String, dynamic> json) {
    return WhatchListResponseData(
      movieId: json['movieId'] as String?,
      name: json['name'] as String?,
      rating: (json['rating'] as num?)?.toDouble(), // تحويل الرقم إلى double
      imageUrl: json['imageURL'] as String?, // تطابق الاسم مع JSON
      year: json['year'] as String?,
    );
  }
}
