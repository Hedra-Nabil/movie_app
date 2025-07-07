import 'package:movie/movie_app/domain/entities/movie.dart';
import 'package:movie/movie_app/domain/infra/movie_repository.dart';

class GetNowPlayingMoviesUseCase {
  final MovieRepository repository;

  GetNowPlayingMoviesUseCase(this.repository);

  Future<List<Movie>> execute({required int page}) async {
    return await repository.getNowPlayingMovies(page: page);
  }
}
