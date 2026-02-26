import 'package:flutter/material.dart';
import 'package:frontend/data/controller/notification_controller.dart';
import 'package:frontend/presentation/screens/notification/widgets/notification_card.dart';
import 'package:frontend/presentation/screens/notification/widgets/notification_empty_state.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.goNamed('home');
          },
        ),
      ),
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Consumer<NotificationController>(
          builder: (context, controller, _) {

            /// ✅ SAFE FETCH
            if (!controller.hasFetched &&
                !controller.isLoading) {
              controller.fetchNotifications();
            }

            /// ================= LOADING
            if (controller.isLoading) {
              return const Center(
                  child: CircularProgressIndicator());
            }

            /// ================= ERROR
            if (controller.errorMessage != null) {
              return Center(
                child: Text(
                  controller.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            /// ================= EMPTY STATE
            if (controller.notifications.isEmpty) {
              return const NotificationEmptyState();
            }

            /// ================= MAIN UI
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  /// HEADER
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Notifications",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      if (controller.unreadCount > 0)
                        TextButton(
                          onPressed:
                              controller.markAllAsRead,
                          child: const Text(
                            "Mark all as read",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight:
                                  FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// LIST
                  Expanded(
                    child: ListView.separated(
                      itemCount:
                          controller.notifications.length,
                      separatorBuilder: (_, __) =>
                          Divider(
                              height: 30,
                              color:
                                  Colors.grey.shade300),
                      itemBuilder: (context, index) {
                        final notification =
                            controller
                                .notifications[index];

                        return NotificationCard(
                            notification:
                                notification);
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