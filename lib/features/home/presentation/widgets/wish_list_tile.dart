import 'package:capstone_mobile_app/core/constants/app_colors.dart';
import 'package:capstone_mobile_app/core/widgets/app_button.dart';
import 'package:capstone_mobile_app/features/home/domain/model/wishlist_model.dart';
import 'package:capstone_mobile_app/features/home/presentation/bloc/fav_bloc/fav_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishListTile extends StatelessWidget {
  final WishListModel wishListModel;

  const WishListTile({super.key, required this.wishListModel});
  @override
  Widget build(BuildContext context) {
    final movie = wishListModel.movie!;

    return Container(
      height: 220,
      margin: EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: BoxBorder.all(color: AppColors.background),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 145,
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
                fit: BoxFit.fitHeight,
                "https://image.tmdb.org/t/p/w500/${wishListModel.movie!.posterPath}",
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    movie.title!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Language: ${movie.originalLanguage!}",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    movie.releaseDate!.year.toString(),
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "${movie.voteAverage!.toStringAsFixed(1)}/10",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppButton.icon(
                    icon: Icons.delete,
                    label: 'Remove',
                    onPressed: () {
                      BlocProvider.of<FavBloc>(
                        context,
                      ).add(DeleteWishList(wishListModel: wishListModel));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
