import 'package:flutter/material.dart';
import 'package:frontend/data/controller/appointment_controller.dart';
import 'package:provider/provider.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({
    super.key,
    required this.totalAmount,
  });

  final double totalAmount;

  @override
  Widget build(BuildContext context) {
    
    return Consumer<AppointmentController>(
      builder: (context, controller, child) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Estimated Total",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  Text(
                    "\$${totalAmount.toStringAsFixed(2)}",
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
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed:
                      controller.isLoading ? null : () => controller.confirmAppointment(context),
                  child: controller.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : const Text(
                          "Confirm Appointment",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
