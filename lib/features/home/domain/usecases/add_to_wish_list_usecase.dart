import 'package:capstone_mobile_app/core/shared/error/failure.dart';
import 'package:capstone_mobile_app/features/home/domain/model/movie_model.dart';
import 'package:capstone_mobile_app/features/home/domain/repositories/wishlist_repository.dart';
import 'package:dartz/dartz.dart';

class AddToWishListUsecase {
  final WishlistRepository repository;

  const AddToWishListUsecase(this.repository);

  Future<Either<Failure, bool>> call(MovieModel movie) {
    return repository.addToWishList(movie);
  }
}
