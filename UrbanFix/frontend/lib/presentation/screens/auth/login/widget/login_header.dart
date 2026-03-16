import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Icon(
          Icons.build,
          size: 70,
          color: AppColors.white,
        ),
        SizedBox(height: 20),
        Text(
          AppStrings.appName,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          AppStrings.splashTagline,
          style: TextStyle(
            color: AppColors.white70,
          ),
        ),
      ],
    );
  }
}
