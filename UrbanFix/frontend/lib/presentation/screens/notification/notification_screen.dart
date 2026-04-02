import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:frontend/data/controller/notification_controller.dart';
import 'package:frontend/presentation/screens/notification/widgets/notification_card.dart';
import 'package:frontend/presentation/screens/notification/widgets/notification_empty_state.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<NotificationController>(
          builder: (context, controller, _) {

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!controller.hasFetched && !controller.isLoading) {
                controller.fetchNotifications();
              }
            });

            if (controller.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.errorMessage != null) {
              return Center(
                child: Text(
                  controller.errorMessage!,
                  style: const TextStyle(color: AppColors.error),
                ),
              );
            }

            if (controller.notifications.isEmpty) {
              return const NotificationEmptyState();
            }

            return Padding(
              padding: kPaddingHLarge,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kGapH10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        AppStrings.notifications,
                        style: TextStyle(fontSize: kFontDisplay, fontWeight: FontWeight.bold),
                      ),
                      if (controller.unreadCount > 0)
                        TextButton(
                          onPressed: controller.markAllAsRead,
                          child: const Text(
                            AppStrings.markAllAsRead,
                            style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
                          ),
                        ),
                    ],
                  ),
                  kGapH20,
                  Expanded(
                    child: ListView.separated(
                      itemCount: controller.notifications.length,
                      separatorBuilder: (_, __) => const Divider(height: 30, color: AppColors.greyLight),
                      itemBuilder: (context, index) {
                        final notification = controller.notifications[index];
                        return NotificationCard(notification: notification);
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
