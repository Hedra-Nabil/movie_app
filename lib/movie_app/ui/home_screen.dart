import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movie_app/ui/widgets/featured_movie_card.dart';
import 'package:movie_app/movie_app/ui/widgets/now_playing_tab.dart';
import 'package:movie_app/movie_app/ui/widgets/popular_tab.dart';
import 'package:movie_app/movie_app/ui/widgets/search_bar_widget.dart';
import 'package:movie_app/movie_app/ui/widgets/top_rated_tab.dart';
import 'package:movie_app/movie_app/ui/widgets/upcoming_tab.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController controller;

  final List<String> categories = [
    'Now playing',
    'Upcoming',
    'Top rated',
    'Popular',
  ];

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    // context.read<FeaturedCubit>().fetchFeaturedMovies();
    // context.read<NowPlayingCubit>().fetchNowPlayingMovies();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        
        backgroundColor: const Color(0xFF222831),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'What do you want to watch?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 7),
                    SearchBarWidget(
                      controller: controller,
                      hintText: 'Search',
                      onChanged: (value) {
                        print('Search text: $value');
                      },
                      onClear: () {
                        controller.clear();
                      },
                    ),
                  ],
                ),
              ),
              const FeaturedMovieCard(),
              TabBar(
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(width: 3.0, color: Colors.blue),
                ),
                dividerHeight: 0,
                labelColor: Colors.white,
                unselectedLabelColor: const Color(0xFF7C7E80),
                labelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                unselectedLabelStyle: const TextStyle(fontSize: 14),
                tabs: categories.map((c) => Tab(text: c)).toList(),
              ),
              Expanded(
                child: TabBarView(
                  children: const [
                    NowPlayingTab(),
                    UpcomingTab(),
                    TopRatedTab(),
                    PopularTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
