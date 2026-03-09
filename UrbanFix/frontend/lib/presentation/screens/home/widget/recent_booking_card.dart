import 'package:flutter/material.dart';
import 'package:frontend/data/models/appointment_model.dart';


class RecentBookingCard extends StatelessWidget {
  final AppointmentModel appointment;

  const RecentBookingCard({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Recent Booking",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text("Service: ${appointment.workTitle}"),
          Text("Date: ${appointment.date}"),
          Text("Time: ${appointment.time}"),
        ],
      ),
    );
  }
}