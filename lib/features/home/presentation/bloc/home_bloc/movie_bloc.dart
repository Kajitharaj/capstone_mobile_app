import 'package:capstone_mobile_app/core/shared/error/failure.dart';
import 'package:capstone_mobile_app/features/home/domain/model/movie_model.dart';
import 'package:capstone_mobile_app/features/home/domain/usecases/add_to_wish_list_usecase.dart';
import 'package:capstone_mobile_app/features/home/domain/usecases/fetch_movies_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FetchMoviesUsecase fetchMoviesUsecase;
  final AddToWishListUsecase addToWishListUsecase;
  HomeBloc({
    required this.fetchMoviesUsecase,
    required this.addToWishListUsecase,
  }) : super(HomeInitial()) {
    on<AddToWishList>(_onAddToWishList);
    on<FetchMovies>(_onFetchMovies);
  }

  _onAddToWishList(AddToWishList event, emit) async {
    try {
      final result = await addToWishListUsecase.call(event.movieModel);
      result.fold(
        (l) => emit(HomeError(l)),
        (r) => emit(MovieAddedToWishList()),
      );
    } catch (e) {
      emit(HomeError(Failure(exception: e)));
    }
  }

  _onFetchMovies(event, emit) async {
    try {
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
