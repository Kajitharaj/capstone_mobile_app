// lib/core/di/service_locator.dart
import 'package:capstone_mobile_app/core/services/secure_storage_service.dart';
import 'package:capstone_mobile_app/features/auth/data/auth_repository_impl.dart';
import 'package:capstone_mobile_app/features/auth/data/data_sources/auth_service.dart';
import 'package:capstone_mobile_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:capstone_mobile_app/features/auth/domain/usecases/check_auth_status.dart';
import 'package:capstone_mobile_app/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:capstone_mobile_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:capstone_mobile_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/presentation/bloc/auth_bloc.dart';

import '../services/http_api_client.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //

  // Core
  sl.registerLazySingleton(
    () => ApiClient(
      baseUrl: 'http://192.168.8.106:8091/api/v1',
      authLocalDataSource: sl(),
    ),
  );

  //secure storage
  sl.registerLazySingleton(() => AuthLocalDataSource());

  // Data sources
  sl.registerLazySingleton<AuthService>(() => AuthService(apiClient: sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authService: sl(), localDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));
  sl.registerLazySingleton(() => CheckAuthStatusUseCase(sl()));

  // Bloc
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      logoutUseCase: sl(),
      getCurrentUserUseCase: sl(),
      checkAuthStatusUseCase: sl(),
    ),
  );
}
