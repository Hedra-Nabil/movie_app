import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movie_app/domain/entities/movie.dart';
import 'package:movie_app/movie_app/domain/usecases/get_popular_movies_usecase.dart';

import 'popular_state.dart';

class PopularCubit extends Cubit<PopularState> {
  final GetPopularMoviesUseCase getPopularMoviesUseCase;

  int currentPage = 1;
  bool hasReachedEnd = false;
  List<Movie> movies = [];

  PopularCubit(this.getPopularMoviesUseCase) : super(PopularInitial()) {
    fetchPopularMovies();
  }

  Future<void> fetchPopularMovies() async {
    if (hasReachedEnd || state is PopularLoading) return;

    emit(PopularLoading(movies, isFirstFetch: currentPage == 1));

    try {
      final fetchedMovies = await getPopularMoviesUseCase.execute(page: currentPage);

      if (fetchedMovies.isEmpty) {
        hasReachedEnd = true;
      } else {
        movies.addAll(fetchedMovies);
        currentPage++;
      }

      emit(PopularLoaded(movies));
    } catch (e) {
      emit(PopularError('Failed to load popular movies: ${e.toString()}'));
    }
  }

  Future<void> refresh() async {
    currentPage = 1;
    hasReachedEnd = false;
    movies.clear();
    await fetchPopularMovies();
  }
}
