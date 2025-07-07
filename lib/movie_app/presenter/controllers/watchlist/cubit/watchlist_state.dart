import 'package:equatable/equatable.dart';
import 'package:movie/movie_app/domain/entities/movie.dart';
import 'package:movie/movie_app/domain/entities/movie_details.dart';

class WatchlistState extends Equatable {
  final List<MovieDetails> movieDetails;

  const WatchlistState({this.movieDetails = const []});

  @override
  List<Object?> get props => [movieDetails];
}
