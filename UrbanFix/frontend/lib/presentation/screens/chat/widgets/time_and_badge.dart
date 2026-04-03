import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/appsize_constants.dart';

class TimeAndBadge extends StatelessWidget {
  const TimeAndBadge({required this.time, required this.unreadCount,super.key});

  final String time;
  final int unreadCount;

  bool get _hasUnread => unreadCount > 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          time,
          style: TextStyle(
            fontSize: 11,
            color: _hasUnread ? AppColors.primary : AppColors.greyMedium,
            fontWeight: _hasUnread ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        if (_hasUnread) ...[
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: kBorderRadiusFull,
            ),
            child: Text(
              unreadCount.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ],
    );
  }
}