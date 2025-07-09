import 'package:capstone_mobile_app/core/shared/error/failure.dart';
import 'package:capstone_mobile_app/features/auth/domain/usecases/check_auth_status.dart';
import 'package:capstone_mobile_app/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:capstone_mobile_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:capstone_mobile_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final CheckAuthStatusUseCase checkAuthStatusUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.getCurrentUserUseCase,
    required this.checkAuthStatusUseCase,
  }) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<RegisteringUser>(_onRegisteringUser);
    on<CheckAuthStatus>(_onCheckAuthStatus);
  }

  _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await loginUseCase.call(event.email, event.password);
      result.fold(
        (l) => emit(AuthFailure(l)),
        (r) => emit(AuthAuthenticated()),
      );
    } catch (e) {
      emit(AuthFailure(Failure(message: 'Login Failed')));
    }
  }

  _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async{
    await logoutUseCase.call();
  }

  _onRegisteringUser(RegisteringUser event, Emitter<AuthState> emit) {}
  _onCheckAuthStatus(CheckAuthStatus event, Emitter<AuthState> emit) async {
    try {
      final result = await checkAuthStatusUseCase.call();
      result.fold(
        (l) => emit(AuthFailure(l)),
        (r) => emit(AuthAuthenticated()),
      );
    } catch (e) {
      emit(AuthFailure(Failure(message: 'Login Failed, Token error')));
    }
  }
}
