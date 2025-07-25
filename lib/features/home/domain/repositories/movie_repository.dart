import 'package:capstone_mobile_app/core/shared/error/failure.dart';
import 'package:capstone_mobile_app/features/home/domain/model/movie_details_model.dart';
import 'package:capstone_mobile_app/features/home/domain/model/movie_model.dart';
import 'package:dartz/dartz.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieModel>>> fetchMovies();
  Future<Either<Failure, MovieDetailsModel>> getMovieDetail(int? id);
}
