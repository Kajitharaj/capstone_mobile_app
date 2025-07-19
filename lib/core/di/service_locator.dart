// lib/core/di/service_locator.dart
import 'package:capstone_mobile_app/core/services/secure_storage_service.dart';
import 'package:capstone_mobile_app/core/util/env_util.dart';
import 'package:capstone_mobile_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:capstone_mobile_app/features/auth/data/datasources/auth_service.dart';
import 'package:capstone_mobile_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:capstone_mobile_app/features/auth/domain/usecases/check_auth_status.dart';
import 'package:capstone_mobile_app/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:capstone_mobile_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:capstone_mobile_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:capstone_mobile_app/features/home/data/datasources/movie_service.dart';
import 'package:capstone_mobile_app/features/home/data/datasources/wishlist_service.dart';
import 'package:capstone_mobile_app/features/home/data/repositories/movie_repository_impl.dart';
import 'package:capstone_mobile_app/features/home/data/repositories/wishlist_repository_impl.dart';
import 'package:capstone_mobile_app/features/home/domain/repositories/movie_repository.dart';
import 'package:capstone_mobile_app/features/home/domain/repositories/wishlist_repository.dart';
import 'package:capstone_mobile_app/features/home/domain/usecases/add_to_wish_list_usecase.dart';
import 'package:capstone_mobile_app/features/home/domain/usecases/delete_wish_list_usecase.dart';
import 'package:capstone_mobile_app/features/home/domain/usecases/fetch_movies_usecase.dart';
import 'package:capstone_mobile_app/features/home/domain/usecases/get_movie_detail_usecase.dart';
import 'package:capstone_mobile_app/features/home/domain/usecases/get_wish_list_usecase.dart';
import 'package:capstone_mobile_app/features/home/presentation/bloc/fav_bloc/fav_bloc.dart';
import 'package:capstone_mobile_app/features/home/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:capstone_mobile_app/features/home/presentation/bloc/movie_bloc/movie_details_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/presentation/bloc/auth_bloc.dart';

import '../services/http_api_client.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //

  // Core
  sl.registerLazySingleton(
    () => ApiClient(baseUrl: EnvUtil.env!.apiUrl, authLocalDataSource: sl()),
  );

  //secure storage
  sl.registerLazySingleton(() => AuthLocalDataSource());

  // Data sources
  sl.registerLazySingleton<AuthService>(() => AuthService(apiClient: sl()));
  sl.registerLazySingleton<MovieService>(() => MovieService(apiClient: sl()));
  sl.registerLazySingleton<WishListService>(
    () => WishListService(apiClient: sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authService: sl(), localDataSource: sl()),
  );
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(movieService: sl()),
  );
  sl.registerLazySingleton<WishlistRepository>(
    () => WishlistRepositoryImpl(wishListService: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));
  sl.registerLazySingleton(() => CheckAuthStatusUseCase(sl()));
  sl.registerLazySingleton(() => FetchMoviesUsecase(sl()));
  sl.registerLazySingleton(() => AddToWishListUsecase(sl()));
  sl.registerLazySingleton(() => GetWishListUsecase(sl()));
  sl.registerLazySingleton(() => DeleteWishListUsecase(sl()));
  sl.registerLazySingleton(() => GetMovieDetailUsecase(sl()));

  // Bloc
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      logoutUseCase: sl(),
      getCurrentUserUseCase: sl(),
      checkAuthStatusUseCase: sl(),
    ),
  );
  sl.registerFactory(() => HomeBloc(fetchMoviesUsecase: sl()));
  sl.registerFactory(
    () => FavBloc(
      deleteWishListUsecase: sl(),
      getWishListUsecase: sl(),
      addToWishListUsecase: sl(),
    ),
  );
  sl.registerFactory(() => MovieDetailsBloc(getMovieDetailUsecase: sl()));
}
