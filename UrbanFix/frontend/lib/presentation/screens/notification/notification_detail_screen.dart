import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:frontend/data/controller/notification_controller.dart';
import 'package:frontend/data/models/notification_model.dart';
import 'package:frontend/core/utils/config.dart';
import 'package:frontend/presentation/screens/notification/widgets/confirm_delete.dart';
import 'package:frontend/presentation/screens/notification/widgets/meta_chip.dart';
import 'package:frontend/presentation/screens/notification/widgets/status_banner.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NotificationDetailScreen extends StatelessWidget {
  final NotificationModel notification;

  const NotificationDetailScreen({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final notifController = context.watch<NotificationController>();

    // Get live notification state (reflects markAsRead / delete updates)
    final live = notifController.notifications.firstWhere(
      (n) => n.id == notification.id,
      orElse: () => notification,
    );


    final theme = Theme.of(context);
    final bgColor = theme.scaffoldBackgroundColor;
    final surfaceColor = theme.colorScheme.surface;
    final textPrimary = theme.colorScheme.onSurface;
    final textSecondary = theme.colorScheme.onSurfaceVariant;
    final dividerColor = theme.dividerColor;
    final borderColor = theme.dividerColor;


    final typeConfig = NotificationConfig.getTypeConfig(live);
    final statusConfig = NotificationConfig.getStatusConfig(live);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded,
              color: textPrimary, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Notification',
          style: TextStyle(
            color: textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded,
                color: AppColors.error, size: 22),
            tooltip: 'Delete',
            onPressed: () => ConfirmDeleteDialog.show(
                context,
                controller: context.read<NotificationController>(),
                notificationId: live.id,
                popAfterDelete: true,
              ),
          ),
          kGapW4,
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Header Card — Gradient + Icon + Type Badge =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    typeConfig.color.withValues(alpha: isDark ? 0.22 : 0.10),
                    typeConfig.color.withValues(alpha: isDark ? 0.06 : 0.03),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: kBorderRadiusXLarge,
                border: Border.all(
                    color:
                        typeConfig.color.withValues(alpha: isDark ? 0.3 : 0.18)),
              ),
              child: Column(
                children: [
                  // Icon
                  Container(
                    height: 72,
                    width: 72,
                    decoration: BoxDecoration(
                      color: typeConfig.color.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Icon(typeConfig.icon,
                        color: typeConfig.color, size: 36),
                  ),
                  const SizedBox(height: 14),
                  // Type badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 5),
                    decoration: BoxDecoration(
                      color: typeConfig.color.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      live.type.toUpperCase(),
                      style: TextStyle(
                        fontSize: 11,
                        color: typeConfig.color,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),


            Text(
              live.title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: textPrimary,
                height: 1.3,
              ),
            ),

            const SizedBox(height: 6),


            if (live.createdAt != null)
              Row(
                children: [
                  const Icon(Icons.access_time_rounded,
                      size: 13, color: AppColors.greyMedium),
                  const SizedBox(width: 5),
                  Text(
                    DateFormat('MMM dd, yyyy  •  hh:mm a')
                        .format(live.createdAt!),
                    style: const TextStyle(
                        fontSize: 13, color: AppColors.greyMedium),
                  ),
                ],
              ),

            const SizedBox(height: 22),


            StatusBanner(config: statusConfig, isDark: isDark),

            const SizedBox(height: 22),

            Divider(color: dividerColor, height: 1),

            const SizedBox(height: 22),


            Text(
              'MESSAGE',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.greyMedium,
                letterSpacing: 1.3,
              ),
            ),
            kGapH10,
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: kBorderRadiusLarge,
                border: Border.all(color: borderColor),
                boxShadow: isDark
                    ? []
                    : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
              ),
              child: Text(
                live.body,
                style: TextStyle(
                  fontSize: 15,
                  color: textSecondary,
                  height: 1.7,
                ),
              ),
            ),

            const SizedBox(height: 22),


            Row(
              children: [
                MetaChip(
                  label: 'TYPE',
                  value: live.type,
                  color: typeConfig.color,
                  isDark: isDark,
                ),
                kGapW12,
                MetaChip(
                  label: 'STATUS',
                  value: live.isRead ? 'Read' : 'Unread',
                  color: live.isRead
                      ? AppColors.greyMedium
                      : AppColors.primary,
                  isDark: isDark,
                ),
              ],
            ),

            const SizedBox(height: 28),


            if (!live.isRead)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () =>
                      context.read<NotificationController>().markAsRead(live.id),
                  icon: const Icon(Icons.done_all_rounded, size: 18),
                  label: const Text(
                    'Mark as Read',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
