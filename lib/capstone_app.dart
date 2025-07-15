import 'package:capstone_mobile_app/core/di/service_locator.dart';
import 'package:capstone_mobile_app/core/router/app_router.dart';
import 'package:capstone_mobile_app/core/theme/app_theme.dart';
import 'package:capstone_mobile_app/core/util/navigator_helper.dart';
import 'package:capstone_mobile_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:capstone_mobile_app/features/home/presentation/bloc/fav_bloc/fav_bloc.dart';
import 'package:capstone_mobile_app/features/home/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class CapstoneApp extends StatelessWidget {
  const CapstoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Capstone Movie App',
      routerConfig: appRouter,
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        NavigatorHelper().setParentContext(context);
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>()),
            BlocProvider<HomeBloc>(create: (_) => sl<HomeBloc>()),
            BlocProvider<FavBloc>(create: (_) => sl<FavBloc>()),
          ],
          child: Material(
            child: ProgressHUD(child: Container(child: child)),
          ),
        );
      },
    );
  }
}
