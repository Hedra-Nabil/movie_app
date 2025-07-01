import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movie_app/domain/usecases/get_now_playing_movies_usecase.dart';
import 'package:movie_app/movie_app/presenter/controllers/NowPlaying/cubit/now_playing_cubit.dart';
import 'package:movie_app/movie_app/presenter/controllers/NowPlaying/cubit/now_playing_state.dart';
import 'package:movie_app/movie_app/ui/widgets/movie_grid.dart';


class NowPlayingTab extends StatelessWidget {
  const NowPlayingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              NowPlayingCubit(context.read<GetNowPlayingMoviesUseCase>()),
      child: const _NowPlayingContent(),
    );
  }
}

class _NowPlayingContent extends StatefulWidget {
  const _NowPlayingContent();

  @override
  State<_NowPlayingContent> createState() => _NowPlayingContentState();
}

class _NowPlayingContentState extends State<_NowPlayingContent> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<NowPlayingCubit>().fetchNowPlayingMovies();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<NowPlayingCubit>().fetchNowPlayingMovies();
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
    return BlocBuilder<NowPlayingCubit, NowPlayingState>(
      builder: (context, state) {
        if (state is NowPlayingLoading && state.isFirstFetch) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NowPlayingLoaded || state is NowPlayingLoading) {
          final movies =
              state is NowPlayingLoaded
                  ? state.movies
                  : (state as NowPlayingLoading).oldMovies;

          final isLoadingMore = state is NowPlayingLoading;

          return MovieGrid(
            movies: movies,
            isLoading: isLoadingMore,
            controller: _scrollController,
          );
        } else if (state is NowPlayingError) {
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
