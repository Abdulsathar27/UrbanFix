import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
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

        /// ✅ Navigate if reference exists
        if (notification.referenceId != null) {
          context.pushNamed(
            'job_details',
            pathParameters: {
              'id': notification.referenceId.toString(),
            },
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 16),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            /// ================= ICON CONTAINER
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: _getBackgroundColor(),
                borderRadius:
                    BorderRadius.circular(16),
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
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    notification.body,
                    style: TextStyle(
                      fontSize: 14,
                      color:
                          Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            /// ================= UNREAD DOT
            if (!notification.isRead)
              Container(
                margin:
                    const EdgeInsets.only(
                        top: 6),
                height: 10,
                width: 10,
                decoration:
                    const BoxDecoration(
                  color: Colors.blue,
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
    return Colors.grey.shade200;
  }

  Color _getIconColor() {
    return Colors.blue;
  }
}