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
        color: AppColors.background,
        border: BoxBorder.all(color: AppColors.background),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(16.0),
              child: Image.network(
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress?.cumulativeBytesLoaded ==
                      loadingProgress?.expectedTotalBytes) {
                    return child;
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
                fit: BoxFit.fitWidth,
                "https://image.tmdb.org/t/p/w500/${movie.posterPath}",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
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
