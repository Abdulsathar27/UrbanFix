import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';

class ServicesHeader extends StatelessWidget {
  final String title;

  const ServicesHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
