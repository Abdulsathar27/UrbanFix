import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';

class IconBox extends StatelessWidget {
  final IconData icon;
  const IconBox({required this.icon,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: AppColors.primary, size: 20),
    );
  }
}
