import 'package:capstone_mobile_app/core/shared/error/failure.dart';
import 'package:capstone_mobile_app/features/home/domain/model/wishlist_model.dart';
import 'package:capstone_mobile_app/features/home/domain/repositories/wishlist_repository.dart';
import 'package:dartz/dartz.dart';

class GetWishListUsecase {
  final WishlistRepository repository;

  GetWishListUsecase(this.repository);

  Future<Either<Failure, List<WishListModel>>> call() async {
    return await repository.getWishList();
  }
}
