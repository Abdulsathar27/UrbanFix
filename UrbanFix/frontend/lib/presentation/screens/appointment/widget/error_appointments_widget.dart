import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/core/constants/appsize_constants.dart';

class ErrorAppointmentsWidget extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const ErrorAppointmentsWidget({
    super.key,
    required this.error,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: kPaddingAllMedium,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 60, color: AppColors.error),
            kGapH16,
            Text(
              AppStrings.somethingWentWrong,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            kGapH8,
            Text(
              error,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.greyMedium),
            ),
            kGapH24,
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text(AppStrings.retry),
            ),
          ],
        ),
      ),
    );
  }
}
