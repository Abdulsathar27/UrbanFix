import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/data/models/notification_model.dart';
import 'package:frontend/data/controller/notification_controller.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCard({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    final controller =
        context.read<NotificationController>();

    return InkWell(
      onTap: () {

        /// ✅ Mark as read automatically
        if (!notification.isRead) {
          controller.markAsRead(notification.id);
        }

        /// ✅ Navigate based on notification type
        _navigateForNotification(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// ================= ICON CONTAINER
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: _getBackgroundColor(),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                _getIcon(),
                color: _getIconColor(),
              ),
            ),

            const SizedBox(width: 16),

            /// ================= TEXT SECTION
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    notification.body,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.greyDark,
                    ),
                  ),
                ],
              ),
            ),

            /// ================= UNREAD DOT
            if (!notification.isRead)
              Container(
                margin: const EdgeInsets.only(top: 6),
                height: 10,
                width: 10,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// ===== Icon Logic (Optional Advanced UI)
  IconData _getIcon() {
    final title = notification.title.toLowerCase();

    if (title.contains("payment")) {
      return Icons.check_circle;
    } else if (title.contains("service")) {
      return Icons.build;
    } else if (title.contains("profile")) {
      return Icons.person;
    } else if (title.contains("offer")) {
      return Icons.local_offer;
    } else {
      return Icons.notifications;
    }
  }

  Color _getBackgroundColor() {
    return AppColors.greyLight;
  }

  Color _getIconColor() {
    return AppColors.primary;
  }

  void _navigateForNotification(BuildContext context) {
    context.pushNamed('notificationDetail', extra: notification);
  }
}
