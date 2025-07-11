import 'package:capstone_mobile_app/core/shared/enum/snackbar_enum.dart';
import 'package:capstone_mobile_app/core/util/navigator_helper.dart';
import 'package:capstone_mobile_app/core/widgets/page_container.dart';
import 'package:capstone_mobile_app/features/home/presentation/bloc/bloc/movie_bloc.dart';
import 'package:capstone_mobile_app/features/home/presentation/widgets/movie_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: Center(
        child: BlocConsumer<MovieBloc, MovieState>(
          listener: (BuildContext context, MovieState state) {
            if (state is MovieError) {
              NavigatorHelper().showSnackBar(
                message: state.failure.message ?? '',
                type: SnackBarType.error,
              );
            }
          },
          builder: (context, state) {
            if (state is MovieInitial) {
              context.read<MovieBloc>().add(FetchMovies());
            }
            if (state is MovieLoading) return CircularProgressIndicator();
            if (state is MovieLoaded) {
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
