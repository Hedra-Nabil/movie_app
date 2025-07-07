import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie_app/domain/entities/movie.dart';
import 'package:movie/movie_app/domain/usecases/get_top_rated_movies_usecase.dart';
import 'top_rated_state.dart';

class TopRatedCubit extends Cubit<TopRatedState> {
  final GetTopRatedMoviesUseCase getTopRatedMoviesUseCase;

  int currentPage = 1;
  bool hasReachedEnd = false;
  List<Movie> movies = [];

  TopRatedCubit(this.getTopRatedMoviesUseCase) : super(TopRatedInitial()) {
    fetchTopRatedMovies();
  }

  Future<void> fetchTopRatedMovies() async {
    if (hasReachedEnd || state is TopRatedLoading) return;

    emit(TopRatedLoading(movies, isFirstFetch: currentPage == 1));

    try {
      final fetchedMovies = await getTopRatedMoviesUseCase.execute(page: currentPage);

      if (fetchedMovies.isEmpty) {
        hasReachedEnd = true;
      } else {
        movies.addAll(fetchedMovies);
        currentPage++;
      }

      emit(TopRatedLoaded(movies));
    } catch (e) {
      emit(TopRatedError('Failed to load top rated movies: ${e.toString()}'));
    }
  }

  Future<void> refresh() async {
    currentPage = 1;
    hasReachedEnd = false;
    movies.clear();
    await fetchTopRatedMovies();
  }
}
