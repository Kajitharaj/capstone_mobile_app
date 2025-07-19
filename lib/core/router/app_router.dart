import 'package:capstone_mobile_app/core/constants/route_constants.dart';
import 'package:capstone_mobile_app/core/di/service_locator.dart';
import 'package:capstone_mobile_app/features/auth/presentation/pages/login_view.dart';
import 'package:capstone_mobile_app/features/auth/presentation/pages/registration_view.dart';
import 'package:capstone_mobile_app/features/auth/presentation/pages/splash_view.dart';
import 'package:capstone_mobile_app/features/home/presentation/bloc/fav_bloc/fav_bloc.dart';
import 'package:capstone_mobile_app/features/home/presentation/pages/movie_details.dart';
import 'package:capstone_mobile_app/features/home/presentation/pages/wish_list.dart';
import 'package:capstone_mobile_app/features/home/presentation/pages/home_view.dart';
import 'package:capstone_mobile_app/features/home/presentation/pages/movie_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/bloc/movie_bloc/movie_details_bloc.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: RouteConstants.SPLASH,
      builder: (context, state) => SplashView(),
    ),
    GoRoute(
      path: RouteConstants.LOGIN,
      builder: (context, state) => LoginView(),
    ),
    GoRoute(
      path: RouteConstants.REGISTER,
      builder: (context, state) => const RegistrationView(),
    ),
    GoRoute(
      path: "${RouteConstants.MOVIE_DETAIL}/:id",
      builder: (context, state) {
        final movieId = state.pathParameters['id']!;
        return BlocProvider<MovieDetailsBloc>(
          create: (_) =>
              sl<MovieDetailsBloc>()
                ..add(LoadMovieDetail(movieId: int.tryParse(movieId))),
          child: MovieDetailsPage(movieId: movieId),
        );
      },
    ),
    ShellRoute(
      builder: (context, state, child) {
        return HomeView(child: child);
      },
      routes: [
        GoRoute(
          path: RouteConstants.HOME,
          builder: (context, state) => const MovieList(),
        ),
        GoRoute(
          path: RouteConstants.WISHLIST,
          builder: (context, state) {
            return BlocProvider.value(
              value: sl<FavBloc>()..add(LoadFavList()),
              child: WishList(),
            );
          },
        ),
      ],
    ),
  ],
);
