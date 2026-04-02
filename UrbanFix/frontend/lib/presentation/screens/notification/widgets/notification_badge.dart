import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:frontend/data/controller/notification_controller.dart';

class NotificationBadge extends StatelessWidget {
  const NotificationBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<NotificationController, int>(
      selector: (_, controller) =>
          controller.notifications
              .where((n) => !n.isRead)
              .length,
      builder: (context, unreadCount, _) {

        if (unreadCount <= 0) {
          return const SizedBox();
        }

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 3,
          ),
          decoration: BoxDecoration(
            color: AppColors.error,
            borderRadius: kBorderRadiusMedium,
          ),
          constraints: const BoxConstraints(
            minWidth: 20,
            minHeight: 20,
          ),
          child: Center(
            child: Text(
              unreadCount > 99
                  ? AppStrings.maxNotificationCount
                  : unreadCount.toString(),
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
