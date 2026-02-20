import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../data/controller/notification_controller.dart';
import '../../../../data/models/notification_model.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;

  const NotificationTile({
    super.key,
    required this.notification, required this.onTap,
  });

 

  @override
  Widget build(BuildContext context) {
    final controller =
        context.read<NotificationController>();

    return InkWell(
      onTap: () {

        /// ✅ Mark as read
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
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          /// ================= ICON
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius:
                  BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.notifications,
              color: Colors.blue,
            ),
          ),

          const SizedBox(width: 16),

          /// ================= TEXT CONTENT
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  notification.body,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          /// ================= UNREAD DOT
          if (!notification.isRead)
            Container(
              margin:
                  const EdgeInsets.only(top: 8),
              height: 10,
              width: 10,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}