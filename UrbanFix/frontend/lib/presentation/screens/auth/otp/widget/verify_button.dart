import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:frontend/data/controller/user_controller.dart';
import 'package:go_router/go_router.dart';

class VerifyButton extends StatelessWidget {
  final UserController controller;
  final String email;
  const VerifyButton({required this.controller, required this.email,super.key});

  Future<void> _verify(BuildContext context) async {
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Missing email for OTP verification')),
      );
      return;
    }
    final otp = controller.otpControllers.map((c) => c.text).join();
    final success = await controller.verifyOtp(email: email, otp: otp);
    if (!context.mounted) return;
    if (success) {
      context.goNamed('home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final canSubmit = controller.isOtpComplete && !controller.isLoading;

    return SizedBox(
      height: 52,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: canSubmit ? () => _verify(context) : null,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: kBorderRadiusMedium,
          ),
        ),
        child: controller.isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColors.white,
                ),
              )
            : const Text(
                'Verify & Proceed',
                style: TextStyle(
                  fontSize: kFontBase,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
      ),
    );
  }
}