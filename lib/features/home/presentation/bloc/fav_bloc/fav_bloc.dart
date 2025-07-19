import 'dart:async';

import 'package:capstone_mobile_app/core/shared/enum/snackbar_enum.dart';
import 'package:capstone_mobile_app/core/shared/error/failure.dart';
import 'package:capstone_mobile_app/core/util/navigator_helper.dart';
import 'package:capstone_mobile_app/features/home/domain/model/movie_model.dart';
import 'package:capstone_mobile_app/features/home/domain/model/wishlist_model.dart';
import 'package:capstone_mobile_app/features/home/domain/usecases/add_to_wish_list_usecase.dart';
import 'package:capstone_mobile_app/features/home/domain/usecases/delete_wish_list_usecase.dart';
import 'package:capstone_mobile_app/features/home/domain/usecases/get_wish_list_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fav_event.dart';
part 'fav_state.dart';

class FavBloc extends Bloc<FavEvent, FavState> {
  final GetWishListUsecase getWishListUsecase;
  final DeleteWishListUsecase deleteWishListUsecase;
  final AddToWishListUsecase addToWishListUsecase;

  FavBloc({
    required this.getWishListUsecase,
    required this.deleteWishListUsecase,
    required this.addToWishListUsecase,
  }) : super(FavInitial()) {
    on<LoadFavList>(_onLoadFavList);
    on<AddToWishList>(_onAddToWishList);
    on<DeleteWishList>(_onDeleteWishList);
  }

  FutureOr<void> _onLoadFavList(
    LoadFavList event,
    Emitter<FavState> emit,
  ) async {
    try {
      final result = await getWishListUsecase.call();
      result.fold(
        (l) => emit(FavError(l)),
        (r) => emit(FavLoaded(favMoviesList: r)),
      );
    } catch (e) {
      emit(FavError(Failure(exception: e)));
    }
  }

  _onAddToWishList(AddToWishList event, emit) async {
    try {
      final result = await addToWishListUsecase.call(event.movieModel);
      result.fold(
        (l) => NavigatorHelper().showSnackBar(
          message: l.message ?? 'Something went wrong!',
          type: SnackBarType.error,
        ),
        (r) {
          NavigatorHelper().showSnackBar(
            message: 'Movie Added to Wish List',
            type: SnackBarType.success,
          );
        },
      );
    } catch (e) {
      emit(FavError(Failure(exception: e)));
    }
  }

  _onDeleteWishList(DeleteWishList event, emit) async {
    try {
      final result = await deleteWishListUsecase.call(event.wishListModel);
      result.fold(
        (l) => NavigatorHelper().showSnackBar(
          message: l.message ?? 'Something went wrong!',
          type: SnackBarType.error,
        ),
        (r) {
          NavigatorHelper().showSnackBar(
            message: 'Movie removed from Wish List',
            type: SnackBarType.success,
          );
          add(LoadFavList());
        },
      );
    } catch (e) {
      emit(FavError(Failure(exception: e)));
    }
  }
}
