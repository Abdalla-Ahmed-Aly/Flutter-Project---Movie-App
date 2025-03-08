class MovieDetails {
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
  final int downloadCount;
  final int likeCount;
  final String descriptionIntro;
  final String descriptionFull;
  final String ytTrailerCode;
  final String language;
  final String mpaRating;
  final String backgroundImage;
  final String backgroundImageOriginal;
  final String smallCoverImage;
  final String mediumCoverImage;
  final String largeCoverImage;
  final List<Torrent> torrents;
  final String dateUploaded;
  final int dateUploadedUnix;

  MovieDetails({
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
    required this.downloadCount,
    required this.likeCount,
    required this.descriptionIntro,
    required this.descriptionFull,
    required this.ytTrailerCode,
    required this.language,
    required this.mpaRating,
    required this.backgroundImage,
    required this.backgroundImageOriginal,
    required this.smallCoverImage,
    required this.mediumCoverImage,
    required this.largeCoverImage,
    required this.torrents,
    required this.dateUploaded,
    required this.dateUploadedUnix,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    return MovieDetails(
      id: json["id"],
      url: json["url"],
      imdbCode: json["imdb_code"],
      title: json["title"],
      titleEnglish: json["title_english"],
      titleLong: json["title_long"],
      slug: json["slug"],
      year: json["year"],
      rating: (json["rating"] as num).toDouble(),
      runtime: json["runtime"],
      genres: List<String>.from(json["genres"]),
      downloadCount: json["download_count"],
      likeCount: json["like_count"],
      descriptionIntro: json["description_intro"],
      descriptionFull: json["description_full"],
      ytTrailerCode: json["yt_trailer_code"],
      language: json["language"],
      mpaRating: json["mpa_rating"],
      backgroundImage: json["background_image"],
      backgroundImageOriginal: json["background_image_original"],
      smallCoverImage: json["small_cover_image"],
      mediumCoverImage: json["medium_cover_image"],
      largeCoverImage: json["large_cover_image"],
      torrents: List<Torrent>.from(json["torrents"].map((x) => Torrent.fromJson(x))),
      dateUploaded: json["date_uploaded"],
      dateUploadedUnix: json["date_uploaded_unix"],
    );
  }
}

class Torrent {
  final String url;
  final String hash;
  final String quality;
  final String type;
  final String videoCodec;
  final int seeds;
  final int peers;
  final String size;
  final int sizeBytes;
  final String dateUploaded;
  final int dateUploadedUnix;

  Torrent({
    required this.url,
    required this.hash,
    required this.quality,
    required this.type,
    required this.videoCodec,
    required this.seeds,
    required this.peers,
    required this.size,
    required this.sizeBytes,
    required this.dateUploaded,
    required this.dateUploadedUnix,
  });

  factory Torrent.fromJson(Map<String, dynamic> json) {
    return Torrent(
      url: json["url"],
      hash: json["hash"],
      quality: json["quality"],
      type: json["type"],
      videoCodec: json["video_codec"],
      seeds: json["seeds"],
      peers: json["peers"],
      size: json["size"],
      sizeBytes: json["size_bytes"],
      dateUploaded: json["date_uploaded"],
      dateUploadedUnix: json["date_uploaded_unix"],
    );
  }
}
