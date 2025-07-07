import 'package:movie/movie_app/domain/entities/movie.dart';

class MovieResponse {
  final Dates? dates;
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  MovieResponse({
    this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    try {
      return MovieResponse(
        dates: json['dates'] != null
            ? Dates.fromJson(json['dates'])
            : null,
        page: json['page'] ?? 1,
        results: (json['results'] as List<dynamic>)
            .map((movieJson) => Movie.fromJson(movieJson))
            .toList(),
        totalPages: json['total_pages'] ?? 0,
        totalResults: json['total_results'] ?? 0,
      );
    } catch (e) {
      print('Error parsing MovieResponse: $e');
      print('JSON data: $json');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      if (dates != null) 'dates': dates!.toJson(),
      'page': page,
      'results': results.map((movie) => movie.toJson()).toList(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }
}


class Dates {
  final String maximum;
  final String minimum;

  Dates({
    required this.maximum,
    required this.minimum,
  });

  factory Dates.fromJson(Map<String, dynamic> json) {
    return Dates(
      maximum: json['maximum'],
      minimum: json['minimum'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'maximum': maximum,
      'minimum': minimum,
    };
  }
}
