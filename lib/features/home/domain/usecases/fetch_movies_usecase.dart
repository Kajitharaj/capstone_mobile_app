import 'package:capstone_mobile_app/core/shared/error/failure.dart';
import 'package:capstone_mobile_app/features/home/domain/model/movie_model.dart';
import 'package:capstone_mobile_app/features/home/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class FetchMoviesUsecase {
  final MovieRepository repository;

  FetchMoviesUsecase({required this.repository});
  Future<Either<Failure, List<MovieModel>>> call() async {
    return await repository.fetchMovies();
  }
}
