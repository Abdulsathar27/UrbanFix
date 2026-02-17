import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/routes/app_routes.dart';


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
            Navigator.pushNamed(
                context, AppRoutes.register);
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
