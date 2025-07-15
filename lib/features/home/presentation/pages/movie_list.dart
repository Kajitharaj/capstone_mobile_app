import 'package:capstone_mobile_app/core/shared/enum/snackbar_enum.dart';
import 'package:capstone_mobile_app/core/util/navigator_helper.dart';
import 'package:capstone_mobile_app/features/home/presentation/bloc/home_bloc/movie_bloc.dart';
import 'package:capstone_mobile_app/features/home/presentation/widgets/movie_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieList extends StatelessWidget {
  const MovieList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (BuildContext context, HomeState state) {
            if (state is HomeError) {
              NavigatorHelper().showSnackBar(
                message: state.failure.message ?? '',
                type: SnackBarType.error,
              );
            }
          },
          builder: (context, state) {
            if (state is HomeInitial) {
              context.read<HomeBloc>().add(FetchMovies());
            }
            if (state is HomeLoading) return CircularProgressIndicator();
            if (state is HomeLoaded) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 3 / 5,
                ),
                itemCount: state.moviesList.length,
                itemBuilder: (context, index) {
                  return MovieTile(movie: state.moviesList[index]);
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
