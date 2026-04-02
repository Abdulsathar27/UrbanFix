import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/appsize_constants.dart';

class IconBox extends StatelessWidget {
  final IconData icon;
  const IconBox({required this.icon,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kPaddingAllSmall,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: AppColors.primary, size: 20),
    );
  }
}
