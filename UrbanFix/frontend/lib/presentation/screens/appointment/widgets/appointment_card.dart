import 'package:flutter/material.dart';
import 'package:frontend/data/models/appointment_model.dart';
import 'appointment_status_badge.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentModel appointment;
  final VoidCallback? onTap;

  const AppointmentCard({
    super.key,
    required this.appointment,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(
          "Time: ${appointment.timeSlot}",
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          appointment.appointmentDate
              .toLocal()
              .toString()
              .split(" ")
              .first,
        ),
        trailing: AppointmentStatusBadge(
          status: appointment.status,
        ),
      ),
    );
  }
}
