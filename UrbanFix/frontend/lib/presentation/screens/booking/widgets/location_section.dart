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
      builder: (context, appointmentController, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.customerDetails,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.greyLight),
              ),
              child: Column(
                children: [
                  // Name Field
                  _buildField(
                    onChanged: (value) {
                      appointmentController.customerName = value;
                    },
                    label: AppStrings.labelName,
                    icon: Icons.person,
                    hint: AppStrings.hintFullName,
                  ),
                  const SizedBox(height: 12),

                  // Phone Field
                  _buildField(
                    onChanged: (value) {
                      appointmentController.customerPhone = value;
                    },
                    label: AppStrings.labelPhone,
                    icon: Icons.phone,
                    hint: AppStrings.hintPhoneNumber,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 12),

                  // Address Field
                  _buildField(
                    onChanged: (value) {
                      appointmentController.customerAddress = value;
                    },
                    label: AppStrings.labelAddress,
                    icon: Icons.location_on,
                    hint: AppStrings.hintAddress,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildField({
    required Function(String) onChanged,
    required String label,
    required IconData icon,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.lightTextSecondary,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          onChanged: onChanged,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 18, color: AppColors.greyDark),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.greyLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
          ),
        ),
      ],
    );
  }
}