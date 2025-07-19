import 'package:capstone_mobile_app/core/shared/enum/snackbar_enum.dart';
import 'package:capstone_mobile_app/core/util/navigator_helper.dart';
import 'package:capstone_mobile_app/features/home/presentation/bloc/fav_bloc/fav_bloc.dart';
import 'package:capstone_mobile_app/features/home/presentation/widgets/wish_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishList extends StatelessWidget {
  const WishList({super.key});

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
            if (state is FavLoading) return CircularProgressIndicator();
            if (state is FavError) {
              return Text('Something went wrong!');
            }
            if (state is FavLoaded) {
              return ListView.builder(
                itemCount: state.favMoviesList.length,
                itemBuilder: (context, index) {
                  return WishListTile(
                    wishListModel: state.favMoviesList[index],
                  );
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
