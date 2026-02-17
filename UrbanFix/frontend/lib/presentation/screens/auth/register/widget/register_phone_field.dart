import 'package:flutter/material.dart';
import 'package:frontend/core/utils/validators.dart';


class RegisterPhoneField extends StatelessWidget {
  final TextEditingController controller;

  const RegisterPhoneField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (v) =>
          Validators.validateRequired(v, "Phone"),
      decoration: const InputDecoration(
        hintText: "Phone Number",
        prefixIcon: Icon(Icons.phone),
      ),
    );
  }
}
