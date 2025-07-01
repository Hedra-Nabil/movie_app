import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/theme/app_theme.dart';
import 'package:movie_app/movie_app/domain/usecases/get_now_playing_movies_usecase.dart';
import 'package:movie_app/movie_app/domain/usecases/get_popular_movies_usecase.dart';
import 'package:movie_app/movie_app/domain/usecases/get_top_rated_movies_usecase.dart';
import 'package:movie_app/movie_app/domain/usecases/get_upcoming_movies_usecase.dart';
import 'package:movie_app/movie_app/infra/datasources/movie_api_service.dart';
import 'package:movie_app/movie_app/infra/repository/movie_repository_impl.dart';
import 'package:movie_app/movie_app/presenter/controllers/Featured/cubit/featured_cubit.dart';
import 'package:movie_app/movie_app/presenter/controllers/NowPlaying/cubit/now_playing_cubit.dart';
import 'package:movie_app/movie_app/presenter/controllers/Popular/cubit/popular_cubit.dart';
import 'package:movie_app/movie_app/presenter/controllers/Upcoming/cubit/upcoming_cubit.dart';
import 'package:movie_app/movie_app/presenter/controllers/search/cubit/search_cubit.dart';
import 'package:movie_app/movie_app/presenter/controllers/top_rated/cubit/top_rated_cubit.dart';
import 'package:movie_app/movie_app/ui/main_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<MovieApiService>(create: (_) => MovieApiService()),
        RepositoryProvider<MovieRepositoryImpl>(
          create:
              (context) => MovieRepositoryImpl(context.read<MovieApiService>()),
        ),
        RepositoryProvider<GetNowPlayingMoviesUseCase>(
          create:
              (context) => GetNowPlayingMoviesUseCase(
                context.read<MovieRepositoryImpl>(),
              ),
        ),
        RepositoryProvider<GetTopRatedMoviesUseCase>(
          create:
              (context) =>
                  GetTopRatedMoviesUseCase(context.read<MovieRepositoryImpl>()),
        ),
        RepositoryProvider<GetPopularMoviesUseCase>(
          create:
              (context) =>
                  GetPopularMoviesUseCase(context.read<MovieRepositoryImpl>()),
        ),
        RepositoryProvider<GetUpcomingMoviesUseCase>(
          create:
              (context) =>
                  GetUpcomingMoviesUseCase(context.read<MovieRepositoryImpl>()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NowPlayingCubit>(
            create:
                (context) =>
                    NowPlayingCubit(context.read<GetNowPlayingMoviesUseCase>()),
          ),
          BlocProvider<TopRatedCubit>(
            create:
                (context) =>
                    TopRatedCubit(context.read<GetTopRatedMoviesUseCase>()),
          ),
          BlocProvider<PopularCubit>(
            create:
                (context) =>
                    PopularCubit(context.read<GetPopularMoviesUseCase>()),
          ),
          BlocProvider<UpcomingCubit>(
            create:
                (context) =>
                    UpcomingCubit(context.read<GetUpcomingMoviesUseCase>()),
          ),
          BlocProvider<FeaturedCubit>(
            create:
                (context) =>
                    FeaturedCubit(context.read<GetNowPlayingMoviesUseCase>()),
          ),
          BlocProvider<SearchCubit>(
            create: (context) => SearchCubit(context.read<MovieApiService>()),
          ),
        ],
        child: MaterialApp(
          title: 'Movie App',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
          home: const MainScreen(),
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: const TextScaler.linear(1.0)),
              child: child!,
            );
          },
        ),
      ),
    );
  }
}
