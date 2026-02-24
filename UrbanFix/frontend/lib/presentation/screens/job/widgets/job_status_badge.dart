import 'package:flutter/material.dart';

class JobStatusBadge extends StatelessWidget {
  final String status;

  const JobStatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;

    switch (status) {
      case "COMPLETED":
        bgColor = Colors.green;
        break;
      case "PENDING":
        bgColor = Colors.orange;
        break;
      default:
        bgColor = const Color(0xFF2E5BFF);
    }

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}