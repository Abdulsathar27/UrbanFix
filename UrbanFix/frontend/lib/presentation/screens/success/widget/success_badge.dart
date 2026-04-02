import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/appsize_constants.dart';

class SuccessBadge extends StatelessWidget {
  const SuccessBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.white.withValues(alpha: 0.15),
          ),
          child: Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
              child: const Icon(
                Icons.check_rounded,
                color: AppColors.success,
                size: 56,
              ),
            ),
          ),
        ),
        kGapH20,
        Text(
          'You\'re all set!',
          style: TextStyle(
            fontSize: kFontBase,
            fontWeight: FontWeight.w600,
            color: AppColors.white.withValues(alpha: 0.9),
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}
