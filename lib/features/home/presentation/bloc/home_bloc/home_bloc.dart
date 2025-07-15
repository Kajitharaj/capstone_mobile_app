import 'package:capstone_mobile_app/core/shared/error/failure.dart';
import 'package:capstone_mobile_app/features/home/domain/model/movie_model.dart';
import 'package:capstone_mobile_app/features/home/domain/usecases/fetch_movies_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FetchMoviesUsecase fetchMoviesUsecase;
  HomeBloc({required this.fetchMoviesUsecase}) : super(HomeInitial()) {
    on<FetchMovies>(_onFetchMovies);
  }

  _onFetchMovies(event, emit) async {
    try {
      emit(HomeLoading());
      final result = await fetchMoviesUsecase.call();
      result.fold(
        (l) => emit(HomeError(l)),
        (r) => emit(HomeLoaded(moviesList: r)),
      );
    } catch (e) {
      emit(HomeError(Failure(exception: e)));
    }
  }
}
