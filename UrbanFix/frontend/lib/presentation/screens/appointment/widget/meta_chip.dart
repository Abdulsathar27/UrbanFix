import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/appsize_constants.dart';

class MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const MetaChip({required this.icon, required this.label,super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: kIconXSmall + 2, color: AppColors.greyMedium),
        kGapW4,
        Text(
          label,
          style: const TextStyle(
            fontSize: kFontSmall,
            color: AppColors.greyDark,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}