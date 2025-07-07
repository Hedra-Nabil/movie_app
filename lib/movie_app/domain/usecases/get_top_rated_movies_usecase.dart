
import 'package:movie/movie_app/domain/entities/movie.dart';
import 'package:movie/movie_app/domain/infra/movie_repository.dart';

class GetTopRatedMoviesUseCase {
  final MovieRepository repository;

  GetTopRatedMoviesUseCase(this.repository);

  Future<List<Movie>> execute({required int page}) async {
    return await repository.getTopRatedMovies(page: page);
  }
}
