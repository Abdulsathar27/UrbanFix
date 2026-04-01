import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/data/models/notification_model.dart';

/// Utility class that maps a [NotificationModel] to display config
/// (icon + color for type, and label + status for the status banner).
class NotificationConfig {
  NotificationConfig._();

  // ===== Type → Icon + Color =====
  static TypeConfig getTypeConfig(NotificationModel n) {
    final type = n.type.toLowerCase();
    final title = n.title.toLowerCase();

    if (type.contains('payment') || title.contains('payment')) {
      return TypeConfig(icon: Icons.payments_rounded, color: AppColors.success);
    } else if (type.contains('appointment') || title.contains('appointment')) {
      return TypeConfig(
          icon: Icons.calendar_month_rounded, color: AppColors.primary);
    } else if (type.contains('chat') || title.contains('message')) {
      return TypeConfig(
          icon: Icons.chat_bubble_rounded, color: const Color(0xFF9C27B0));
    } else if (type.contains('report') || title.contains('report')) {
      return TypeConfig(
          icon: Icons.report_problem_rounded, color: AppColors.warning);
    } else if (type.contains('service') || title.contains('service')) {
      return TypeConfig(
          icon: Icons.build_rounded, color: const Color(0xFF00897B));
    } else if (type.contains('profile') || title.contains('profile')) {
      return TypeConfig(
          icon: Icons.person_rounded, color: const Color(0xFF1565C0));
    } else {
      return TypeConfig(
          icon: Icons.notifications_rounded, color: AppColors.info);
    }
  }

  // ===== Title + Body → Status Banner =====
  static StatusConfig getStatusConfig(NotificationModel n) {
    final text = ('${n.title} ${n.body}').toLowerCase();

    if (text.contains('accept') ||
        text.contains('approved') ||
        text.contains('confirmed')) {
      return StatusConfig(
        label: 'Request Accepted',
        subtitle: 'Your request has been accepted',
        icon: Icons.check_circle_rounded,
        color: AppColors.success,
      );
    } else if (text.contains('reject') ||
        text.contains('denied') ||
        text.contains('declined') ||
        text.contains('cancel')) {
      return StatusConfig(
        label: 'Request Rejected',
        subtitle: 'Your request was not accepted',
        icon: Icons.cancel_rounded,
        color: AppColors.error,
      );
    } else if (text.contains('pending') ||
        text.contains('waiting') ||
        text.contains('review')) {
      return StatusConfig(
        label: 'Under Review',
        subtitle: 'Your request is being reviewed',
        icon: Icons.hourglass_top_rounded,
        color: AppColors.warning,
      );
    } else if (text.contains('complet') ||
        text.contains('done') ||
        text.contains('success')) {
      return StatusConfig(
        label: 'Completed',
        subtitle: 'This action has been completed',
        icon: Icons.task_alt_rounded,
        color: AppColors.success,
      );
    } else if (text.contains('payment') || text.contains('paid')) {
      return StatusConfig(
        label: 'Payment',
        subtitle: 'Payment related notification',
        icon: Icons.payments_rounded,
        color: AppColors.success,
      );
    } else {
      return StatusConfig(
        label: 'Information',
        subtitle: 'General notification',
        icon: Icons.info_rounded,
        color: AppColors.info,
      );
    }
  }
}
