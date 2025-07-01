part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();


  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {
  const SearchInitial();
}

final class SearchLoading extends SearchState {
  const SearchLoading();
}

final class SearchLoaded extends SearchState {
  final List<Movie> movies;
  final String query;
  final bool hasMorePages;
  final int currentPage;

  const SearchLoaded({
    required this.movies,
    required this.query,
    this.hasMorePages = false,
    this.currentPage = 1,
  });

  @override
  List<Object> get props => [movies, query, hasMorePages, currentPage];
}

final class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}

final class SearchEmpty extends SearchState {
  final String query;

  const SearchEmpty(this.query);

  @override
  List<Object> get props => [query];
}

