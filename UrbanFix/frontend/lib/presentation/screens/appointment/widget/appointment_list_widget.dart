import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/data/controller/appointment_controller.dart';
import 'package:frontend/data/models/appointment_model.dart';
import 'package:frontend/presentation/screens/appointment/widget/appointment_list_tile.dart';
import 'package:frontend/presentation/screens/appointment/widget/empty_appointments_widget.dart';

class AppointmentListWidget extends StatelessWidget {
  final AppointmentController controller;
  final List<AppointmentModel> appointments;
  final String emptyMessage;

  const AppointmentListWidget({
    super.key,
    required this.controller,
    required this.appointments,
    required this.emptyMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (appointments.isEmpty) {
      return EmptyAppointmentsWidget(
        message: emptyMessage,
        onRetry: controller.refreshAppointments,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];

        final isUpcoming =
            controller.upcomingAppointments.contains(appointment);

        return AppointmentListTile(
          appointment: appointment,
          isUpcoming: isUpcoming,
          controller: controller,
          onTap: isUpcoming
              ? () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${AppStrings.detailsFor}${appointment.workTitle}'),
                    ),
                  );
                }
              : null,
        );
      },
    );
  }
}