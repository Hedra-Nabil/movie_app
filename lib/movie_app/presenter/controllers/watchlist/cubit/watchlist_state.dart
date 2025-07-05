import 'package:equatable/equatable.dart';
import 'package:movie_app/movie_app/domain/entities/movie.dart';

class WatchlistState extends Equatable {
  final List<Movie> movies;

  const WatchlistState({this.movies = const []});

  @override
  List<Object?> get props => [movies];
}
