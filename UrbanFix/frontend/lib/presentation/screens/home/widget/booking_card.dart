import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:frontend/data/models/appointment_model.dart';
import 'package:frontend/presentation/screens/home/widget/info_chip.dart';

class BookingCard extends StatelessWidget {
  final AppointmentModel appointment;
  final bool isDark;
  final Color statusColor;
  final IconData statusIcon;
  final String statusLabel;

  const BookingCard({
    required this.appointment,
    required this.isDark,
    required this.statusColor,
    required this.statusIcon,
    required this.statusLabel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final workerName = appointment.workerDetails?['name'] as String?;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF1A2340), const Color(0xFF1E2A50)]
              : [const Color(0xFFEEF3FF), const Color(0xFFDDE8FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.10),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            right: -18,
            top: -18,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.07),
              ),
            ),
          ),
          Positioned(
            right: 30,
            bottom: -24,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.05),
              ),
            ),
          ),

          Padding(
            padding: kPaddingAllMedium,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.receipt_long_rounded,
                            size: 16,
                            color: AppColors.primary,
                          ),
                        ),
                        kGapW8,
                        Text(
                          'Booking #${appointment.id.length > 6 ? appointment.id.substring(appointment.id.length - 6) : appointment.id}',
                          style: TextStyle(
                            fontSize: kFontSmall,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.greyDark,
                          ),
                        ),
                      ],
                    ),
                    // Status badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: statusColor.withValues(alpha: 0.30),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(statusIcon, size: 12, color: statusColor),
                          kGapW4,
                          Text(
                            statusLabel,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: statusColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                kGapH12,

                // Service title
                Text(
                  appointment.workTitle,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.lightTextPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                if (workerName != null) ...[
                  kGapH4,
                  Row(
                    children: [
                      Icon(Icons.person_rounded,
                          size: 13,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.greyDark),
                      kGapW4,
                      Text(
                        workerName,
                        style: TextStyle(
                          fontSize: kFontSmall,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.greyDark,
                        ),
                      ),
                    ],
                  ),
                ],

                const SizedBox(height: 14),
                const Divider(height: 1, thickness: 0.5),
                kGapH12,

                // Date / time / price row
                Row(
                  children: [
                    InfoChip(
                      icon: Icons.calendar_today_rounded,
                      label: appointment.date,
                      isDark: isDark,
                    ),
                    if (appointment.time != null) ...[
                      kGapW12,
                      InfoChip(
                        icon: Icons.access_time_rounded,
                        label: appointment.time!,
                        isDark: isDark,
                      ),
                    ],
                    const Spacer(),
                    Text(
                      '₹${appointment.requestedWage.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: kFontBase,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
