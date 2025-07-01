

import 'package:movie_app/movie_app/domain/entities/movie.dart';
import 'package:movie_app/movie_app/domain/infra/movie_repository.dart';
import 'package:movie_app/movie_app/infra/datasources/movie_api_service.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieApiService apiService;

  MovieRepositoryImpl(this.apiService);

  @override
  Future<List<Movie>> getNowPlayingMovies({required int page}) async {
    final movieResponse = await apiService.fetchNowPlayingMovies(page: page);
    return movieResponse.results;
  }

  @override
  Future<List<Movie>> getUpcomingMovies({required int page}) async {
    final movieResponse = await apiService.fetchUpcomingMovies(page: page);
    return movieResponse.results;
  }

  @override
  Future<List<Movie>> getTopRatedMovies({required int page}) async {
    final movieResponse = await apiService.fetchTopRatedMovies(page: page);
    return movieResponse.results;
  }

  @override
  Future<List<Movie>> getPopularMovies({required int page}) async {
    final movieResponse = await apiService.fetchPopularMovies(page: page);
    return movieResponse.results;
  }
}
