import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/data/models/appointment_model.dart';
import 'package:frontend/presentation/screens/home/widget/booking_card.dart';
import 'package:frontend/presentation/screens/home/widget/empty_state.dart';

class RecentBookingCard extends StatelessWidget {
  final AppointmentModel? appointment;

  const RecentBookingCard({
    super.key,
    this.appointment,
  });

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'accepted':
        return AppColors.success;
      case 'pending':
        return AppColors.warning;
      case 'completed':
        return AppColors.primary;
      case 'cancelled':
      case 'rejected':
        return AppColors.error;
      default:
        return AppColors.greyMedium;
    }
  }

  IconData statusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'accepted':
        return Icons.check_circle_rounded;
      case 'pending':
        return Icons.hourglass_top_rounded;
      case 'completed':
        return Icons.task_alt_rounded;
      case 'cancelled':
        return Icons.cancel_rounded;
      case 'rejected':
        return Icons.do_not_disturb_on_rounded;
      default:
        return Icons.info_rounded;
    }
  }

  String statusLabel(String status) =>
      status[0].toUpperCase() + status.substring(1).toLowerCase();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Text(
                  AppStrings.recentBooking,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.lightTextPrimary,
                  ),
                ),
                const Spacer(),
                if (appointment != null)
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'View all',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          appointment == null ? EmptyState(isDark: isDark) : BookingCard(
            appointment: appointment!,
            isDark: isDark,
            statusColor: _statusColor(appointment!.status),
            statusIcon: statusIcon(appointment!.status),
            statusLabel: statusLabel(appointment!.status),
          ),
        ],
      ),
    );
  }
}









