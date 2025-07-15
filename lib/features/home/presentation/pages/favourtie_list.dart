import 'package:capstone_mobile_app/core/shared/enum/snackbar_enum.dart';
import 'package:capstone_mobile_app/core/util/navigator_helper.dart';
import 'package:capstone_mobile_app/features/home/presentation/bloc/fav_bloc/bloc/fav_bloc.dart';
import 'package:capstone_mobile_app/features/home/presentation/widgets/movie_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteList extends StatelessWidget {
  const FavouriteList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(
        child: BlocConsumer<FavBloc, FavState>(
          listener: (BuildContext context, FavState state) {
            if (state is FavError) {
              NavigatorHelper().showSnackBar(
                message: state.failure.message ?? '',
                type: SnackBarType.error,
              );
            }
          },
          builder: (context, state) {
            if (state is FavInitial) {
              context.read<FavBloc>().add(LoadFavList());
            }
            if (state is FavLoading) return CircularProgressIndicator();
            if (state is FavLoaded) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 3 / 5,
                ),
                itemCount: state.favMoviesList.length,
                itemBuilder: (context, index) {
                  return MovieTile(movie: state.favMoviesList[index].movie!);
                },
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
