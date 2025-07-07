import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie_app/infra/datasources/movie_api_service.dart';
import 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  final MovieApiService apiService;

  ReviewsCubit(this.apiService) : super(ReviewsInitial());

  Future<void> fetchMovieReviews(int movieId) async {
    emit(ReviewsLoading());
    try {
      final reviewsResponse = await apiService.getMovieReviews(movieId);
      emit(ReviewsSuccess(reviewsResponse));
    } catch (e) {
      emit(ReviewsFailure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
