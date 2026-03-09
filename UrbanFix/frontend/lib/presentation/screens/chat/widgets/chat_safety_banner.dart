import 'package:flutter/material.dart';

class ChatSafetyBanner extends StatelessWidget {
  const ChatSafetyBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
        color: Colors.blue.withOpacity(0.06),
      ),
      child: Row(
        children: [
          Icon(Icons.shield_outlined, color: Colors.blue.shade400, size: 16),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'For your safety, always keep payments within UrbanFix.',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}