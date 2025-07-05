import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movie_app/domain/entities/movie.dart';
import 'package:movie_app/movie_app/domain/entities/movie_details.dart';
import 'package:movie_app/movie_app/presenter/controllers/watchlist/cubit/watchlist_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class WatchlistCubit extends Cubit<WatchlistState> {
  WatchlistCubit() : super(const WatchlistState()) {
    loadWatchlist();
  }

  Future<void> loadWatchlist() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList('watchlist') ?? [];
    final movies =
        jsonList
            .map((jsonMovie) => Movie.fromJson(json.decode(jsonMovie)))
            .toList();
    emit(WatchlistState(movies: movies));
  }

  Future<void> saveWatchlist(List<Movie> movies) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = movies.map((m) => json.encode(m.toJson())).toList();
    await prefs.setStringList('watchlist', jsonList);
  }

  void addToWatchlist(Movie movie, {required movieDetails}) {
    if (!state.movies.any((m) => m.id == movie.id)) {
      final updated = [...state.movies, movie];
      emit(WatchlistState(movies: updated));
      saveWatchlist(updated);
    }
  }

  void removeFromWatchlist(Movie movie, {required MovieDetails movieDetails}) {
    final updated = state.movies.where((m) => m.id != movie.id).toList();
    emit(WatchlistState(movies: updated));
    saveWatchlist(updated);
  }
}
