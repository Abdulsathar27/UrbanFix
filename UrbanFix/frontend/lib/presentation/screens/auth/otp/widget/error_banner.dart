import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/appsize_constants.dart';

class ErrorBanner extends StatelessWidget {
  final String message;
  const ErrorBanner({required this.message,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: kSpaceMedium,
        vertical: kSpaceSmall,
      ),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.08),
        borderRadius: kBorderRadiusMedium,
        border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline_rounded,
            size: kIconSmall,
            color: AppColors.error,
          ),
          kGapW8,
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: kFontSmall,
                color: AppColors.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}