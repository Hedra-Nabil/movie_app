import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movie_app/domain/entities/movie.dart';
import 'package:movie_app/movie_app/domain/usecases/get_now_playing_movies_usecase.dart';
import 'now_playing_state.dart';

class NowPlayingCubit extends Cubit<NowPlayingState> {
  final GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase;

  int currentPage = 1;
  bool hasReachedEnd = false;
  List<Movie> movies = [];

  NowPlayingCubit(this.getNowPlayingMoviesUseCase)
    : super(NowPlayingInitial()) {
    fetchNowPlayingMovies();
  }

  Future<void> fetchNowPlayingMovies() async {
    if (hasReachedEnd) return;

    emit(NowPlayingLoading(movies, isFirstFetch: currentPage == 1));

    try {
      final fetchedMovies = await getNowPlayingMoviesUseCase.execute(
        page: currentPage,
      );

      if (fetchedMovies.isEmpty) {
        hasReachedEnd = true;
      } else {
        currentPage++;
        movies.addAll(fetchedMovies);
      }

      emit(NowPlayingLoaded(movies));
    } catch (e) {
      emit(
        NowPlayingError('Failed to load now playing movies: ${e.toString()}'),
      );
    }
  }

  Future<void> refresh() async {
    currentPage = 1;
    hasReachedEnd = false;
    movies.clear();
    await fetchNowPlayingMovies();
  }

  List<Movie> getFeaturedMovies({int count = 5}) {
    return movies.take(count).toList();
  }
}
