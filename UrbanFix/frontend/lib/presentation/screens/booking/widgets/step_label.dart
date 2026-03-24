import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';

class StepLabel extends StatelessWidget {
  final String number;
  final String label;

  const StepLabel({required this.number, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.greyDark,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}
