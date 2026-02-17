import 'package:flutter/material.dart';
import 'package:frontend/core/utils/validators.dart';


class RegisterEmailField extends StatelessWidget {
  final TextEditingController controller;

  const RegisterEmailField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: Validators.validateEmail,
      decoration: const InputDecoration(
        hintText: "Email Address",
        prefixIcon: Icon(Icons.email),
      ),
    );
  }
}
