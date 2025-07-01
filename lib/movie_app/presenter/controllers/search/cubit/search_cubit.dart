import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/movie_app/domain/entities/movie.dart';
import 'package:movie_app/movie_app/infra/datasources/movie_api_service.dart';

part 'search_state.dart';


class SearchCubit extends Cubit<SearchState> {
  final MovieApiService _apiService;
  
  SearchCubit(this._apiService) : super(SearchInitial());

  Future<void> searchMovies(String query, {int page = 1}) async {
    if (query.trim().isEmpty) {
      emit(SearchInitial());
      return;
    }

    if (page == 1) {
      emit(SearchLoading());
    }

    try {
      final response = await _apiService.searchMovies(query, page: page);
      
      if (response.results.isEmpty) {
        emit(SearchEmpty(query));
        return;
      }

      List<Movie> movies = [];
      if (state is SearchLoaded && page > 1) {
        
        final currentState = state as SearchLoaded;
        movies = [...currentState.movies, ...response.results];
      } else {
        movies = response.results;
      }

      emit(SearchLoaded(
        movies: movies,
        query: query,
        hasMorePages: page < response.totalPages,
        currentPage: page,
      ));
    } catch (e) {
      emit(SearchError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  void clearSearch() {
    emit(SearchInitial());
  }

  Future<void> loadMoreResults() async {
    if (state is SearchLoaded) {
      final currentState = state as SearchLoaded;
      if (currentState.hasMorePages) {
        await searchMovies(
          currentState.query,
          page: currentState.currentPage + 1,
        );
      }
    }
  }
}
