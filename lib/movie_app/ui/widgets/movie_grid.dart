import 'package:flutter/material.dart';
import 'package:movie/movie_app/domain/entities/movie.dart';
import 'package:movie/movie_app/ui/widgets/movie_poster_card.dart';

class MovieGrid extends StatelessWidget {
  final List<Movie> movies;
  final bool isLoading;
  final ScrollController controller;

  const MovieGrid({
    super.key,
    required this.movies,
    required this.controller,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: GridView.builder(
        controller: controller,
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.65,
          crossAxisSpacing: 12,
          mainAxisSpacing: 16,
        ),
        itemCount: isLoading ? movies.length + 6 : movies.length,
        itemBuilder: (context, index) {
          if (index >= movies.length) {
            return _buildShimmerCard();
          }

          return MoviePosterCard(movie: movies[index], showRating: false);
        },
      ),
    );
  }

  Widget _buildShimmerCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: CircularProgressIndicator(color: Colors.blue, strokeWidth: 2),
      ),
    );
  }
}
