import 'package:capstone_mobile_app/core/shared/error/failure.dart';
import 'package:capstone_mobile_app/features/home/domain/model/movie_model.dart';
import 'package:capstone_mobile_app/features/home/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class AddToWishListUsecase {
  final MovieRepository repository;

  const AddToWishListUsecase(this.repository);

  Future<Either<Failure, bool>> call(MovieModel movie) {
    return repository.addToWishList(movie);
  }
}
