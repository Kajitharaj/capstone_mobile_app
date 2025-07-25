import 'package:capstone_mobile_app/core/shared/error/failure.dart';
import 'package:capstone_mobile_app/features/home/data/datasources/movie_service.dart';
import 'package:capstone_mobile_app/features/home/domain/model/movie_details_model.dart';
import 'package:capstone_mobile_app/features/home/domain/model/movie_model.dart';
import 'package:capstone_mobile_app/features/home/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieService movieService;

  MovieRepositoryImpl({required this.movieService});
  @override
  Future<Either<Failure, List<MovieModel>>> fetchMovies() async {
    try {
      final response = await movieService.fetchMovies();
      if (response.success) {
        final movieListmap = response.data as List<dynamic>;
        final movieList = movieListmap
            .map((data) => MovieModel.fromJson(data))
            .toList();
        return Right(movieList);
      } else {
        return Left(Failure(message: 'Something went wrong!, Try again'));
      }
    } catch (e) {
      return Left(Failure(exception: e, message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, MovieDetailsModel>> getMovieDetail(int? id) async {
    try {
      final response = await movieService.getMovieDetail(id);
      if (response.success) {
        final movieDetail = MovieDetailsModel.fromJson(response.data);
        return Right(movieDetail);
      } else {
        return Left(Failure(message: 'Something went wrong!, Try again'));
      }
    } catch (e) {
      return Left(Failure(exception: e, message: e.toString()));
    }
  }
}
