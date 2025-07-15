import 'package:capstone_mobile_app/features/home/domain/model/movie_details_model.dart';
import 'package:capstone_mobile_app/features/home/domain/model/movie_model.dart';

extension MovieModelMapper on MovieModel {
  static MovieModel fromDetails(MovieDetailsModel details) {
    return MovieModel(
      adult: details.adult,
      backdropPath: details.backdropPath,
      genreIds: details.genres.map((g) => g.id).toList(),
      id: details.id,
      originalLanguage: details.originalLanguage,
      originalTitle: details.originalTitle,
      overview: details.overview,
      popularity: details.popularity,
      posterPath: details.posterPath,
      releaseDate: DateTime.tryParse(details.releaseDate),
      title: details.title,
      video: details.video,
      voteAverage: details.voteAverage,
      voteCount: details.voteCount,
    );
  }
}
