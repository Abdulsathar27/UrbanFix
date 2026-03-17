import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/data/controller/appointment_controller.dart';
import 'package:provider/provider.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({super.key, required this.totalAmount});

  final double totalAmount;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppointmentController>(
      builder: (context, controller, child) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(color: AppColors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    AppStrings.estimatedTotal,
                    style: TextStyle(fontSize: 16, color: AppColors.greyMedium),
                  ),
                  Text(
                    "₹${totalAmount.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: controller.isConfirming
                      ? null
                      : () async {
                          final success = await controller.confirmAppointment(
                            context,
                          );
                          if (success && context.mounted) {
                            context.goNamed("appointment_success");
                          }
                        },
                  child: controller.isConfirming
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.white,
                            ),
                          ),
                        )
                      : const Text(
                          AppStrings.confirmAppointment,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
