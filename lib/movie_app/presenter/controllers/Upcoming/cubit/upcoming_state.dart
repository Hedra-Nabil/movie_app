import 'package:equatable/equatable.dart';
import 'package:movie/movie_app/domain/entities/movie.dart';

abstract class UpcomingState extends Equatable {
  const UpcomingState();

  @override
  List<Object?> get props => [];
}

class UpcomingInitial extends UpcomingState {}

class UpcomingLoading extends UpcomingState {
  final List<Movie> oldMovies;
  final bool isFirstFetch;

  const UpcomingLoading(this.oldMovies, {this.isFirstFetch = false});

  @override
  List<Object?> get props => [oldMovies, isFirstFetch];
}

class UpcomingLoaded extends UpcomingState {
  final List<Movie> movies;

  const UpcomingLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

class UpcomingError extends UpcomingState {
  final String message;

  const UpcomingError(this.message);

  @override
  List<Object?> get props => [message];
}
