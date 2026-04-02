import 'package:flutter/material.dart';
import 'package:frontend/core/constants/appsize_constants.dart';

class OtpInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String>? onChanged;

  const OtpInputField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.onChanged,
    required bool isFocused,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 55,
      height: 55,
      child: AnimatedBuilder(
        animation: focusNode,
        builder: (context, _) {
          final isFocused = focusNode.hasFocus;
          return Container(
            decoration: BoxDecoration(
              borderRadius: kBorderRadiusMedium,
              border: Border.all(
                color: isFocused ? Theme.of(context).primaryColor : Colors.grey.shade300,
                width: 2,
              ),
            ),
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 1,
              style: const TextStyle(fontSize: kFontXLarge, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(counterText: "", border: InputBorder.none),
              onChanged: onChanged,
            ),
          );
        },
      ),
    );
  }
}
