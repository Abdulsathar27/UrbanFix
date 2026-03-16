import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/data/models/appointment_model.dart';

class RecentBookingCard extends StatelessWidget {
  final AppointmentModel appointment;

  const RecentBookingCard({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.recentBooking,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text('${AppStrings.serviceLabel}${appointment.workTitle}'),
          Text('${AppStrings.dateLabel}${appointment.date}'),
          Text('${AppStrings.timeLabel}${appointment.time}'),
        ],
      ),
    );
  }
}
