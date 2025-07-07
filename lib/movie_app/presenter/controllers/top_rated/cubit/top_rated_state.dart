import 'package:equatable/equatable.dart';
import 'package:movie/movie_app/domain/entities/movie.dart';

abstract class TopRatedState extends Equatable {
  const TopRatedState();

  @override
  List<Object?> get props => [];
}

class TopRatedInitial extends TopRatedState {}

class TopRatedLoading extends TopRatedState {
  final List<Movie> oldMovies;
  final bool isFirstFetch;

  const TopRatedLoading(this.oldMovies, {this.isFirstFetch = false});

  @override
  List<Object?> get props => [oldMovies, isFirstFetch];
}

class TopRatedLoaded extends TopRatedState {
  final List<Movie> movies;

  const TopRatedLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

class TopRatedError extends TopRatedState {
  final String message;

  const TopRatedError(this.message);

  @override
  List<Object?> get props => [message];
}
