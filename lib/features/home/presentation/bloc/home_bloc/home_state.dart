part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<MovieModel> moviesList;

  const HomeLoaded({required this.moviesList});

  @override
  List<Object> get props => [moviesList];
}

class HomeError extends HomeState {
  final Failure failure;

  const HomeError(this.failure);

  @override
  List<Object?> get props => [failure];
}
