import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';

class TimeChip extends StatelessWidget {
  const TimeChip(
    this.time, {
    required this.onTap,
    this.selected = false,
    this.disabled = false,
    super.key,
  });
  final String time;
  final bool selected;
  final bool disabled;
  final VoidCallback onTap;

 

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: disabled ? null : onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryLight : AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.greyLight,
          ),
        ),
        child: Text(
          time,
          style: TextStyle(
            color: disabled
                ? AppColors.greyMedium
                : selected
                    ? AppColors.primary
                    : AppColors.lightTextPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}