import 'package:flutter/material.dart';
import 'package:frontend/data/controller/appointment_controller.dart';
import 'package:frontend/presentation/screens/booking/widgets/bottom_confirm_section.dart';
import 'package:frontend/presentation/screens/booking/widgets/date_section.dart';
import 'package:frontend/presentation/screens/booking/widgets/location_section.dart';
import 'package:frontend/presentation/screens/booking/widgets/service_card.dart';
import 'package:frontend/presentation/screens/booking/widgets/time_section.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BookingScreen extends StatelessWidget {
  final String? category;

  const BookingScreen({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      if (!context.mounted) return;

      final controller = context.read<AppointmentController>();

      // ✅ Use a local variable to avoid promotion issue
      final categoryValue = category;

      // ✅ Only set category if it's NOT null
      if (categoryValue != null && categoryValue.isNotEmpty) {
        controller.category = categoryValue;
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Book Appointment",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===== SERVICE CARD =====
                  Consumer<AppointmentController>(
                    builder: (context, controller, _) => ServiceCard(
                      workTitle: controller.workTitle ?? 'Select a job',
                      requestedWage: controller.requestedWage ?? 0.0,
                      description:
                          controller.description ?? 'Tap to choose a service',
                      onTap: () async {
                        // ✅ Get current category from controller
                        final currentCategoryValue = controller.category;

                        // ✅ Check if category is null or empty
                        if (currentCategoryValue == null ||
                            currentCategoryValue.isEmpty) {
                          // Show error and navigate to category selection
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please select a service category first',
                                ),
                                backgroundColor: Colors.orange,
                              ),
                            );

                            // Navigate to category selection
                            await context.pushNamed('select-category');
                          }
                          return;
                        }

                        // ✅ Now we know currentCategoryValue is NOT null
                        // Navigate to select job with the category
                        final selectedJob = await context
                            .pushNamed<Map<String, dynamic>>(
                              'select-job',
                              extra: currentCategoryValue, // ✅ Safe to use
                            );

                        // ✅ Update service details if user selected a job
                        if (selectedJob != null && context.mounted) {
                          context
                              .read<AppointmentController>()
                              .setServiceDetails(
                                jobId: selectedJob['jobId'] as String,
                                workerId: selectedJob['workerId'] as String,
                                category:
                                    selectedJob['category'] as String? ??
                                    currentCategoryValue,
                                workTitle: selectedJob['workTitle'] as String,
                                requestedWage:
                                    (selectedJob['requestedWage'] as num)
                                        .toDouble(),
                                description:
                                    selectedJob['description'] as String?,
                              );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ===== DATE SECTION =====
                  Consumer<AppointmentController>(
                    builder: (context, controller, _) => DateSection(
                      availableDates: controller.availableDates,
                      selectedDate: controller.selectedDate,
                      onDateSelected: controller.selectDate,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ===== TIME SECTION =====
                  Consumer<AppointmentController>(
                    builder: (context, controller, _) => TimeSection(
                      timeSlots: controller.availableTimeSlots,
                      selectedTimeSlot: controller.selectedTimeSlot,
                      disabledTimeSlots: controller.disabledTimeSlots,
                      onTimeSelected: controller.selectTimeSlot,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ===== LOCATION SECTION =====
                  LocationSection(
                  ),
                ],
              ),
            ),
          ),

          // ===== BOTTOM CONFIRM BUTTON =====
          Consumer<AppointmentController>(
            builder: (context, controller, _) =>
                BottomSection(totalAmount: controller.estimatedTotal),
          ),
        ],
      ),
    );
  }
}
