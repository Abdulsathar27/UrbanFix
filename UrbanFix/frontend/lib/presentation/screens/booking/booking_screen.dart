import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
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

      
      final categoryValue = category;

     
      if (categoryValue != null && categoryValue.isNotEmpty) {
        controller.category = categoryValue;
      }
    });

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.transparent,
        centerTitle: true,
        title: const Text(
          AppStrings.bookAppointment,
          style: TextStyle(color: AppColors.lightTextPrimary),
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
                      workTitle: controller.workTitle ?? AppStrings.selectAJob,
                      requestedWage: controller.requestedWage ?? 0.0,
                      description: controller.description ??
                          AppStrings.tapToChooseService,
                      onTap: () {
                        final currentCategory = controller.category;
                        if (currentCategory == null ||
                            currentCategory.isEmpty) {
                          // No category yet — go pick one (which chains to job selection)
                          context.pushNamed('select-category');
                        } else {
                          // Category already set — go straight to job selection
                          context.pushNamed(
                            'select-job',
                            extra: currentCategory,
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
