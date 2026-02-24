import 'package:flutter/material.dart';

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
            return _TimeChip(
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

class _TimeChip extends StatelessWidget {
  final String time;
  final bool selected;
  final bool disabled;
  final VoidCallback onTap;

  const _TimeChip(
    this.time, {
    required this.onTap,
    this.selected = false,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: disabled ? null : onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFE8F0FF)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? Colors.blue
                : Colors.grey.shade300,
          ),
        ),
        child: Text(
          time,
          style: TextStyle(
            color: disabled
                ? Colors.grey
                : selected
                    ? Colors.blue
                    : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
