import 'package:movie_app/movie_app/domain/entities/movie.dart';
import 'package:movie_app/movie_app/domain/entities/movie_details.dart';

abstract class MovieRepository {

  Future<List<Movie>> getNowPlayingMovies({required int page});
  Future<List<Movie>> getUpcomingMovies({required int page});
  Future<List<Movie>> getTopRatedMovies({required int page});
  Future<List<Movie>> getPopularMovies({required int page});
  Future<MovieDetails> getMovieDetails(int id);

}
