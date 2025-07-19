part of 'fav_bloc.dart';

sealed class FavEvent extends Equatable {
  const FavEvent();

  @override
  List<Object> get props => [];
}

class LoadFavList extends FavEvent {}

class ResetFavList extends FavEvent {}

class AddToWishList extends FavEvent {
  final MovieModel movieModel;

  const AddToWishList({required this.movieModel});

  @override
  List<Object> get props => [movieModel];
}

class DeleteWishList extends FavEvent {
  final WishListModel wishListModel;

  const DeleteWishList({required this.wishListModel});

  @override
  List<Object> get props => [wishListModel];
}
