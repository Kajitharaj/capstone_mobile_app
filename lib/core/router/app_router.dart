import 'package:capstone_mobile_app/core/constants/route_constants.dart';
import 'package:capstone_mobile_app/features/auth/presentation/pages/login_view.dart';
import 'package:capstone_mobile_app/features/auth/presentation/pages/registration_view.dart';
import 'package:capstone_mobile_app/features/auth/presentation/pages/splash_view.dart';
import 'package:capstone_mobile_app/features/home/presentation/home_view.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: RouteConstants.SPLASH,
      name: 'splash',
      builder: (context, state) => SplashView(),
    ),
    GoRoute(
      path: RouteConstants.LOGIN,
      name: 'login',
      builder: (context, state) => LoginView(),
    ),
    GoRoute(
      path: RouteConstants.REGISTER,
      name: 'register',
      builder: (context, state) => const RegistrationView(),
    ),
    GoRoute(
      path: RouteConstants.HOME,
      name: 'home',
      builder: (context, state) => const HomeView(),
    ),
  ],
);
