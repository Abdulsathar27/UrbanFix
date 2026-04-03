import 'package:flutter/material.dart';
import 'package:frontend/core/constants/appsize_constants.dart';

class StatusBadge extends StatelessWidget {
  final String status;
  final Color color;
  final String label;

  const StatusBadge({
    required this.status,
    required this.color,
    required this.label,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kSpaceSmall,
        vertical: kSpaceXSmall / 2,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: kBorderRadiusFull,
        border: Border.all(color: color.withValues(alpha: 0.35), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          kGapW4,
          Text(
            label,
            style: TextStyle(
              fontSize: kFontXSmall,
              fontWeight: FontWeight.w700,
              color: color,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}