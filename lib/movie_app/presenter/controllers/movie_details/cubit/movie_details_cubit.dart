import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie_app/domain/infra/movie_repository.dart';
import 'package:movie/movie_app/presenter/controllers/movie_details/cubit/movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final MovieRepository repository;
  MovieDetailsCubit(this.repository) : super(MovieDetailsInitial());

  Future<void> fetchMovieDetails(int id) async {
    emit(MovieDetailsLoading());
    try {
      final movie = await repository.getMovieDetails(id);
      emit(MovieDetailsLoaded(movie));
        } catch (e) {
      emit(MovieDetailsError('Failed to load details'));
    }
  }
}
