import 'package:equatable/equatable.dart';
import 'package:movie/movie_app/infra/models/reviews_model.dart';

abstract class ReviewsState extends Equatable {
  const ReviewsState();

  @override
  List<Object> get props => [];
}

class ReviewsInitial extends ReviewsState {}

class ReviewsLoading extends ReviewsState {}

class ReviewsSuccess extends ReviewsState {
  final ReviewsResponse response;

  const ReviewsSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class ReviewsFailure extends ReviewsState {
  final String errorMessage;

  const ReviewsFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
