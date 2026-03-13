import 'package:flutter/material.dart';
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
              "Customer Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                children: [
                  // Name Field
                  _buildField(
                    onChanged: (value) {
                      appointmentController.customerName = value;
                    },
                    label: "Full Name",
                    icon: Icons.person,
                    hint: "Enter your name",
                  ),
                  const SizedBox(height: 12),

                  // Phone Field
                  _buildField(
                    onChanged: (value) {
                      appointmentController.customerPhone = value;
                    },
                    label: "Phone",
                    icon: Icons.phone,
                    hint: "10-digit number",
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 12),

                  // Address Field
                  _buildField(
                    onChanged: (value) {
                      appointmentController.customerAddress = value;
                    },
                    label: "Address",
                    icon: Icons.location_on,
                    hint: "Street address",
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
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          onChanged: onChanged,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 18, color: Colors.grey[600]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFF0066FF),
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