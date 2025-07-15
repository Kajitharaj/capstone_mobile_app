part of 'movie_bloc.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchMovies extends HomeEvent {}

class AddToWishList extends HomeEvent {
  final MovieModel movieModel;

  AddToWishList({required this.movieModel});

  @override
  List<Object> get props => [movieModel];
}
