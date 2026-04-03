import 'package:flutter/material.dart';
import 'package:frontend/data/controller/user_controller.dart';
import 'package:frontend/presentation/screens/auth/otp/otp_input_field.dart';

class OtpFields extends StatelessWidget {
  final UserController controller;
  const OtpFields({required this.controller,super.key});

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