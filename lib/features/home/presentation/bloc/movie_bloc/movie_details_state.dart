part of 'movie_details_bloc.dart';

sealed class MovieDetailsState extends Equatable {
  const MovieDetailsState();

  @override
  List<Object?> get props => [];
}

final class MovieDetailsInitial extends MovieDetailsState {}

final class MovieDetailsLoading extends MovieDetailsState {}

final class MovieDetailsLoaded extends MovieDetailsState {
  final MovieDetailsModel movieDetail;
  final Color? dominantColor;

  const MovieDetailsLoaded({
    required this.movieDetail,
    required this.dominantColor,
  });

  @override
  List<Object?> get props => [movieDetail, dominantColor];
}

final class MovieDetailsError extends MovieDetailsState {
  final Failure failure;

  const MovieDetailsError(this.failure);

  @override
  List<Object?> get props => [failure];
}
