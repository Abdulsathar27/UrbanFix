import 'package:flutter/material.dart';
import 'package:frontend/data/controller/notification_controller.dart';
import 'package:frontend/presentation/screens/notification/widgets/notificationtile.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_strings.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// 👇 Fetch after first frame (safe)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = context.read<NotificationController>();

      if (controller.notifications.isEmpty && !controller.isLoading) {
        controller.fetchNotifications();
      }
    });

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Consumer<NotificationController>(
          builder: (context, controller, _) {
            if (controller.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.notifications.isEmpty) {
              return const Center(child: Text(AppStrings.noNotifications));
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ================= HEADER
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          context.pop(); // go back
                        },
                      ),

                      const Text(
                        "Notifications",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      if (controller.notifications
                          .where((n) => !n.isRead)
                          .isNotEmpty)
                        TextButton(
                          onPressed: controller.markAllAsRead,
                          child: const Text(
                            "Mark all as read",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// ================= LIST
                  Expanded(
                    child: ListView.separated(
                      itemCount: controller.notifications.length,
                      separatorBuilder: (_, __) =>
                          Divider(height: 30, color: Colors.grey.shade300),
                      itemBuilder: (context, index) {
                        final notification = controller.notifications[index];

                        return NotificationTile(
                          notification: notification,
                          onTap: () {
                            if (!notification.isRead) {
                              controller.markAsRead(notification.id);
                            }

                            if (notification.referenceId != null) {
                              context.pushNamed(
                                'job_details',
                                pathParameters: {
                                  'id': notification.referenceId.toString(),
                                },
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
