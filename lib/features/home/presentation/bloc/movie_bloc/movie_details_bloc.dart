import 'dart:async';
import 'dart:ui';

import 'package:capstone_mobile_app/core/shared/error/failure.dart';
import 'package:capstone_mobile_app/core/util/color_util.dart';
import 'package:capstone_mobile_app/features/home/domain/model/movie_details_model.dart';
import 'package:capstone_mobile_app/features/home/domain/usecases/get_movie_detail_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieDetailUsecase getMovieDetailUsecase;

  MovieDetailsBloc({
    required this.getMovieDetailUsecase,
  }) : super(MovieDetailsInitial()) {
    on<LoadMovieDetail>(_onLoadMovieDetail);
  }

  FutureOr<void> _onLoadMovieDetail(
    LoadMovieDetail event,
    Emitter<MovieDetailsState> emit,
  ) async {
    try {
      emit(MovieDetailsLoading());
      final result = await getMovieDetailUsecase.call(event.movieId);
      MovieDetailsModel? movie;

      result.fold((l) => emit(MovieDetailsError(l)), (r) {
        movie = r;
      });
      if (movie == null) throw Exception('Something went wroing!');
      final dominantColor = await ColorUtil.getDominantColor(
        imageUrl(movie!.backdropPath),
      );
      emit(
        MovieDetailsLoaded(movieDetail: movie!, dominantColor: dominantColor),
      );
    } catch (e) {
      emit(MovieDetailsError(Failure(exception: e)));
    }
  }

  imageUrl(imagePath) => "https://image.tmdb.org/t/p/w500/$imagePath";


}
