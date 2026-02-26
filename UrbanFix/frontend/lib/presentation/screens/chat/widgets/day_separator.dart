import 'package:flutter/material.dart';

class DaySeparator extends StatelessWidget {
  final DateTime date;

  const DaySeparator({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
              horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: const Text(
        "TODAY",
        style: TextStyle(
            fontWeight: FontWeight.w600),
      ),
    );
  }
}