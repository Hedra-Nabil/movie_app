import 'package:dio/dio.dart';
import 'package:movie_app/movie_app/infra/models/movie_response.dart';

class MovieApiService {
  final Dio _dio = Dio();

  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _bearerToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0N2Q0NWQ2OWFhYzExNGUxMDI5MmQ0Zjc0YmQyNGVkYSIsIm5iZiI6MTc1MDU0MDUzNi4yMTUwMDAyLCJzdWIiOiI2ODU3MjBmODIxZDg1ZjBhMTZhNzkyNDgiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.0NT6a8V3X8KsunWM-fzKxHr-lqRxnNcLa9fSNYSPdIA';

  MovieApiService() {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.headers = {
      'Authorization': 'Bearer $_bearerToken',
      'accept': 'application/json',
    };

    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) => print(object),
      ),
    );
  }

  Future<MovieResponse> fetchNowPlayingMovies({required int page}) async {
    try {
      final response = await _dio.get(
        '/movie/now_playing',
        queryParameters: {'language': 'en-US', 'page': page},
      );

      return MovieResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<MovieResponse> fetchUpcomingMovies({required int page}) async {
    try {
      final response = await _dio.get(
        '/movie/upcoming',
        queryParameters: {'language': 'en-US', 'page': page},
      );

      return MovieResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<MovieResponse> fetchTopRatedMovies({required int page}) async {
    try {
      final response = await _dio.get(
        '/movie/top_rated',
        queryParameters: {'language': 'en-US', 'page': page},
      );

      return MovieResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<MovieResponse> fetchPopularMovies({required int page}) async {
    try {
      final response = await _dio.get(
        '/movie/popular',
        queryParameters: {'language': 'en-US', 'page': page},
      );

      return MovieResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Unexpected error: $e');
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
    } catch (e) {
      throw Exception('Unexpected error: $e');
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

  void dispose() {
    _dio.close();
  }
}
