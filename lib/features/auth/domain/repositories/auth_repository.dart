import 'package:capstone_mobile_app/core/shared/error/failure.dart';
import 'package:capstone_mobile_app/features/auth/domain/models/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> login(String email, String password);
 Future<Either<Failure, bool>> checkAuthStatus();
  Future<Either<Failure, UserModel?>> getCurrentUser();
}
