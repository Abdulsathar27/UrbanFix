import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';

class MetaChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final bool isDark;

  const MetaChip({
    required this.label,
    required this.value,
    required this.color,
    required this.isDark,
    super.key 
    
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: AppColors.greyMedium,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: isDark ? 0.20 : 0.10),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            value.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
            ),
          ),
        ),
      ],
    );
  }
}