import 'package:flutter/material.dart';
import 'package:movie/movie_app/domain/entities/movie.dart';
import 'package:movie/movie_app/domain/entities/movie_details.dart';
import 'package:movie/movie_app/ui/details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SmallDetailMovieCard extends StatelessWidget {
  final Movie movie;
  final MovieDetails? movieDetails;
  final bool isLarge;
  final VoidCallback? onTap;

  const SmallDetailMovieCard({
    super.key,
    required this.movie,
    this.movieDetails,
    this.isLarge = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          onTap ??
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailsScreen(movie: movie, isLarge: isLarge),
              ),
            );
          },
      child: Container(
        height: 120,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),

        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _buildPosterImage(),
            ),
            _buildMovieInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPosterImage() {
    return SizedBox(
      width: 80,
      height: 120,
      child:
          movie.posterPath != null && movie.posterPath!.isNotEmpty
              ? CachedNetworkImage(
                imageUrl: movie.fullPosterUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => _buildLoadingImage(),
                errorWidget: (context, url, error) => _buildFallbackImage(),
              )
              : _buildFallbackImage(),
    );
  }

  Widget _buildMovieInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SizedBox(
                  width: 140,
                  child: Text(
                    movie.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isLarge ? 18 : 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star_border_outlined,
                    color: Colors.amber,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    movie.formattedRating,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  if (movieDetails?.genres.isNotEmpty ?? false)
                    Icon(
                      Icons.movie_creation_outlined,
                      color: Colors.white.withOpacity(0.7),
                      size: 16,
                    ),
                  const SizedBox(width: 4),
                  if (movieDetails?.genres.isNotEmpty ?? false)
                    SizedBox(
                      width: 100,
                      child: Text(
                        movieDetails!.genres.isNotEmpty
                            ? movieDetails!.genres.first.name
                            : 'N/A',
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
              Row(
                children: [
                  if (movie.releaseDate.isNotEmpty)
                    Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.white.withOpacity(0.7),
                      size: 16,
                    ),

                  Text(
                    movie.releaseYear,
                    style: const TextStyle(color: Colors.white60, fontSize: 12),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.access_time_outlined,
                    color: Colors.white.withOpacity(0.7),
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    movieDetails?.runtime != null
                        ? '${movieDetails!.runtime} min'
                        : 'N/A',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFallbackImage() {
    return Container(
      width: 80,
      height: 120,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey[800]!, Colors.grey[600]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: Icon(Icons.movie, color: Colors.white54, size: 30),
      ),
    );
  }

  Widget _buildLoadingImage() {
    return Container(
      width: 80,
      height: 120,
      color: Colors.grey[800],
      child: const Center(
        child: CircularProgressIndicator(color: Colors.blue, strokeWidth: 2),
      ),
    );
  }
}
