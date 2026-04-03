import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:frontend/data/controller/user_controller.dart';

class ResendRow extends StatelessWidget {
  final UserController controller;
  final String email;
  const ResendRow({required this.controller, required this.email,super.key});

  Future<void> _resend(BuildContext context) async {
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Missing email to resend OTP')),
      );
      return;
    }
    final success = await controller.resendEmailOtp(email: email);
    if (!context.mounted) return;
    if (success) {
      controller.startOtpTimer();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP resent to your email')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            controller.errorMessage ?? 'Failed to resend OTP',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (controller.secondsRemaining == 0) {
      return TextButton.icon(
        onPressed: () => _resend(context),
        icon: const Icon(Icons.refresh_rounded, size: kIconSmall),
        label: const Text(
          'Resend Code',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Resend in ',
          style: TextStyle(color: AppColors.greyMedium, fontSize: kFontMedium),
        ),
        Text(
          '0:${controller.secondsRemaining.toString().padLeft(2, '0')}',
          style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
            fontSize: kFontMedium,
          ),
        ),
      ],
    );
  }
}