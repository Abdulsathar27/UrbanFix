import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/appsize_constants.dart';

class EmptyState extends StatelessWidget {
  final bool isDark;
  const EmptyState({required this.isDark,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkSurface
            : AppColors.greyBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.07)
              : AppColors.greyLight,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.calendar_month_outlined,
              color: AppColors.primary,
              size: kIconMedium,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'No bookings yet',
                  style: TextStyle(
                    fontSize: kFontMedium,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.lightTextPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Your recent booking will appear here',
                  style: TextStyle(
                    fontSize: kFontSmall,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.greyMedium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
