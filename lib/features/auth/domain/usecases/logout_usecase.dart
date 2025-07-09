import 'package:capstone_mobile_app/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  AuthRepository repository;

  LogoutUseCase(this.repository);

  Future<void> call() async {
    // return repository.lo;
  }
}
