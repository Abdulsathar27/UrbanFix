import 'package:flutter/material.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:frontend/data/controller/user_controller.dart';
import 'package:frontend/presentation/screens/auth/otp/widget/error_banner.dart';
import 'package:frontend/presentation/screens/auth/otp/widget/otp_fields.dart';
import 'package:frontend/presentation/screens/auth/otp/widget/otp_header.dart';
import 'package:frontend/presentation/screens/auth/otp/widget/resend_row.dart';
import 'package:frontend/presentation/screens/auth/otp/widget/verify_button.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


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
                  OtpHeader(email: email),
                  kGapH40,
                  OtpFields(controller: controller),
                  kGapH24,
                  ResendRow(
                    controller: controller,
                    email: email,
                  ),
                  const Spacer(),
                  if (controller.errorMessage != null) ...[
                    ErrorBanner(message: controller.errorMessage!),
                    kGapH12,
                  ],
                  VerifyButton(controller: controller, email: email),
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












