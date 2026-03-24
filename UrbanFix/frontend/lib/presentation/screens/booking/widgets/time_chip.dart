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
    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: disabled
              ? AppColors.greyBackground
              : selected
                  ? AppColors.primary
                  : AppColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: selected && !disabled
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
          border: disabled || selected
              ? null
              : Border.all(color: AppColors.greyLight),
        ),
        child: Text(
          time,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: disabled
                ? AppColors.greyMedium
                : selected
                    ? AppColors.white
                    : AppColors.lightTextPrimary,
          ),
        ),
      ),
    );
  }
}
