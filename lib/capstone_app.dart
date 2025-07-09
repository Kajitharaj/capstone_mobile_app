import 'package:capstone_mobile_app/core/di/service_locator.dart';
import 'package:capstone_mobile_app/core/router/app_router.dart';
import 'package:capstone_mobile_app/core/theme/app_theme.dart';
import 'package:capstone_mobile_app/core/util/navigator_helper.dart';
import 'package:capstone_mobile_app/features/auth/domain/usecases/check_auth_status.dart';
import 'package:capstone_mobile_app/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:capstone_mobile_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:capstone_mobile_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:capstone_mobile_app/features/auth/presentation/bloc/auth_bloc.dart';
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
      builder: (context, child) {
        NavigatorHelper().setParentContext(context);
        return BlocProvider(
          create: (context) => sl<AuthBloc>(),
          child: Material(
            child: ProgressHUD(child: Container(child: child)),
          ),
        );
      },
    );
  }
}
