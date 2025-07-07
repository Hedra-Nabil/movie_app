import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie/movie_app/domain/entities/movie_details.dart';
import 'package:movie/movie_app/infra/models/credits_model.dart';
import 'package:movie/movie_app/infra/models/movie_response.dart';
import 'package:movie/movie_app/infra/models/reviews_model.dart';

class MovieApiService {
  final Dio _dio;
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _bearerToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0N2Q0NWQ2OWFhYzExNGUxMDI5MmQ0Zjc0YmQyNGVkYSIsIm5iZiI6MTc1MDU0MDUzNi4yMTUwMDAyLCJzdWIiOiI2ODU3MjBmODIxZDg1ZjBhMTZhNzkyNDgiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.0NT6a8V3X8KsunWM-fzKxHr-lqRxnNcLa9fSNYSPdIA';

  MovieApiService() : _dio = Dio() {
    _initializeDio();
  }

  void _initializeDio() {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.headers = {
      'Authorization': 'Bearer $_bearerToken',
      'accept': 'application/json',
    };

    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: false,
        logPrint: (object) => debugPrint(object.toString()),
      ),
    );
  }

  Future<MovieResponse> fetchNowPlayingMovies({required int page}) async {
    return _fetchMovies('/movie/now_playing', page);
  }

  Future<MovieResponse> fetchUpcomingMovies({required int page}) async {
    return _fetchMovies('/movie/upcoming', page);
  }

  Future<MovieResponse> fetchTopRatedMovies({required int page}) async {
    return _fetchMovies('/movie/top_rated', page);
  }

  Future<MovieResponse> fetchPopularMovies({required int page}) async {
    return _fetchMovies('/movie/popular', page);
  }

  Future<MovieDetails> fetchMovieDetails(int id) async {
    try {
      final response = await _dio.get('/movie/$id');
      return MovieDetails.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<MovieResponse> searchMovies(String query, {required int page}) async {
    try {
      final response = await _dio.get(
        '/search/movie',
        queryParameters: {
          'query': query,
          'include_adult': false,
          'language': 'en-US',
          'page': page,
        },
      );
      return MovieResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<MovieResponse> _fetchMovies(String endpoint, int page) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: {'language': 'en-US', 'page': page},
      );
      return MovieResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return Exception(
          'Connection timeout. Please check your internet connection.',
        );
      case DioExceptionType.sendTimeout:
        return Exception('Send timeout. Please try again.');
      case DioExceptionType.receiveTimeout:
        return Exception('Receive timeout. Please try again.');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message =
            error.response?.data?['status_message'] ?? 'Unknown error';
        return Exception('Server error ($statusCode): $message');
      case DioExceptionType.cancel:
        return Exception('Request was cancelled.');
      case DioExceptionType.connectionError:
        return Exception('No internet connection. Please check your network.');
      default:
        return Exception('Network error: ${error.message}');
    }
  }
  Future<CreditsResponse> getMovieCredits(int movieId) async {
    try {
      final response = await _dio.get('/movie/$movieId/credits');
      return CreditsResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<ReviewsResponse> getMovieReviews(int movieId, {int page = 1}) async {
    try {
      final response = await _dio.get(
        '/movie/$movieId/reviews',
        queryParameters: {'language': 'en-US', 'page': page},
      );
      return ReviewsResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }
  void dispose() {
    _dio.close();
  }
}
