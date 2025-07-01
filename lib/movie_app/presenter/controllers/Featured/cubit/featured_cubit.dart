import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movie_app/domain/entities/movie.dart';
import 'package:movie_app/movie_app/domain/usecases/get_now_playing_movies_usecase.dart';

import 'featured_state.dart';

class FeaturedCubit extends Cubit<FeaturedState> {
  final GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase;

  int currentPage = 1;
  bool hasReachedEnd = false;
  List<Movie> movies = [];

  FeaturedCubit(this.getNowPlayingMoviesUseCase) : super(FeaturedInitial()) {
    fetchFeaturedMovies();
  }

  Future<void> fetchFeaturedMovies() async {
    if (hasReachedEnd || state is FeaturedLoading) return;

    emit(FeaturedLoading(movies, isFirstFetch: currentPage == 1));

    try {
      final fetchedMovies =
          await getNowPlayingMoviesUseCase.execute(page: currentPage);

      if (fetchedMovies.isEmpty) {
        hasReachedEnd = true;
      } else {
        movies.addAll(fetchedMovies);
        currentPage++;
      }

      emit(FeaturedLoaded(movies));
    } catch (e) {
      emit(FeaturedError('Failed to load featured movies: ${e.toString()}'));
    }
  }

  Future<void> refresh() async {
    currentPage = 1;
    hasReachedEnd = false;
    movies.clear();
    await fetchFeaturedMovies();
  }
}
