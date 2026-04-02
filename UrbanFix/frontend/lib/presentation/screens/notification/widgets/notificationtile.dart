import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
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
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// ================= ICON
          Container(
            height: kHeight56,
            width: kWidth56,
            decoration: BoxDecoration(
              color: AppColors.greyLight,
              borderRadius: kBorderRadiusLarge,
            ),
            child: const Icon(
              Icons.notifications,
              color: AppColors.primary,
            ),
          ),

          kGapW16,

          /// ================= TEXT CONTENT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: const TextStyle(
                    fontSize: kFontLarge,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  notification.body,
                  style: const TextStyle(
                    color: AppColors.greyDark,
                  ),
                ),
              ],
            ),
          ),

          /// ================= UNREAD DOT
          if (!notification.isRead)
            Container(
              margin: const EdgeInsets.only(top: 8),
              height: 10,
              width: 10,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
