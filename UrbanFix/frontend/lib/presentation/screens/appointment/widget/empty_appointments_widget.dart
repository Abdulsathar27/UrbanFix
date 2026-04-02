import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/core/constants/appsize_constants.dart';

class EmptyAppointmentsWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const EmptyAppointmentsWidget({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_month_outlined,
            size: 80,
            color: AppColors.greyMedium,
          ),
          kGapH16,
          Text(
            message,
            style: const TextStyle(fontSize: kFontBase, color: AppColors.greyMedium),
          ),
          if (onRetry != null) ...[
            kGapH16,
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded, size: kIconSmall),
              label: const Text(AppStrings.retry),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.lightTextPrimary,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
                shadowColor: AppColors.transparent,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: kFontMedium,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
