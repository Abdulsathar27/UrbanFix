import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/data/controller/appointment_controller.dart';
import 'package:frontend/data/models/appointment_model.dart';

class AppointmentListTile extends StatelessWidget {
  final AppointmentModel appointment;
  final bool isUpcoming;
  final VoidCallback? onTap;
  final AppointmentController controller;

  const AppointmentListTile({
    super.key,
    required this.appointment,
    required this.isUpcoming,
    this.onTap,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(appointment.status);
    
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Row(
                children: [
                  Expanded(
                    child: Text(
                      appointment.workTitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _buildRoleIndicator(context),
                ],
              ),
              const SizedBox(height: 8),
              
              
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16, color: AppColors.greyMedium),
                  const SizedBox(width: 4),
                  Text(
                    controller.formatDate(appointment.date),
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.access_time, size: 16, color: AppColors.greyMedium),
                  const SizedBox(width: 4),
                  Text(
                    controller.formatTime(appointment.time),
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              
              
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: statusColor.withValues(alpha: 0.5)),
                    ),
                    child: Text(
                      controller.formatStatus(appointment.status),
                      style: TextStyle(
                        fontSize: 12,
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  if (appointment.requestedWage > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
                      ),
                      child: Text(
                        controller.formatCurrency(appointment.requestedWage),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.success,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
              if (isUpcoming) const SizedBox(height: 4),
              if (isUpcoming)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      AppStrings.tapForDetails,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(Icons.chevron_right, size: 16, color: AppColors.primary),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleIndicator(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        AppStrings.youBooked,
        style: TextStyle(
          fontSize: 10,
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return AppColors.warning;
      case 'accepted':
        return AppColors.primary;
      case 'confirmed':
        return AppColors.success;
      case 'completed':
        return AppColors.info;
      case 'cancelled':
        return AppColors.error;
      case 'rejected':
        return AppColors.greyMedium;
      default:
        return AppColors.greyMedium;
    }
  }
}