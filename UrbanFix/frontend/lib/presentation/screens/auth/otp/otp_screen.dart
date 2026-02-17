import 'package:flutter/material.dart';
import 'package:frontend/controller/user_controller.dart';
import 'package:provider/provider.dart';
import '../../../../routes/app_routes.dart';
import 'otp_input_field.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = context.read<UserController>();
      controller.startOtpTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    final routeArgument = ModalRoute.of(context)?.settings.arguments;
    final email = routeArgument is String ? routeArgument : "";
    return Consumer<UserController>(
      builder: (context, controller, _) {
        return Scaffold(
          appBar: AppBar(title: const Text("Verify Email")),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 30),

                const Text(
                  "Verification Code",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                Text(
                  email.isEmpty
                      ? "We have sent a 6-digit code to your email"
                      : "We have sent a 6-digit code to $email",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    6,
                    (index) => OtpInputField(
                      controller: controller.otpControllers[index],
                      focusNode: controller.otpFocusNodes[index],
                      isFocused: controller.otpFocusNodes[index].hasFocus,
                      onChanged: (value) =>
                          controller.onOtpChanged(index, value),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                controller.secondsRemaining == 0
                    ? TextButton(
                        onPressed: () async {
                          final messenger = ScaffoldMessenger.of(context);

                          if (email.isEmpty) {
                            messenger.showSnackBar(
                              const SnackBar(
                                content: Text("Missing email to resend OTP"),
                              ),
                            );
                            return;
                          }

                          final success = await controller.resendEmailOtp(
                            email: email,
                          );

                          if (!mounted) return;

                          if (success) {
                            controller.startOtpTimer();
                            messenger.showSnackBar(
                              const SnackBar(
                                content: Text("OTP resent to your email"),
                              ),
                            );
                          } else {
                            messenger.showSnackBar(
                              SnackBar(
                                content: Text(
                                  controller.errorMessage ?? "Failed to resend OTP",
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text("Resend Code"),
                      )
                    : Text(
                        "Resend in 0:${controller.secondsRemaining.toString().padLeft(2, '0')}",
                        style: const TextStyle(color: Colors.blue),
                      ),

                const Spacer(),

                SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.isOtpComplete
                        ? () async {
                            final messenger = ScaffoldMessenger.of(context);
                            final navigator = Navigator.of(context);

                            if (email.isEmpty) {
                              messenger.showSnackBar(
                                const SnackBar(
                                  content: Text("Missing email for OTP verification"),
                                ),
                              );
                              return;
                            }

                            final otp = controller.otpControllers
                                .map((c) => c.text)
                                .join();

                            final success = await controller.verifyOtp(
                              email: email,
                              otp: otp,
                            );

                            if (!mounted) return;

                            if (success) {
                              navigator.pushReplacementNamed(AppRoutes.home);
                            } else {
                              final message = controller.errorMessage ??
                                  "Invalid or expired OTP";
                              messenger.showSnackBar(
                                SnackBar(
                                  content: Text(message),
                                ),
                              );
                            }
                          }
                        : null,
                    child: const Text("Verify & Proceed"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
