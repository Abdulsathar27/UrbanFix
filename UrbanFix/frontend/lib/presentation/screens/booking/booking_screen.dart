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
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = GoRouterState.of(context).extra as Map<String, dynamic>?;

  
    if (args != null) {
      Future.microtask(() {
        if (!context.mounted) return;
        context.read<AppointmentController>().setServiceDetails(
          jobId: args['jobId'],
          workerId: args['workerId'],
          category: args['category'],
          workTitle: args['workTitle'],
          requestedWage: (args['requestedWage'] as num).toDouble(),
          description: args['description'],
        );
      });
    }

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
                  Consumer<AppointmentController>(
                    builder: (context, controller, _) => ServiceCard(
                      workTitle: controller.workTitle ?? 'Select a job',
                      requestedWage: controller.requestedWage ?? 0.0,
                      description: controller.description ?? 'Tap to choose a service',
                      onTap: () async {
                        final currentCategory = controller.category;
                        if (currentCategory == null) return;

                        final selectedJob =
                            await context.pushNamed<Map<String, dynamic>>(
                          'select-job',
                          extra: currentCategory,
                        );

                        if (selectedJob != null && context.mounted) {
                          context.read<AppointmentController>().setServiceDetails(
                            jobId: selectedJob['jobId'],
                            workerId: selectedJob['workerId'],
                            category: selectedJob['category'] ?? currentCategory,
                            workTitle: selectedJob['workTitle'],
                            requestedWage:
                                (selectedJob['requestedWage'] as num).toDouble(),
                            description: selectedJob['description'],
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  Consumer<AppointmentController>(
                    builder: (context, controller, _) => DateSection(
                      availableDates: controller.availableDates,
                      selectedDate: controller.selectedDate,
                      onDateSelected: controller.selectDate,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Consumer<AppointmentController>(
                    builder: (context, controller, _) => TimeSection(
                      timeSlots: controller.availableTimeSlots,
                      selectedTimeSlot: controller.selectedTimeSlot,
                      disabledTimeSlots: controller.disabledTimeSlots,
                      onTimeSelected: controller.selectTimeSlot,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const LocationSection(),
                ],
              ),
            ),
          ),
          Consumer<AppointmentController>(
            builder: (context, controller, _) =>
                BottomSection(totalAmount: controller.estimatedTotal),
          ),
        ],
      ),
    );
  }
}