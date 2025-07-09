import 'package:capstone_mobile_app/core/services/secure_storage_service.dart';
import 'package:capstone_mobile_app/core/shared/error/failure.dart';
import 'package:capstone_mobile_app/features/auth/data/data_sources/auth_service.dart';
import 'package:capstone_mobile_app/features/auth/domain/model/user_model.dart';
import 'package:capstone_mobile_app/features/auth/domain/model/user_response_model.dart';
import 'package:capstone_mobile_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthService authService;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.authService,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, bool>> login(String email, String password) async {
    try {
      final json = await authService.login(email, password);
      final user = UserResponseModel.fromJson(json.data);
      if (user.email.isNotEmpty) {
        localDataSource.saveToken(user.token);
        return Right(true);
      } else {
        return Left(
          Failure(message: 'Login Failed!, Check your email or password'),
        );
      }
    } catch (e) {
      return Left(Failure(exception: e, message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel?>> getCurrentUser() async {
    try {
      final json = await authService.getCurrentUser();
      return Right(UserModel.fromJson(json.data));
    } catch (e) {
      return Left(Failure(exception: e));
    }
  }

  @override
  Future<Either<Failure, bool>> checkAuthStatus() async {
    try {
      final json = await authService.getCurrentUser();
      final user = UserModel.fromJson(json.data);
      if (user.email.isNotEmpty) {
        return Right(true);
      } else {
        return Left(Failure(message: 'Login Failed!, Token expired'));
      }
    } catch (e) {
      return Left(Failure(exception: e));
    }
  }
}
