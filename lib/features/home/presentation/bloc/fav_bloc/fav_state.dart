part of 'fav_bloc.dart';

abstract class FavState extends Equatable {
  const FavState();

  @override
  List<Object?> get props => [];
}

class FavInitial extends FavState {}

class FavLoading extends FavState {}

class FavLoaded extends FavState {
  final List<WishListModel> favMoviesList;

  const FavLoaded({required this.favMoviesList});

  @override
  List<Object?> get props => [favMoviesList];
}

class FavError extends FavState {
  final Failure failure;

  const FavError(this.failure);

  @override
  List<Object?> get props => [failure];
}
