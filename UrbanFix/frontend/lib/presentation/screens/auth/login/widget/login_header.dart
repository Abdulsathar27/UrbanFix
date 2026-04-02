import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:frontend/presentation/screens/auth/login/widget/logo_badge.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        LogoBadge(),
        kGapH20,
        Text(
          AppStrings.appName,
          style: TextStyle(
            fontSize: kFontHero,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
            letterSpacing: 1.2,
          ),
        ),
        kGapH8,
        Text(
          AppStrings.splashTagline,
          style: TextStyle(color: AppColors.white70, fontSize: kFontMedium),
        ),
      ],
    );
  }
}
