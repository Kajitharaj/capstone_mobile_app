// lib/core/di/service_locator.dart
import 'package:capstone_mobile_app/core/services/secure_storage_service.dart';
import 'package:capstone_mobile_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:capstone_mobile_app/features/auth/data/datasources/auth_service.dart';
import 'package:capstone_mobile_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:capstone_mobile_app/features/auth/domain/usecases/check_auth_status.dart';
import 'package:capstone_mobile_app/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:capstone_mobile_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:capstone_mobile_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:capstone_mobile_app/features/home/data/datasources/movie_service.dart';
import 'package:capstone_mobile_app/features/home/data/repositories/movie_repository_impl.dart';
import 'package:capstone_mobile_app/features/home/domain/repositories/movie_repository.dart';
import 'package:capstone_mobile_app/features/home/domain/usecases/fetch_movies_usecase.dart';
import 'package:capstone_mobile_app/features/home/presentation/bloc/bloc/movie_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/presentation/bloc/auth_bloc.dart';

import '../services/http_api_client.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //

  // Core
  sl.registerLazySingleton(
    () => ApiClient(
      baseUrl: 'http://192.168.8.104:8091/api/v1',
      authLocalDataSource: sl(),
    ),
  );

  //secure storage
  sl.registerLazySingleton(() => AuthLocalDataSource());

  // Data sources
  sl.registerLazySingleton<AuthService>(() => AuthService(apiClient: sl()));
  sl.registerLazySingleton<MovieService>(() => MovieService(apiClient: sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authService: sl(), localDataSource: sl()),
  );
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(movieService: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));
  sl.registerLazySingleton(() => CheckAuthStatusUseCase(sl()));
  sl.registerLazySingleton(() => FetchMoviesUsecase(repository: sl()));

  // Bloc
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      logoutUseCase: sl(),
      getCurrentUserUseCase: sl(),
      checkAuthStatusUseCase: sl(),
    ),
  );
  sl.registerFactory(() => MovieBloc(fetchMoviesUsecase: sl()));
}
