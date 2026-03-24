import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/data/controller/appointment_controller.dart';
import 'package:provider/provider.dart';

class LocationSection extends StatelessWidget {
  const LocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppointmentController>(
      builder: (context, controller, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.person_pin_circle_rounded,
                    size: 18, color: AppColors.primary),
                SizedBox(width: 6),
                Text(
                  AppStrings.customerDetails,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: AppColors.lightTextPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _Field(
              label: AppStrings.labelName,
              hint: AppStrings.hintFullName,
              icon: Icons.person_outline_rounded,
              onChanged: (v) => controller.customerName = v,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 12),
            _Field(
              label: AppStrings.labelPhone,
              hint: AppStrings.hintPhoneNumber,
              icon: Icons.phone_outlined,
              onChanged: (v) => controller.customerPhone = v,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 12),
            _Field(
              label: AppStrings.labelAddress,
              hint: AppStrings.hintAddress,
              icon: Icons.location_on_outlined,
              onChanged: (v) => controller.customerAddress = v,
              maxLines: 2,
              textInputAction: TextInputAction.done,
            ),
          ],
        );
      },
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final int maxLines;

  const _Field({
    required this.label,
    required this.hint,
    required this.icon,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
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
          maxLines: maxLines,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: AppColors.greyMedium,
              fontSize: 13,
            ),
            prefixIcon: Icon(icon, size: 18, color: AppColors.primary),
            filled: true,
            fillColor: AppColors.inputFill,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
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
              borderSide:
                  const BorderSide(color: AppColors.primary, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
