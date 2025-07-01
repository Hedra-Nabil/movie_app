import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movie_app/domain/usecases/get_popular_movies_usecase.dart';
import 'package:movie_app/movie_app/presenter/controllers/Popular/cubit/popular_cubit.dart';
import 'package:movie_app/movie_app/presenter/controllers/Popular/cubit/popular_state.dart';
import 'package:movie_app/movie_app/ui/widgets/movie_grid.dart';


class PopularTab extends StatelessWidget {
  const PopularTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => PopularCubit(context.read<GetPopularMoviesUseCase>()),
      child: const _PopularContent(),
    );
  }
}

class _PopularContent extends StatefulWidget {
  const _PopularContent();

  @override
  State<_PopularContent> createState() => _PopularContentState();
}

class _PopularContentState extends State<_PopularContent> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<PopularCubit>().fetchPopularMovies(); // First load

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<PopularCubit>().fetchPopularMovies(); // Load next page
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
    return BlocBuilder<PopularCubit, PopularState>(
      builder: (context, state) {
        if (state is PopularLoading && state.isFirstFetch) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PopularLoaded || state is PopularLoading) {
          final movies =
              state is PopularLoaded
                  ? state.movies
                  : (state as PopularLoading).oldMovies;

          final isLoadingMore = state is PopularLoading;

          return MovieGrid(
            movies: movies,
            isLoading: isLoadingMore,
            controller: _scrollController,
          );
        } else if (state is PopularError) {
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
