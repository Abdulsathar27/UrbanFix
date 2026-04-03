import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/appsize_constants.dart';

class OtpHeader extends StatelessWidget {
  final String email;
  const OtpHeader({required this.email,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.mark_email_read_outlined,
            size: 36,
            color: AppColors.primary,
          ),
        ),
        kGapH16,
        const Text(
          'Verification Code',
          style: TextStyle(
            fontSize: kFontXXLarge,
            fontWeight: FontWeight.bold,
          ),
        ),
        kGapH8,
        Text(
          email.isEmpty
              ? 'We sent a 6-digit code to your email'
              : 'We sent a 6-digit code to\n$email',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: kFontMedium,
            color: AppColors.greyMedium,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}