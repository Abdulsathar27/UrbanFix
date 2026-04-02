import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/appsize_constants.dart';

class Field extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;

  const Field({
    required this.label,
    required this.hint,
    required this.icon,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: kFontSmall,
            fontWeight: FontWeight.w600,
            color: AppColors.greyDark,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          onChanged: onChanged,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          style: const TextStyle(fontSize: kFontMedium),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.greyMedium, fontSize: 13),
            prefixIcon: Icon(icon, size: kIconSmall, color: AppColors.primary),
            filled: true,
            fillColor: Theme.of(context).inputDecorationTheme.fillColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
