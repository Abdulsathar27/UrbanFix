import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';

class NotificationEmptyState extends StatelessWidget {
  const NotificationEmptyState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            /// ================= ICON CONTAINER
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_none_rounded,
                size: 50,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: 24),

            /// ================= TITLE
            const Text(
              AppStrings.noNotificationsYet,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            /// ================= SUBTITLE
            const Text(
              AppStrings.notificationsAllCaughtUp,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: AppColors.greyDark,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
