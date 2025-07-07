import 'package:equatable/equatable.dart';
import 'package:movie/movie_app/infra/models/credits_model.dart';


abstract class CreditsState extends Equatable {
  const CreditsState();

  @override
  List<Object> get props => [];
}

class CreditsInitial extends CreditsState {}

class CreditsLoading extends CreditsState {}

class CreditsSuccess extends CreditsState {
  final List<Cast> cast;

  const CreditsSuccess(this.cast);

  @override
  List<Object> get props => [cast];
}

class CreditsFailure extends CreditsState {
  final String errorMessage;

  const CreditsFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
