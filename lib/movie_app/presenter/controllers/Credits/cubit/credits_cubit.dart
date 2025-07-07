import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie_app/infra/datasources/movie_api_service.dart';
import 'credits_state.dart';

class CreditsCubit extends Cubit<CreditsState> {
  final MovieApiService apiService;

  CreditsCubit(this.apiService) : super(CreditsInitial()); 

  Future<void> fetchMovieCredits(int movieId) async {
    emit(CreditsLoading());
    try {
      final creditsResponse = await apiService.getMovieCredits(movieId);
      emit(CreditsSuccess(creditsResponse.cast));
    } catch (e) {
      emit(CreditsFailure(e.toString()));
    }
  }


  @override
  Future<void> close() {
    return super.close();
  }
}