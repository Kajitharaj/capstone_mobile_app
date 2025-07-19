import 'package:capstone_mobile_app/core/shared/enum/snackbar_enum.dart';
import 'package:capstone_mobile_app/core/util/navigator_helper.dart';
import 'package:capstone_mobile_app/features/home/presentation/bloc/movie_bloc/movie_details_bloc.dart';
import 'package:capstone_mobile_app/features/home/presentation/widgets/movie_backdrop_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailsPage extends StatelessWidget {
  final String movieId;

  const MovieDetailsPage({required this.movieId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MovieDetailsBloc, MovieDetailsState>(
        builder: (context, state) {
          if (state is MovieDetailsInitial) {
            context.read<MovieDetailsBloc>().add(
              LoadMovieDetail(movieId: int.tryParse(movieId)),
            );
          }
          if (state is MovieDetailsLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is MovieDetailsLoaded) {
            return MovieBackdrop(
              movie: state.movieDetail,
              bgColor: state.dominantColor!,
            );
          }
          if (state is MovieDetailsError) {
            return Text('Something went wrong!');
          }
          return SizedBox.shrink();
        },
        listener: (context, state) {
          if (state is MovieDetailsError) {
            NavigatorHelper().showSnackBar(
              message: state.failure.message ?? '',
              type: SnackBarType.error,
            );
          }
        },
      ),
    );
  }
}
