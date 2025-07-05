class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) =>
      Genre(id: json['id'], name: json['name']);

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class Movie {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final List<Genre>? genres;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
  final int? runtime;

  Movie({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    this.genres,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    this.runtime,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    adult: json['adult'],
    backdropPath: json['backdrop_path'],
    genreIds:
        json['genre_ids'] != null ? List<int>.from(json['genre_ids']) : [],
    genres:
        json['genres'] != null
            ? (json['genres'] as List).map((g) => Genre.fromJson(g)).toList()
            : null,
    id: json['id'],
    originalLanguage: json['original_language'],
    originalTitle: json['original_title'],
    overview: json['overview'],
    popularity:
        (json['popularity'] is int)
            ? (json['popularity'] as int).toDouble()
            : (json['popularity'] ?? 0.0).toDouble(),
    posterPath: json['poster_path'],
    releaseDate: json['release_date'] ?? '',
    title: json['title'],
    video: json['video'],
    voteAverage:
        (json['vote_average'] is int)
            ? (json['vote_average'] as int).toDouble()
            : (json['vote_average'] ?? 0.0).toDouble(),
    voteCount: json['vote_count'] ?? 0,
    runtime: json['runtime'],
  );

  Map<String, dynamic> toJson() => {
    'adult': adult,
    'backdrop_path': backdropPath,
    'genre_ids': genreIds,
    'genres': genres?.map((g) => g.toJson()).toList(),
    'id': id,
    'original_language': originalLanguage,
    'original_title': originalTitle,
    'overview': overview,
    'popularity': popularity,
    'poster_path': posterPath,
    'release_date': releaseDate,
    'title': title,
    'video': video,
    'vote_average': voteAverage,
    'vote_count': voteCount,
    'runtime': runtime,
  };

  String get fullPosterUrl =>
      posterPath != null ? 'https://image.tmdb.org/t/p/w500$posterPath' : '';

  String get fullBackdropUrl =>
      backdropPath != null
          ? 'https://image.tmdb.org/t/p/w500$backdropPath'
          : '';

  String get formattedRating => voteAverage.toStringAsFixed(1);

  String get releaseYear =>
      releaseDate.isNotEmpty ? releaseDate.substring(0, 4) : '';

  get details => null;
}
