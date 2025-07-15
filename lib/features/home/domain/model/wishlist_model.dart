import 'package:capstone_mobile_app/features/home/domain/model/movie_model.dart';

class WishListModel {
  int? id;
  MovieModel? movie;
  String? email;

  WishListModel({this.id, this.movie, this.email});

  factory WishListModel.fromJson(Map<String, dynamic> json) => WishListModel(
    id: json["id"],
    movie: json["movie"] == null ? null : MovieModel.fromJson(json["movie"]),
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "movie": movie?.toJson(),
    "email": email,
  };
}
