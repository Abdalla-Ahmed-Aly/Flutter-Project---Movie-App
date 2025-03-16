class MovieSuggestionsResponse {
  final String status;
  final String statusMessage;
  final Data? data;

  MovieSuggestionsResponse({
    required this.status,
    required this.statusMessage,
    this.data,
  });

  factory MovieSuggestionsResponse.fromJson(Map<String, dynamic> json) {
    return MovieSuggestionsResponse(
      status: json['status'] ?? '',
      statusMessage: json['status_message'] ?? '',
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }


}

class Data {
  final int movieCount;
  final List<MovieSuggestions> movies;

  Data({
    required this.movieCount,
    required this.movies,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      movieCount: json['movie_count'] ?? 0,
      movies: (json['movies'] as List<dynamic>?)
              ?.map((v) => MovieSuggestions.fromJson(v))
              .toList() ??
          [],
    );
  }


}

class MovieSuggestions {
  final int id;
  final String url;
  final String imdbCode;
  final String title;
  final String titleEnglish;
  final String titleLong;
  final String slug;
  final int year;
  final double rating;
  final int runtime;
  final List<String> genres;
  final String summary;
  final String descriptionFull;
  final String synopsis;
  final String ytTrailerCode;
  final String language;
  final String mpaRating;
  final String backgroundImage;
  final String backgroundImageOriginal;
  final String smallCoverImage;
  final String mediumCoverImage;
  final String state;
  final String dateUploaded;
  final int dateUploadedUnix;

  MovieSuggestions({
    required this.id,
    required this.url,
    required this.imdbCode,
    required this.title,
    required this.titleEnglish,
    required this.titleLong,
    required this.slug,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.genres,
    required this.summary,
    required this.descriptionFull,
    required this.synopsis,
    required this.ytTrailerCode,
    required this.language,
    required this.mpaRating,
    required this.backgroundImage,
    required this.backgroundImageOriginal,
    required this.smallCoverImage,
    required this.mediumCoverImage,
    required this.state,
    required this.dateUploaded,
    required this.dateUploadedUnix,
  });

  factory MovieSuggestions.fromJson(Map<String, dynamic> json) {
    return MovieSuggestions(
      id: json['id'] ?? 0,
      url: json['url'] ?? '',
      imdbCode: json['imdb_code'] ?? '',
      title: json['title'] ?? '',
      titleEnglish: json['title_english'] ?? '',
      titleLong: json['title_long'] ?? '',
      slug: json['slug'] ?? '',
      year: json['year'] ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      runtime: json['runtime'] ?? 0,
      genres: List<String>.from(json['genres'] ?? []),
      summary: json['summary'] ?? '',
      descriptionFull: json['description_full'] ?? '',
      synopsis: json['synopsis'] ?? '',
      ytTrailerCode: json['yt_trailer_code'] ?? '',
      language: json['language'] ?? '',
      mpaRating: json['mpa_rating'] ?? '',
      backgroundImage: json['background_image'] ?? '',
      backgroundImageOriginal: json['background_image_original'] ?? '',
      smallCoverImage: json['small_cover_image'] ?? '',
      mediumCoverImage: json['medium_cover_image'] ?? '',
      state: json['state'] ?? '',

      torrents: (json['torrents'] as List<dynamic>?)
              ?.map((v) => Torrents.fromJson(v))
              .toList() ??
          [],
      dateUploaded: json['date_uploaded'] ?? '',
      dateUploadedUnix: json['date_uploaded_unix'] ?? 0,
    );
  }


}


