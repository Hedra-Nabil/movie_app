import 'package:equatable/equatable.dart';

class ReviewsResponse extends Equatable {
  final int id;
  final int page;
  final List<Review> results;
  final int totalPages;
  final int totalResults;

  const ReviewsResponse({
    required this.id,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory ReviewsResponse.fromJson(Map<String, dynamic> json) {
    return ReviewsResponse(
      id: json['id'],
      page: json['page'],
      results:
          (json['results'] as List).map((e) => Review.fromJson(e)).toList(),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }

  @override
  List<Object?> get props => [id, page, results, totalPages, totalResults];
}

class Review extends Equatable {
  final String author;
  final String content;
  final String createdAt;

  const Review({
    required this.author,
    required this.content,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      author: json['author'],
      content: json['content'],
      createdAt: json['created_at'],
    );
  }

  @override
  List<Object?> get props => [author, content, createdAt];
}
