
import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/core/constants/appsize_constants.dart';

class ChatEmptyState extends StatelessWidget {
  const ChatEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.chat_bubble_outline_rounded,
              color: AppColors.primary,
              size: 40,
            ),
          ),
          kGapH16,
          const Text(
            AppStrings.noChatsYet,
            style: TextStyle(fontSize: kFontBase, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          const Text(
            'Your conversations will appear here',
            style: TextStyle(fontSize: 13, color: AppColors.greyMedium),
          ),
        ],
      ),
    );
  }
}