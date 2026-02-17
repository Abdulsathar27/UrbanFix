import 'package:flutter/material.dart';
import 'package:frontend/core/utils/validators.dart';


class RegisterNameField extends StatelessWidget {
  final TextEditingController controller;

  const RegisterNameField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (v) =>
          Validators.validateRequired(v, "Name"),
      decoration: const InputDecoration(
        hintText: "Full Name",
        prefixIcon: Icon(Icons.person),
      ),
    );
  }
}
