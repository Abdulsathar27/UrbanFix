import 'package:flutter/material.dart';
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
        const Text("Select Time",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: timeSlots.map((String slot) {
            return TimeChip(
              slot,
              selected: slot == selectedTimeSlot,
              disabled: disabledTimeSlots.contains(slot),
              onTap: () => onTimeSelected(slot),
            );
          }).toList(),
        )
      ],
    );
  }
}


