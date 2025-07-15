import 'package:capstone_mobile_app/core/shared/error/failure.dart';
import 'package:capstone_mobile_app/features/home/domain/model/wishlist_model.dart';
import 'package:capstone_mobile_app/features/home/domain/repositories/wishlist_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteWishListUsecase {
  final WishlistRepository repository;

  DeleteWishListUsecase(this.repository);

  Future<Either<Failure, bool>> call(WishListModel model) async {
    final int? id = model.id;
    return await repository.deleteWishList(id);
  }
}
