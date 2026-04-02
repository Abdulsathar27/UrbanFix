import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/core/constants/appsize_constants.dart';

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
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.10),
          ),
        ),
        kGapW10,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .onSurface
                .withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            _getLabel(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 11,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              letterSpacing: 0.3,
            ),
          ),
        ),
        kGapW10,
        Expanded(
          child: Divider(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.10),
          ),
        ),
      ],
    );
  }
}
