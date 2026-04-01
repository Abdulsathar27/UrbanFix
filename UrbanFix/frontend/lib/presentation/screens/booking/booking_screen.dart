import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/data/controller/appointment_controller.dart';
import 'package:frontend/presentation/screens/booking/widgets/bottom_confirm_section.dart';
import 'package:frontend/presentation/screens/booking/widgets/date_section.dart';
import 'package:frontend/presentation/screens/booking/widgets/location_section.dart';
import 'package:frontend/presentation/screens/booking/widgets/service_card.dart';
import 'package:frontend/presentation/screens/booking/widgets/step_label.dart';
import 'package:frontend/presentation/screens/booking/widgets/time_section.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BookingScreen extends StatelessWidget {
  final String? category;

  const BookingScreen({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    final ctrl = context.read<AppointmentController>();
    if (category != null && category!.isNotEmpty && ctrl.category != category) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          context.read<AppointmentController>().category = category!;
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          AppStrings.bookAppointment,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StepLabel(number: '1', label: AppStrings.selectService),
                  const SizedBox(height: 10),
                  Consumer<AppointmentController>(
                    builder: (context, controller, _) => ServiceCard(
                      workTitle: controller.workTitle ?? AppStrings.selectAJob,
                      requestedWage: controller.requestedWage ?? 0.0,
                      description: controller.description,
                      onTap: () {
                        final cat = controller.category;
                        if (cat == null || cat.isEmpty) {
                          context.pushNamed('select-category');
                        } else {
                          context.pushNamed('select-job', extra: cat);
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 28),

                  StepLabel(number: '2', label: AppStrings.selectDate),
                  const SizedBox(height: 10),
                  Consumer<AppointmentController>(
                    builder: (context, controller, _) => DateSection(
                      availableDates: controller.availableDates,
                      selectedDate: controller.selectedDate,
                      onDateSelected: controller.selectDate,
                    ),
                  ),
                  const SizedBox(height: 28),

                  StepLabel(number: '3', label: AppStrings.selectTime),
                  const SizedBox(height: 10),
                  Consumer<AppointmentController>(
                    builder: (context, controller, _) => TimeSection(
                      timeSlots: controller.availableTimeSlots,
                      selectedTimeSlot: controller.selectedTimeSlot,
                      disabledTimeSlots: controller.disabledTimeSlots,
                      onTimeSelected: controller.selectTimeSlot,
                    ),
                  ),
                  const SizedBox(height: 28),

                  StepLabel(number: '4', label: AppStrings.customerDetails),
                  const SizedBox(height: 10),
                  const LocationSection(),
                  const SizedBox(height: 8),
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
