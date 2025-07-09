import 'package:capstone_mobile_app/core/constants/app_assets.dart';
import 'package:capstone_mobile_app/core/constants/route_constants.dart';
import 'package:capstone_mobile_app/core/widgets/page_container.dart';
import 'package:capstone_mobile_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          GoRouter.of(context).push(RouteConstants.HOME);
        } else if (state is! AuthInitial) {
          GoRouter.of(context).push(RouteConstants.LOGIN);
        }
      },
      builder: (context, state) {
        if (state is AuthInitial) {
          context.read<AuthBloc>().add(CheckAuthStatus());
        }
        return PageContainer(
          child: Center(child: Image.asset(AppImages.APP_LOGO)),
        );
      },
    );
  }
}
