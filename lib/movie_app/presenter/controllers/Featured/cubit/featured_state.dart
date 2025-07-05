import 'package:equatable/equatable.dart';
import 'package:movie_app/movie_app/domain/entities/movie.dart';
abstract class FeaturedState extends Equatable {
  const FeaturedState();

  @override
  List<Object?> get props => [];
}

class FeaturedInitial extends FeaturedState {}

class FeaturedLoading extends FeaturedState {
  final List<Movie> oldMovies;
  final bool isFirstFetch;

  const FeaturedLoading(this.oldMovies, {this.isFirstFetch = false});

  @override
  List<Object?> get props => [oldMovies, isFirstFetch];
}

class FeaturedLoaded extends FeaturedState {
  final List<Movie> movies;

  const FeaturedLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

class FeaturedError extends FeaturedState {
  final String message;

  const FeaturedError(this.message);

  @override
  List<Object?> get props => [message];
}
