import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:frontend/data/controller/user_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'otp_input_field.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final email = GoRouterState.of(context).extra as String? ?? '';

    return Consumer<UserController>(
      builder: (context, controller, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Verify Email'),
            centerTitle: true,
            elevation: 0,
          ),
          body: SafeArea(
            child: Padding(
              padding: kPaddingAllLarge,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  kGapH24,
                  _OtpHeader(email: email),
                  kGapH40,
                  _OtpFields(controller: controller),
                  kGapH24,
                  _ResendRow(
                    controller: controller,
                    email: email,
                  ),
                  const Spacer(),
                  if (controller.errorMessage != null) ...[
                    _ErrorBanner(message: controller.errorMessage!),
                    kGapH12,
                  ],
                  _VerifyButton(controller: controller, email: email),
                  kGapH16,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────
// Sub-widgets
// ─────────────────────────────────────────────────────────

class _OtpHeader extends StatelessWidget {
  final String email;
  const _OtpHeader({required this.email});

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

class _OtpFields extends StatelessWidget {
  final UserController controller;
  const _OtpFields({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        6,
        (index) => OtpInputField(
          controller: controller.otpControllers[index],
          focusNode: controller.otpFocusNodes[index],
          isFocused: controller.otpFocusNodes[index].hasFocus,
          onChanged: (value) =>
              controller.otpControllers[index].text = value,
        ),
      ),
    );
  }
}

class _ResendRow extends StatelessWidget {
  final UserController controller;
  final String email;
  const _ResendRow({required this.controller, required this.email});

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

class _ErrorBanner extends StatelessWidget {
  final String message;
  const _ErrorBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: kSpaceMedium,
        vertical: kSpaceSmall,
      ),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.08),
        borderRadius: kBorderRadiusMedium,
        border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline_rounded,
            size: kIconSmall,
            color: AppColors.error,
          ),
          kGapW8,
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: kFontSmall,
                color: AppColors.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VerifyButton extends StatelessWidget {
  final UserController controller;
  final String email;
  const _VerifyButton({required this.controller, required this.email});

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
