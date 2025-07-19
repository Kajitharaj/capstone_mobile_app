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
      padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(top: 48),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
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
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.read<FavBloc>().add(LoadFavList());
                    });
                  }
                  if (state is FavLoading) return CircularProgressIndicator();
                  if (state is FavError) {
                    return Text('Something went wrong!');
                  }
                  if (state is FavLoaded) {
                    if (state.favMoviesList.isEmpty) {
                      return const Text(
                        'Your wish list is empty.',
                        style: TextStyle(color: Colors.white),
                      );
                    }
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
          ),
        ],
      ),
    );
  }

  _buildHeader() => SizedBox(
    height: 40,
    child: Text(
      'Wish List',
      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
    ),
  );
}
