import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie_app/infra/datasources/movie_api_service.dart';
import 'package:movie/movie_app/infra/models/reviews_model.dart';
import 'package:movie/movie_app/presenter/controllers/Reviews/cubit/reviews_cubit.dart';
import 'package:movie/movie_app/presenter/controllers/Reviews/cubit/reviews_state.dart';

class ReviewsTab extends StatelessWidget {
  final int movieId;

  const ReviewsTab({super.key, required this.movieId});

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              ReviewsCubit(context.read<MovieApiService>())
                ..fetchMovieReviews(movieId),
      child: BlocBuilder<ReviewsCubit, ReviewsState>(
        builder: (context, state) {
          if (state is ReviewsLoading || state is ReviewsInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ReviewsSuccess) {
            final reviews = state.response.results;
            if (reviews.isEmpty) {
              return const Center(
                child: Text(
                  'No reviews available for this movie yet.',
                  style: TextStyle(color: Colors.white54),
                ),
              );
            }
            return ReviewsList(reviews: reviews);
          } else if (state is ReviewsFailure) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }
          return const Center(child: Text('Something went wrong!'));
        },
      ),
    );
  }
}

class ReviewsList extends StatelessWidget {
  final List<Review> reviews;

  const ReviewsList({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: reviews.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final review = reviews[index];
        return ReviewCard(review: review);
      },
    );
  }
}

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({super.key, required this.review});

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(color: const Color.fromARGB(99, 127, 135, 176)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey.shade700,
                child: Text(
                  review.author.isNotEmpty
                      ? review.author[0].toUpperCase()
                      : '?',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 30,
                child: Text(
                  review.author,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  review.content,
                  style: const TextStyle(
                    color: Colors.white70,
                    height: 1.5,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                if (review.content.length > 200)
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                backgroundColor: const Color(0xFF393E46),
                                title: Text(
                                  'Review by ${review.author}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                content: SingleChildScrollView(
                                  child: Text(
                                    review.content,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text(
                                      'Close',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ],
                              ),
                        );
                      },
                      child: const Text(
                        'Show more',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
