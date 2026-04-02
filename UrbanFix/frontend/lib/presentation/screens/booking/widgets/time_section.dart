import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:frontend/presentation/screens/booking/widgets/time_chip.dart';

class TimeSection extends StatelessWidget {
  const TimeSection({
    super.key,
    required this.timeSlots,
    required this.selectedTimeSlot,
    required this.disabledTimeSlots,
    required this.onTimeSelected,
  });

  final List<String> timeSlots;
  final String selectedTimeSlot;
  final Set<String> disabledTimeSlots;
  final ValueChanged<String> onTimeSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.schedule_rounded, size: kIconSmall, color: AppColors.primary),
            const SizedBox(width: 6),
            Text(
              AppStrings.selectTime,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
        kGapH12,
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: timeSlots.map((slot) {
            return TimeChip(
              slot,
              selected: slot == selectedTimeSlot,
              disabled: disabledTimeSlots.contains(slot),
              onTap: () => onTimeSelected(slot),
            );
          }).toList(),
        ),
      ],
    );
  }
}
