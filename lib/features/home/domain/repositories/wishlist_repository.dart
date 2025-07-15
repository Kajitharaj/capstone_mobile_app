import 'package:capstone_mobile_app/core/shared/error/failure.dart';
import 'package:capstone_mobile_app/features/home/domain/model/wishlist_model.dart';
import 'package:dartz/dartz.dart';

abstract class WishlistRepository {
  Future<Either<Failure, List<WishListModel>>> getWishList();
  Future<Either<Failure, bool>> deleteWishList(int? id);
}
