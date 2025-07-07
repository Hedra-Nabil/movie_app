import 'package:movie/movie_app/domain/entities/movie.dart';
import 'package:movie/movie_app/domain/infra/movie_repository.dart';

class GetPopularMoviesUseCase {
  final MovieRepository repository;

  GetPopularMoviesUseCase(this.repository);

  Future<List<Movie>> execute({required int page}) async {
    return await repository.getPopularMovies(page: page);
  }
}
