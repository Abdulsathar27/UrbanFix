import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/data/controller/notification_controller.dart';
import 'package:frontend/presentation/screens/notification/widgets/notification_card.dart';
import 'package:frontend/presentation/screens/notification/widgets/notification_empty_state.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.notifications),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 1,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios),
        //   onPressed: () => context.goNamed('home'),
        // ),
      ),
      backgroundColor: AppColors.lightBackground,
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        AppStrings.notifications,
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
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
                  const SizedBox(height: 20),
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
