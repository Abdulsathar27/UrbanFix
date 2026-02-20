import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
            color: Colors.red,
            borderRadius: BorderRadius.circular(12),
          ),
          constraints: const BoxConstraints(
            minWidth: 20,
            minHeight: 20,
          ),
          child: Center(
            child: Text(
              unreadCount > 99
                  ? "99+"
                  : unreadCount.toString(),
              style: const TextStyle(
                color: Colors.white,
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