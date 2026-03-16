import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';

class ChatSafetyBanner extends StatelessWidget {
  const ChatSafetyBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.info.withValues(alpha: 0.4)),
        color: AppColors.info.withValues(alpha: 0.06),
      ),
      child: Row(
        children: [
          Icon(Icons.shield_outlined, color: AppColors.info, size: 16),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              AppStrings.safetyBanner,
              style: TextStyle(
                color: AppColors.info,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
