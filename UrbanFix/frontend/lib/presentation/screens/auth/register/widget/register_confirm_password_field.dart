import 'package:flutter/material.dart';
import 'package:frontend/core/utils/validators.dart';


class RegisterConfirmPasswordField
    extends StatelessWidget {
  final TextEditingController controller;
  final bool isVisible;
  final VoidCallback onToggle;

  const RegisterConfirmPasswordField({
    super.key,
    required this.controller,
    required this.isVisible,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: !isVisible,
      validator: Validators.validatePassword,
      decoration: InputDecoration(
        hintText: "Confirm Password",
        prefixIcon:
            const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible
                ? Icons.visibility
                : Icons.visibility_off,
          ),
          onPressed: onToggle,
        ),
      ),
    );
  }
}
