import 'package:capstone_mobile_app/core/constants/app_assets.dart';
import 'package:capstone_mobile_app/core/constants/app_sizes.dart';
import 'package:capstone_mobile_app/core/constants/route_constants.dart';
import 'package:capstone_mobile_app/core/shared/enum/snackbar_enum.dart';
import 'package:capstone_mobile_app/core/util/navigator_helper.dart';
import 'package:capstone_mobile_app/core/widgets/app_button.dart';
import 'package:capstone_mobile_app/core/widgets/app_text_field.dart';
import 'package:capstone_mobile_app/core/widgets/page_container.dart';
import 'package:capstone_mobile_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: Center(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            final progress = ProgressHUD.of(context);

            if (state is AuthLoading) {
              progress?.show();
            } else {
              progress?.dismiss();
            }
            if (state is AuthAuthenticated) {
              GoRouter.of(context).push(RouteConstants.HOME);
            } else if (state is AuthFailure) {
              NavigatorHelper().showSnackBar(
                message: state.failure.message ?? '',
                type: SnackBarType.error,
              );
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: AppSizes.paddingMedium,
              children: [
                Expanded(child: Image.asset(AppImages.APP_LOGO)),
                AppTextField.outlined(
                  controller: emailController,
                  hintText: 'Enter your e-mail',
                  prefixIcon: Icon(Icons.mail),
                  obscureText: false,
                ),
                AppTextField.outlined(
                  controller: passwordController,
                  hintText: 'Enter your password',
                  prefixIcon: Icon(Icons.lock),
                  obscureText: true,
                ),
                AppButton.elevated(
                  onPressed: state is AuthLoading
                      ? null
                      : () => _onLoginPressed(context),
                  text: 'Login',
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _onLoginPressed(BuildContext context) {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      context.read<AuthBloc>().add(
        LoginRequested(email: email, password: password),
      );
    }
  }
}
