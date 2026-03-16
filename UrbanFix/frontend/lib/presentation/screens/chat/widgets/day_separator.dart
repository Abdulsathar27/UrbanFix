import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';

class DaySeparator extends StatelessWidget {
  final DateTime date;
  const DaySeparator({super.key, required this.date});

  String _getLabel() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final msgDay = DateTime(date.year, date.month, date.day);

    if (msgDay == today) return AppStrings.today;
    if (msgDay == yesterday) return AppStrings.yesterday;

    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.greyLight,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _getLabel(),
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: AppColors.greyDark,
        ),
      ),
    );
  }
}
