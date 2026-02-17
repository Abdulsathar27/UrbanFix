import 'package:flutter/material.dart';
import 'package:frontend/controller/notification_controller.dart';
import 'package:frontend/routes/app_routes.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_strings.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() =>
      _NotificationScreenState();
}

class _NotificationScreenState
    extends State<NotificationScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<NotificationController>()
          .fetchNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text(AppStrings.notifications),
        actions: [
          Consumer<NotificationController>(
            builder: (context, controller, _) {
              if (controller.notifications
                  .where((n) => !n.isRead)
                  .isEmpty) {
                return const SizedBox();
              }

              return TextButton(
                onPressed: () {
                  controller.markAllAsRead();
                },
                child: const Text(
                  "Mark all read",
                  style: TextStyle(
                      color: Colors.white),
                ),
              );
            },
          )
        ],
      ),
      body: Consumer<NotificationController>(
        builder: (context, controller, _) {
          if (controller.isLoading) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          if (controller.notifications
              .isEmpty) {
            return const Center(
              child: Text(
                  AppStrings.noNotifications),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(
                AppConstants.defaultPadding),
            child: ListView.builder(
              itemCount:
                  controller.notifications
                      .length,
              itemBuilder: (context, index) {
                final notification =
                    controller
                        .notifications[index];

                return Card(
                  color: notification.isRead
                      ? null
                      : Colors.blue
                          .withOpacity(0.1),
                  child: ListTile(
                    title:
                        Text(notification.title),
                    subtitle:
                        Text(notification.body),
                    trailing: Row(
                      mainAxisSize:
                          MainAxisSize.min,
                      children: [
                        if (!notification
                            .isRead)
                          IconButton(
                            icon: const Icon(
                                Icons
                                    .mark_email_read),
                            onPressed: () {
                              controller
                                  .markAsRead(
                                      notification
                                          .id);
                            },
                          ),
                        IconButton(
                          icon: const Icon(
                              Icons.delete),
                          onPressed: () {
                            controller
                                .deleteNotification(
                                    notification
                                        .id);
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      if (!notification
                          .isRead) {
                        controller.markAsRead(
                            notification.id);
                      }

                      if (notification
                              .referenceId !=
                          null) {
                        Navigator.pushNamed(
                          context,
                          AppRoutes
                              .jobDetails,
                          arguments:
                              notification
                                  .referenceId,
                        );
                      }
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
