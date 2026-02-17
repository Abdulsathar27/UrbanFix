import 'package:flutter/material.dart';

class RegisterTermsCheckbox
    extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const RegisterTermsCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: (v) =>
              onChanged(v ?? false),
        ),
        const Expanded(
          child: Text(
            "I agree to the Terms of Service and Privacy Policy",
          ),
        ),
      ],
    );
  }
}
