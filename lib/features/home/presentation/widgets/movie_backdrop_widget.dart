import 'package:capstone_mobile_app/core/di/service_locator.dart';
import 'package:capstone_mobile_app/core/util/color_util.dart';
import 'package:capstone_mobile_app/core/widgets/app_button.dart';
import 'package:capstone_mobile_app/features/home/domain/model/movie_details_model.dart';
import 'package:capstone_mobile_app/features/home/domain/model/movie_model_mapper.dart';
import 'package:capstone_mobile_app/features/home/presentation/bloc/fav_bloc/fav_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieBackdrop extends StatelessWidget {
  final MovieDetailsModel movie;
  final Color bgColor;
  const MovieBackdrop({required this.movie, required this.bgColor, super.key});

  get backgroundImage =>
      "https://image.tmdb.org/t/p/w500/${movie.backdropPath}";
  get posterImage => "https://image.tmdb.org/t/p/w500/${movie.posterPath}";

  @override
  Widget build(BuildContext context) {
    final textColor = ColorUtil.getContrastingTextColor(bgColor);

    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        color: bgColor,
        child: Stack(
          children: [
            _buildBackdrop(),
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 100),
                  _buildPoster(),
                  _buildTitle(textColor),
                  if (movie.tagline!.isNotEmpty) _buildTagline(textColor),
                  _buildReleaseDate(textColor),
                  _buildRating(textColor, context),
                  _buildLang(textColor),
                  _buildGenreAndProd(textColor),
                  _buildOverview(textColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildOverview(Color textColor) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        movie.overview!,
        style: TextStyle(color: textColor, fontSize: 20),
      ),
    );
  }

  Padding _buildReleaseDate(Color textColor) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        movie.releaseDate,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Text _buildTagline(Color textColor) {
    return Text(
      movie.tagline!,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: textColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Padding _buildTitle(Color textColor) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        movie.title,
        style: TextStyle(
          color: textColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _buildRating(textColor, context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 28),
            const SizedBox(width: 8),
            Text(
              "${movie.voteAverage.toStringAsFixed(1)} / 10",
              style: TextStyle(
                color: textColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Spacer(flex: 1),
        Flexible(
          flex: 2,
          child: AppButton.elevated(
            text: 'Add To Favourites',
            onPressed: () {
              BlocProvider.of<FavBloc>(context).add(
                AddToWishList(movieModel: MovieModelMapper.fromDetails(movie)),
              );
            },
          ),
        ),
      ],
    );
  }

  _buildLang(textColor) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.language, size: 24, color: Colors.blueGrey),
          const SizedBox(width: 8),
          Text(
            "Language: ${movie.originalLanguage.toUpperCase()}",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: textColor.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenreAndProd(textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 16),
        Text(
          "Genres",
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: movie.genres.map((genre) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: textColor.withOpacity(0.1),
                border: Border.all(color: textColor.withOpacity(0.4)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                genre.name,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        Text(
          "Production",
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: movie.productionCompanies.map((company) {
              return Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: textColor.withOpacity(0.1),
                  border: Border.all(color: textColor.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  company.name,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPoster() {
    return Container(
      height: 250,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.4),
            blurRadius: 100,
            offset: const Offset(0, -44),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Image.network(
        posterImage,
        fit: BoxFit.fitWidth,
        color: bgColor.withValues(alpha: 0.4),
        colorBlendMode: BlendMode.darken,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress?.cumulativeBytesLoaded ==
              loadingProgress?.expectedTotalBytes) {
            return child;
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildBackdrop() {
    return Image.network(
      backgroundImage,
      color: bgColor.withValues(alpha: 0.4), // overlay color
      colorBlendMode: BlendMode.darken, // or try multiply / overlay
      fit: BoxFit.fitWidth,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress?.cumulativeBytesLoaded ==
            loadingProgress?.expectedTotalBytes) {
          return child;
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
