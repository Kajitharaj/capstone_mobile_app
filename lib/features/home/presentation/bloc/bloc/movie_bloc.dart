import 'package:capstone_mobile_app/core/shared/error/failure.dart';
import 'package:capstone_mobile_app/features/home/domain/model/movie_model.dart';
import 'package:capstone_mobile_app/features/home/domain/usecases/fetch_movies_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final FetchMoviesUsecase fetchMoviesUsecase;
  MovieBloc({required this.fetchMoviesUsecase}) : super(MovieInitial()) {
    on<FetchMovies>(_onFetchMovies);
  }

  _onFetchMovies(event, emit) async {
    try {
      final result = await fetchMoviesUsecase.call();
      result.fold(
        (l) => emit(MovieError(l)),
        (r) => emit(MovieLoaded(moviesList: r)),
      );
    } catch (e) {
      emit(MovieError(Failure(exception: e)));
    }
  }
}
