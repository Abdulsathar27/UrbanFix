import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:frontend/data/controller/notification_controller.dart';
import 'package:frontend/data/models/notification_model.dart';
import 'package:frontend/core/utils/config.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<NotificationController>();
    final typeConfig = NotificationConfig.getTypeConfig(notification);

    return InkWell(
      borderRadius: kBorderRadiusMedium,
      onTap: () {
        if (!notification.isRead) controller.markAsRead(notification.id);
        context.pushNamed('notificationDetail', extra: notification);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// ===== TYPE ICON
            Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: typeConfig.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(typeConfig.icon, color: typeConfig.color, size: 24),
            ),

            const SizedBox(width: 14),

            /// ===== TEXT + TIMESTAMP
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: notification.isRead
                                ? FontWeight.w500
                                : FontWeight.w700,
                          ),
                        ),
                      ),

                      /// ===== UNREAD DOT
                      if (!notification.isRead)
                        Container(
                          margin: const EdgeInsets.only(left: 8, top: 5),
                          height: 8,
                          width: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),

                  kGapH4,

                  Text(
                    notification.body,
                    style: const TextStyle(
                        fontSize: 13, color: AppColors.greyDark),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  if (notification.createdAt != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      _formatTime(notification.createdAt!),
                      style: const TextStyle(
                          fontSize: 11, color: AppColors.greyMedium),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return DateFormat('MMM dd').format(dt);
  }
}
