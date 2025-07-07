import 'package:movie/movie_app/domain/entities/movie.dart';
import 'package:movie/movie_app/domain/entities/movie_details.dart';
import 'package:movie/movie_app/domain/infra/movie_repository.dart';
import 'package:movie/movie_app/infra/datasources/movie_api_service.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieApiService apiService;

  MovieRepositoryImpl(this.apiService);

  @override
  Future<List<Movie>> getNowPlayingMovies({required int page}) async {
    try {
      final movieResponse = await apiService.fetchNowPlayingMovies(page: page);
      return movieResponse.results;
    } catch (e) {
      throw Exception('Failed to load now playing movies: $e');
    }
  }

  @override
  Future<List<Movie>> getUpcomingMovies({required int page}) async {
    try {
      final movieResponse = await apiService.fetchUpcomingMovies(page: page);
      return movieResponse.results;
    } catch (e) {
      throw Exception('Failed to load upcoming movies: $e');
    }
  }

  @override
  Future<List<Movie>> getTopRatedMovies({required int page}) async {
    try {
      final movieResponse = await apiService.fetchTopRatedMovies(page: page);
      return movieResponse.results;
    } catch (e) {
      throw Exception('Failed to load top rated movies: $e');
    }
  }

  @override
  Future<List<Movie>> getPopularMovies({required int page}) async {
    try {
      final movieResponse = await apiService.fetchPopularMovies(page: page);
      return movieResponse.results;
    } catch (e) {
      throw Exception('Failed to load popular movies: $e');
    }
  }

  @override
  Future<MovieDetails> getMovieDetails(int id) async {
    try {
      return await apiService.fetchMovieDetails(id);
    } catch (e) {
      throw Exception('Failed to load movie details: $e');
    }
  }
}
