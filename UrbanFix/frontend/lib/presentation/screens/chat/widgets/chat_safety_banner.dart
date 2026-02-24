import 'package:flutter/material.dart';

class ChatSafetyBanner extends StatelessWidget {
  const ChatSafetyBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8),
      padding:
          const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(12),
        border: Border.all(
            color: Colors.blue),
        color: Colors.blue
            .withOpacity(0.08),
      ),
      child: const Text(
        "For your safety, always keep payments within UrbanFix.",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}