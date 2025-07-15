import 'package:capstone_mobile_app/core/shared/error/failure.dart';
import 'package:capstone_mobile_app/features/home/data/datasources/wishlist_service.dart';
import 'package:capstone_mobile_app/features/home/domain/model/movie_model.dart';
import 'package:capstone_mobile_app/features/home/domain/model/wishlist_model.dart';
import 'package:capstone_mobile_app/features/home/domain/repositories/wishlist_repository.dart';
import 'package:dartz/dartz.dart';

class WishlistRepositoryImpl extends WishlistRepository {
  final WishListService wishListService;

  WishlistRepositoryImpl({required this.wishListService});

  @override
  Future<Either<Failure, List<WishListModel>>> getWishList() async {
    try {
      final response = await wishListService.getWishList();
      if (response.success) {
        final movieListmap = response.data as List<dynamic>;
        final wishList = movieListmap
            .map((data) => WishListModel.fromJson(data))
            .toList();
        return Right(wishList);
      } else {
        return Left(Failure(message: 'Something went wrong!, Try again'));
      }
    } catch (e) {
      return Left(Failure(exception: e, message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> addToWishList(MovieModel movie) async {
    try {
      final response = await wishListService.addWishList(movie);
      if (response.success) {
        return Right(true);
      } else {
        return Right(false);
      }
    } catch (e) {
      return Left((Failure(exception: e, message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteWishList(int? id) async {
    try {
      final response = await wishListService.deleteWishList(id);
      if (response.success) {
        return Right(true);
      } else {
        return Right(false);
      }
    } catch (e) {
      return Left((Failure(exception: e, message: e.toString())));
    }
  }
}
