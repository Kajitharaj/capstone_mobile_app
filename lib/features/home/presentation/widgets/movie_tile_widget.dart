import 'package:capstone_mobile_app/core/constants/app_colors.dart';
import 'package:capstone_mobile_app/features/home/domain/model/movie_model.dart';
import 'package:flutter/material.dart';

class MovieTile extends StatelessWidget {
  final MovieModel movie;

  const MovieTile({super.key, required this.movie});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: BoxBorder.all(color: AppColors.primaryContainer),
      ),
      child: Column(
        children: [
          Image.network(
            height: 260,
            fit: BoxFit.fitWidth,
            "https://image.tmdb.org/t/p/w500/${movie.posterPath}",
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              movie.title!,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
