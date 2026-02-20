import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:go_router/go_router.dart';


class RegisterRedirectText extends StatelessWidget {
  const RegisterRedirectText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(AppStrings.dontHaveAccount),
        GestureDetector(
          onTap: () {
            context.goNamed('register');
          },
          child: const Text(
            AppStrings.register,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
