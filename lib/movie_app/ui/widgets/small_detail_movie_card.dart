
import 'package:flutter/material.dart';
import 'package:movie_app/movie_app/domain/entities/movie.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SmallDetailMovieCard extends StatelessWidget {
  final Movie movie;
  final bool isLarge;

  const SmallDetailMovieCard({
    super.key,
    required this.movie,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Movie tapped: ${movie.title}');
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
            _buildMovieInfo(),
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

  Widget _buildMovieInfo() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isLarge ? 18 : 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Column(
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
                  Icon(
                    Icons.airplane_ticket_outlined,
                    color: Colors.white.withOpacity(0.7),
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
                  if (movie.releaseDate.isNotEmpty)
                    Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.white.withOpacity(0.7),
                      size: 16,
                    ),

                  Text(
                    movie.releaseDate.split('-')[0],
                    style: const TextStyle(color: Colors.white60, fontSize: 12),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.timelapse_outlined,
                    color: Colors.white.withOpacity(0.7),
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
