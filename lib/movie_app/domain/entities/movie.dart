class Movie {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
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

  Movie({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
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
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    try {
      return Movie(
        id: json['id'] ?? 0,
        title: json['title'] ?? '',
        overview: json['overview'] ?? '',
        posterPath: json['poster_path'], 
        releaseDate: json['release_date'] ?? '',
        voteAverage: (json['vote_average'] ?? 0.0).toDouble(),
        adult: json['adult'] ?? false,
        genreIds: [
          ...(json['genre_ids'] as List<dynamic>?)
                  ?.map((e) => e as int)
                  .toList() ??
              [],
        ],
        originalLanguage: '${json['original_language'] ?? 'en'}',
        originalTitle: '${json['original_title'] ?? ''}',
        popularity: (json['popularity'] ?? 0.0).toDouble(),
        backdropPath: json['backdrop_path'],
        video: json['video'] ?? false,
        voteCount: json['vote_count'] ?? 0,
        
      );
    } catch (e) {
      print('Error parsing Movie: $e');
      print('Movie JSON: $json');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'genre_ids': genreIds,
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
    };
  }

  String get fullPosterUrl =>
      posterPath != null ? 'https://image.tmdb.org/t/p/w500$posterPath' : '';

  String get fullBackdropUrl =>
      backdropPath != null
          ? 'https://image.tmdb.org/t/p/w500$backdropPath'
          : '';

  String get formattedRating => voteAverage.toStringAsFixed(1);

  String get releaseYear =>
      releaseDate.isNotEmpty ? releaseDate.substring(0, 4) : '';
}
