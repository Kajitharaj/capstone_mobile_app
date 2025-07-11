part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();
  @override
  List<Object?> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<MovieModel> moviesList;

  const MovieLoaded({required this.moviesList});

  @override
  List<Object> get props => [moviesList];
}

class MovieError extends MovieState {
  final Failure failure;

  const MovieError(this.failure);

  @override
  List<Object?> get props => [failure];
}
