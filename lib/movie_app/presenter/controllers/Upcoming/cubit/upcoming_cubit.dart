import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movie_app/domain/entities/movie.dart';
import 'package:movie_app/movie_app/domain/usecases/get_upcoming_movies_usecase.dart';

import 'upcoming_state.dart';

class UpcomingCubit extends Cubit<UpcomingState> {
  final GetUpcomingMoviesUseCase getUpcomingMoviesUseCase;

  int currentPage = 1;
  bool hasReachedEnd = false;
  List<Movie> movies = [];

  UpcomingCubit(this.getUpcomingMoviesUseCase) : super(UpcomingInitial()) {
    fetchUpcomingMovies();
  }

  Future<void> fetchUpcomingMovies() async {
    if (hasReachedEnd || state is UpcomingLoading) return;

    emit(UpcomingLoading(movies, isFirstFetch: currentPage == 1));

    try {
      final fetchedMovies = await getUpcomingMoviesUseCase.execute(page: currentPage);

      if (fetchedMovies.isEmpty) {
        hasReachedEnd = true;
      } else {
        movies.addAll(fetchedMovies);
        currentPage++;
      }

      emit(UpcomingLoaded(movies));
    } catch (e) {
      emit(UpcomingError('Failed to load upcoming movies: ${e.toString()}'));
    }
  }

  Future<void> refresh() async {
    currentPage = 1;
    hasReachedEnd = false;
    movies.clear();
    await fetchUpcomingMovies();
  }
}
