import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movie_app/presenter/controllers/watchlist/cubit/watchlist_cubit.dart';
import 'package:movie_app/movie_app/presenter/controllers/watchlist/cubit/watchlist_state.dart';
import 'package:movie_app/movie_app/ui/widgets/small_detail_movie_card.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222831),
      appBar: AppBar(
        title: const Text('Watchlist'),
        backgroundColor: const Color(0xFF222831),
        centerTitle: true,
      ),
      body: BlocBuilder<WatchlistCubit, WatchlistState>(
        builder: (context, state) {
          if (state.movies.isEmpty) {
            return Center(
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/Group.png'),
                    const Text(
                      'There is no movie yet!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Find your movie by Type title,\n categories, years, etc ',
                      style: TextStyle(color: Colors.white60, fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          }
          return ListView.separated(
            itemCount: state.movies.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final movie = state.movies[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: SmallDetailMovieCard(movie: movie, isLarge: false),
              );
            },
          );
        },
      ),
    );
  }
}
