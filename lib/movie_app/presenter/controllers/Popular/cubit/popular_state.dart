import 'package:equatable/equatable.dart';
import 'package:movie_app/movie_app/domain/entities/movie.dart';

abstract class PopularState extends Equatable {
  const PopularState();

  @override
  List<Object?> get props => [];
}

class PopularInitial extends PopularState {}

class PopularLoading extends PopularState {
  final List<Movie> oldMovies;
  final bool isFirstFetch;

  const PopularLoading(this.oldMovies, {this.isFirstFetch = false});

  @override
  List<Object?> get props => [oldMovies, isFirstFetch];
}

class PopularLoaded extends PopularState {
  final List<Movie> movies;

  const PopularLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

class PopularError extends PopularState {
  final String message;

  const PopularError(this.message);

  @override
  List<Object?> get props => [message];
}
