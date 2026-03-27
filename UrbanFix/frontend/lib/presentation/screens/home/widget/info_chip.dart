import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';

class InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDark;

  const InfoChip({
    required this.icon,
    required this.label,
    required this.isDark,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon,
            size: 13,
            color:
                isDark ? AppColors.darkTextSecondary : AppColors.greyDark),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color:
                isDark ? AppColors.darkTextSecondary : AppColors.greyDark,
          ),
        ),
      ],
    );
  }
}
