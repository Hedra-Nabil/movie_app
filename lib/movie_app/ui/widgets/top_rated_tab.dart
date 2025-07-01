import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movie_app/domain/entities/movie.dart';
import 'package:movie_app/movie_app/presenter/controllers/top_rated/cubit/top_rated_cubit.dart';
import 'package:movie_app/movie_app/presenter/controllers/top_rated/cubit/top_rated_state.dart';
import 'package:movie_app/movie_app/ui/widgets/movie_grid.dart';


class TopRatedTab extends StatefulWidget {
  const TopRatedTab({super.key});

  @override
  State<TopRatedTab> createState() => _TopRatedTabState();
}

class _TopRatedTabState extends State<TopRatedTab> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<TopRatedCubit>().fetchTopRatedMovies();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<TopRatedCubit>().fetchTopRatedMovies();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopRatedCubit, TopRatedState>(
      builder: (context, state) {
        if (state is TopRatedLoading && state.isFirstFetch) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TopRatedLoaded || state is TopRatedLoading) {
          final movies = state is TopRatedLoaded
              ? state.movies
              : (state as TopRatedLoading).oldMovies;

          final isLoadingMore = state is TopRatedLoading;

          return MovieGrid(
            movies: movies,
            isLoading: isLoadingMore,
            controller: _scrollController,
          );
        } else if (state is TopRatedError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
