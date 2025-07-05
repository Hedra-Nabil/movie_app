import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movie_app/presenter/controllers/Upcoming/cubit/upcoming_cubit.dart';
import 'package:movie_app/movie_app/presenter/controllers/Upcoming/cubit/upcoming_state.dart';
import 'package:movie_app/movie_app/ui/widgets/movie_grid.dart';

class UpcomingTab extends StatefulWidget {
  const UpcomingTab({super.key});

  @override
  State<UpcomingTab> createState() => _UpcomingTabState();
}

class _UpcomingTabState extends State<UpcomingTab> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<UpcomingCubit>().fetchUpcomingMovies();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<UpcomingCubit>().fetchUpcomingMovies();
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
    return BlocBuilder<UpcomingCubit, UpcomingState>(
      builder: (context, state) {
        if (state is UpcomingLoading && state.isFirstFetch) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UpcomingLoaded || state is UpcomingLoading) {
          final movies =
              state is UpcomingLoaded
                  ? state.movies
                  : (state as UpcomingLoading).oldMovies;

          final isLoadingMore = state is UpcomingLoading;

          return MovieGrid(
            movies: movies,
            isLoading: isLoadingMore,
            controller: _scrollController,
          );
        } else if (state is UpcomingError) {
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
