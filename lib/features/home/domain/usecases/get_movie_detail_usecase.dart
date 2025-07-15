import 'package:capstone_mobile_app/core/shared/error/failure.dart';
import 'package:capstone_mobile_app/features/home/domain/model/movie_details_model.dart';
import 'package:capstone_mobile_app/features/home/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class GetMovieDetailUsecase {
  final MovieRepository repository;

  GetMovieDetailUsecase(this.repository);

  Future<Either<Failure, MovieDetailsModel>> call(int? id) async {
    return await repository.getMovieDetail(id);
  }
}
