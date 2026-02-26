import 'package:flutter/material.dart';

class TimeChip extends StatelessWidget {
  const TimeChip(
    this.time, {
    required this.onTap,
    this.selected = false,
    this.disabled = false,
    super.key,
  });
  final String time;
  final bool selected;
  final bool disabled;
  final VoidCallback onTap;

 

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