import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/appsize_constants.dart';

class ChatButton extends StatelessWidget {
  final VoidCallback onTap;

  const ChatButton({required this.onTap,super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: kSpaceMedium - 4,
          vertical: kSpaceXSmall,
        ),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: kBorderRadiusFull,
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.chat_bubble_rounded,
              size: kIconXSmall,
              color: AppColors.white,
            ),
            SizedBox(width: kSpaceXSmall),
            Text(
              'Chat',
              style: TextStyle(
                fontSize: kFontSmall,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}