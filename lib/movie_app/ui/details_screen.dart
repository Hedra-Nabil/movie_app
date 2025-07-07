import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie_app/domain/entities/movie.dart';
import 'package:movie/movie_app/domain/entities/movie_details.dart';
import 'package:movie/movie_app/presenter/controllers/movie_details/cubit/movie_details_cubit.dart';
import 'package:movie/movie_app/presenter/controllers/movie_details/cubit/movie_details_state.dart';
import 'package:movie/movie_app/presenter/controllers/watchlist/cubit/watchlist_state.dart';
import 'package:movie/movie_app/ui/widgets/movie_poster_card.dart';
import 'package:movie/movie_app/ui/widgets/cast_tab.dart';
import 'package:movie/movie_app/ui/widgets/reviews_tab.dart';
import 'package:movie/movie_app/presenter/controllers/watchlist/cubit/watchlist_cubit.dart';

class DetailsScreen extends StatefulWidget {
  final Movie movie;
  final bool isLarge;

  const DetailsScreen({super.key, required this.movie, required this.isLarge});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MovieDetailsCubit>().fetchMovieDetails(widget.movie.id);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFF222831),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFF222831),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Detail',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          actions: [_buildWatchlistButton(context)],
        ),
        body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
          builder: (context, state) {
            if (state is MovieDetailsLoading) {
              return _buildLoadingState();
            } else if (state is MovieDetailsError) {
              return _buildErrorState(state.message);
            } else if (state is MovieDetailsLoaded) {
              return _buildBody(context, state.movie);
            }
            return _buildLoadingState();
          },
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator(color: Colors.white));
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.white54, size: 64),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(color: Colors.white54, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<MovieDetailsCubit>().fetchMovieDetails(
                widget.movie.id,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF393E46),
            ),
            child: const Text('Retry', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildWatchlistButton(BuildContext context) {
    return BlocBuilder<WatchlistCubit, WatchlistState>(
      builder: (context, state) {
        final isInWatchlist = state.movieDetails.any(
          (m) => m.id == widget.movie.id,
        );
        return IconButton(
          icon: Icon(
            isInWatchlist ? Icons.bookmark : Icons.bookmark_border,
            color: Colors.white,
          ),
          onPressed: () => _toggleWatchlist(context, isInWatchlist),
          tooltip: isInWatchlist ? 'Remove from Watchlist' : 'Add to Watchlist',
        );
      },
    );
  }

  void _toggleWatchlist(BuildContext context, bool isInWatchlist) {
    final cubit = context.read<WatchlistCubit>();
    final movieDetailsState = context.read<MovieDetailsCubit>().state;

    if (movieDetailsState is MovieDetailsLoaded) {
      isInWatchlist
          ? cubit.removeFromWatchlist(movieDetails: movieDetailsState.movie)
          : cubit.addToWatchlist(movieDetails: movieDetailsState.movie);
    }
  }

  Widget _buildBody(BuildContext context, MovieDetails movieDetails) {
    return Column(
      children: [
        _buildHeaderImage(context, movieDetails),
        const SizedBox(height: 24),
        _buildMovieInfoRow(movieDetails),
        const SizedBox(height: 24),
        _buildTabBar(),
        Expanded(child: _buildTabContent(movieDetails)),
      ],
    );
  }

  Widget _buildHeaderImage(BuildContext context, MovieDetails movieDetails) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: widget.isLarge ? 260 : 180,
          child: CachedNetworkImage(
            imageUrl:
                movieDetails.fullBackdropUrl.isNotEmpty
                    ? movieDetails.fullBackdropUrl
                    : widget.movie.fullBackdropUrl,
            fit: BoxFit.cover,
            placeholder: (_, __) => Container(color: const Color(0xFF222831)),
            errorWidget:
                (_, __, ___) => Container(color: const Color(0xFF222831)),
          ),
        ),
        Container(
          width: double.infinity,
          height: widget.isLarge ? 260 : 180,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                const Color(0xFF222831).withOpacity(0.95),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.5, 1.0],
            ),
          ),
        ),
        Positioned(
          left: 20,
          bottom: 0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 100,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: MoviePosterCard(
                  movie: widget.movie,
                  isLarge: false,
                  showRating: false,
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width - 160,
                child: Text(
                  movieDetails.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 24,
          bottom: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF393E46),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.star_border_outlined,
                  color: Color(0xFFFFC107),
                  size: 18,
                ),
                const SizedBox(width: 4),
                Text(
                  movieDetails.voteAverage.toStringAsFixed(1),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMovieInfoRow(MovieDetails movieDetails) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: _buildInfoItem(
              Icons.calendar_today,
              movieDetails.releaseDate.isNotEmpty
                  ? movieDetails.releaseDate.split('-').first
                  : 'N/A',
            ),
          ),
          _buildDivider(),
          Expanded(
            child: _buildInfoItem(
              Icons.access_time,
              movieDetails.runtime != null
                  ? '${movieDetails.runtime} min'
                  : 'N/A',
            ),
          ),
          _buildDivider(),
          Expanded(
            child: _buildInfoItem(
              Icons.movie,
              movieDetails.genres.isNotEmpty
                  ? movieDetails.genres.first.name
                  : 'N/A',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white54, size: 18),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white54, fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 20,
      width: 1,
      color: const Color.fromARGB(60, 188, 184, 184),
      margin: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  Widget _buildTabBar() {
    return const TabBar(
      indicatorColor: Colors.white,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white54,
      labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      tabs: [Tab(text: 'About Movie'), Tab(text: 'Reviews'), Tab(text: 'Cast')],
    );
  }

  Widget _buildTabContent(MovieDetails movieDetails) {
    return TabBarView(
      children: [
        // About Movie Tab
        SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movieDetails.overview.isNotEmpty
                    ? movieDetails.overview
                    : 'No overview available.',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              if (movieDetails.tagline != null &&
                  movieDetails.tagline!.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  '"${movieDetails.tagline}"',
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
              if (movieDetails.genres.isNotEmpty) ...[
                const SizedBox(height: 16),
                const Text(
                  'Genres:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children:
                      movieDetails.genres.map((genre) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF393E46),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            genre.name,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ],
            ],
          ),
        ),

        // Reviews Tab
        ReviewsTab(movieId: movieDetails.id),

        // Cast Tab
        CastTab(movieId: movieDetails.id),
      ],
    );
  }
}
