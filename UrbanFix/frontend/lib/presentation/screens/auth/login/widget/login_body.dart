import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/controller/user_controller.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_constants.dart';
import 'login_header.dart';
import 'login_form.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (context, controller, _) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary,
                AppColors.secondary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 40),

                const LoginHeader(),

                const SizedBox(height: 40),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(
                      AppConstants.defaultPadding,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: const LoginForm(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
