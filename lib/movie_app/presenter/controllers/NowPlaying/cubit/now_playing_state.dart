import 'package:equatable/equatable.dart';
import 'package:movie_app/movie_app/domain/entities/movie.dart';


abstract class NowPlayingState extends Equatable {
  const NowPlayingState();

  @override
  List<Object?> get props => [];
}

class NowPlayingInitial extends NowPlayingState {}

class NowPlayingLoading extends NowPlayingState {
  final List<Movie> oldMovies;
  final bool isFirstFetch;

  const NowPlayingLoading(this.oldMovies, {this.isFirstFetch = false});

  @override
  List<Object?> get props => [oldMovies, isFirstFetch];
}

class NowPlayingLoaded extends NowPlayingState {
  final List<Movie> movies;

  const NowPlayingLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

class NowPlayingError extends NowPlayingState {
  final String message;

  const NowPlayingError(this.message);

  @override
  List<Object?> get props => [message];
}
