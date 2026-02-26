import 'package:flutter/material.dart';
import 'package:frontend/data/controller/appointment_controller.dart';
import 'package:frontend/presentation/screens/appointment/widgets/bottom_confirm_section.dart';
import 'package:frontend/presentation/screens/appointment/widgets/date_section.dart';
import 'package:frontend/presentation/screens/appointment/widgets/location_section.dart';
import 'package:frontend/presentation/screens/appointment/widgets/service_card.dart';
import 'package:frontend/presentation/screens/appointment/widgets/time_section.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => context.go('/home'),
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
                  const ServiceCard(),
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
            builder: (context, controller, _) => BottomSection(
              totalAmount: controller.estimatedTotal,
              // isLoading: controller.isLoading,
              // onConfirm: () => controller.confirmAppointment(context),
            ),
          ),
        ],
      ),
    );
  }
}
