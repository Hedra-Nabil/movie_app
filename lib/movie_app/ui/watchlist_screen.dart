import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie_app/domain/entities/movie_details.dart';
import 'package:movie/movie_app/ui/widgets/small_detail_movie_card.dart';
import 'package:movie/movie_app/presenter/controllers/watchlist/cubit/watchlist_cubit.dart';
import 'package:movie/movie_app/presenter/controllers/watchlist/cubit/watchlist_state.dart';

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
          if (state.movieDetails.isEmpty) {
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
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemCount: state.movieDetails.length, // Now this is correct
            itemBuilder: (context, index) {
              final movieDetails = state.movieDetails[index];
              return Dismissible(
                key: Key(movieDetails.id.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) => context
                    .read<WatchlistCubit>()
                    .removeFromWatchlist(movieDetails: movieDetails),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: SmallDetailMovieCard(
                      movie: movieDetails.toMovie(),
                      movieDetails: movieDetails,
                      isLarge: false),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
