import 'dart:async';

import 'package:capstone_mobile_app/core/shared/error/failure.dart';
import 'package:capstone_mobile_app/features/home/domain/model/wishlist_model.dart';
import 'package:capstone_mobile_app/features/home/domain/usecases/delete_wish_list_usecase.dart';
import 'package:capstone_mobile_app/features/home/domain/usecases/get_wish_list_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fav_event.dart';
part 'fav_state.dart';

class FavBloc extends Bloc<FavEvent, FavState> {
  final GetWishListUsecase getWishListUsecase;
  final DeleteWishListUsecase deleteWishListUsecase;

  FavBloc({
    required this.getWishListUsecase,
    required this.deleteWishListUsecase,
  }) : super(FavInitial()) {
    on<LoadFavList>(_onLoadFavList);
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
}
