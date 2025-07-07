import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie_app/domain/entities/movie_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'watchlist_state.dart';

class WatchlistCubit extends Cubit<WatchlistState> {
  static const _watchlistKey = 'watchlist_details';

  WatchlistCubit() : super(const WatchlistState()) {
    loadWatchlist();
  }

  Future<void> loadWatchlist() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_watchlistKey) ?? [];
    final movieDetails = jsonList
        .map((jsonMovie) => MovieDetails.fromJson(json.decode(jsonMovie)))
        .toList();
    emit(WatchlistState(movieDetails: movieDetails));
  }

  Future<void> _saveWatchlist(List<MovieDetails> movieDetails) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = movieDetails.map((m) => json.encode(m.toJson())).toList();
    await prefs.setStringList(_watchlistKey, jsonList);
  }

  void addToWatchlist({required MovieDetails movieDetails}) {
    final updated = [...state.movieDetails, movieDetails];
    emit(WatchlistState(movieDetails: updated));
    _saveWatchlist(updated);
  }

  void removeFromWatchlist({required MovieDetails movieDetails}) {
    final updated = state.movieDetails.where((m) => m.id != movieDetails.id).toList();
    emit(WatchlistState(movieDetails: updated));
    _saveWatchlist(updated);
  }
}
