import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/core/constants/appsize_constants.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Icon(Icons.build, size: 60, color: AppColors.white),
        kGapH16,
        Text(
          AppStrings.joinUrbanFix,
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.white),
        ),
        SizedBox(height: 6),
        Text(
          AppStrings.registerTagline,
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.white70),
        ),
      ],
    );
  }
}
