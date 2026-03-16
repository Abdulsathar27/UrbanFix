import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';

class ProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;

  const ProfileTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        filled: true,
        fillColor: AppColors.lightBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}