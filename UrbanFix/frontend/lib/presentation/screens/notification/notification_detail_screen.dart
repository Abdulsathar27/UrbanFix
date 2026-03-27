import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/data/models/notification_model.dart';
import 'package:intl/intl.dart';

class NotificationDetailScreen extends StatelessWidget {
  final NotificationModel notification;

  const NotificationDetailScreen({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.lightTextPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Notification',
          style: TextStyle(
            color: AppColors.lightTextPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Icon + Read Badge =====
            Center(
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(
                  _getIcon(),
                  color: AppColors.primary,
                  size: 40,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ===== Title =====
            Text(
              notification.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.lightTextPrimary,
              ),
            ),

            const SizedBox(height: 8),

            // ===== Date =====
            if (notification.createdAt != null)
              Text(
                DateFormat('MMM dd, yyyy  •  hh:mm a')
                    .format(notification.createdAt!),
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.greyMedium,
                ),
              ),

            const SizedBox(height: 24),

            // ===== Divider =====
            const Divider(color: AppColors.greyLight),

            const SizedBox(height: 24),

            // ===== Message =====
            const Text(
              'Message',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.greyMedium,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.greyLight),
              ),
              child: Text(
                notification.body,
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.lightTextSecondary,
                  height: 1.6,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ===== Type Badge =====
            Row(
              children: [
                const Text(
                  'Type',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.greyMedium,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    notification.type.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ===== Status =====
            Row(
              children: [
                const Text(
                  'Status',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.greyMedium,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: notification.isRead
                        ? AppColors.greyLight
                        : AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    notification.isRead ? 'Read' : 'Unread',
                    style: TextStyle(
                      fontSize: 12,
                      color: notification.isRead
                          ? AppColors.greyDark
                          : AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon() {
    final title = notification.title.toLowerCase();
    final type = notification.type.toLowerCase();

    if (title.contains('payment') || type.contains('payment')) {
      return Icons.check_circle;
    } else if (title.contains('service') || type.contains('service')) {
      return Icons.build;
    } else if (title.contains('profile') || type.contains('profile')) {
      return Icons.person;
    } else if (title.contains('offer') || type.contains('offer')) {
      return Icons.local_offer;
    } else if (title.contains('appointment') || type.contains('appointment')) {
      return Icons.calendar_today;
    } else if (title.contains('chat') || type.contains('chat')) {
      return Icons.chat_bubble;
    } else if (title.contains('report') || type.contains('report')) {
      return Icons.report_problem;
    } else {
      return Icons.notifications;
    }
  }
}
