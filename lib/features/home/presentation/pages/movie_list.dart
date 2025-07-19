import 'package:capstone_mobile_app/core/constants/route_constants.dart';
import 'package:capstone_mobile_app/core/shared/enum/snackbar_enum.dart';
import 'package:capstone_mobile_app/core/util/navigator_helper.dart';
import 'package:capstone_mobile_app/features/home/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:capstone_mobile_app/features/home/presentation/widgets/movie_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MovieList extends StatelessWidget {
  const MovieList({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context.read<HomeBloc>().add(FetchMovies()),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(top: 48),
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
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
                    if (state is HomeLoading) {
                      return CircularProgressIndicator();
                    }
                    if (state is HomeError) {
                      return Text('Something went wrong!');
                    }
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
                          return InkWell(
                            onTap: () {
                              context.push(
                                "${RouteConstants.MOVIE_DETAIL}/${state.moviesList[index].id}",
                              );
                            },
                            child: MovieTile(movie: state.moviesList[index]),
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
      ),
    );
  }

  _buildHeader() => SizedBox(
    height: 40,
    child: Text(
      'Home',
      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
    ),
  );
}
