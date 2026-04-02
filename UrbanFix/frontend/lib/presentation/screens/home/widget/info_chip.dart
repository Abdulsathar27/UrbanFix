import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/appsize_constants.dart';

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
        kGapW4,
        Text(
          label,
          style: TextStyle(
            fontSize: kFontSmall,
            fontWeight: FontWeight.w500,
            color:
                isDark ? AppColors.darkTextSecondary : AppColors.greyDark,
          ),
        ),
      ],
    );
  }
}
