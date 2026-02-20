import 'package:flutter/material.dart';
import 'package:frontend/data/models/appointment_model.dart';


class RecentBookingCard extends StatelessWidget {
  final AppointmentModel appointment;
  final VoidCallback? onTap;

  const RecentBookingCard({
    super.key,
    required this.appointment,
    this.onTap,
  });

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case "completed":
        return Colors.green;
      case "scheduled":
        return Colors.blue;
      case "cancelled":
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color =
        _statusColor(appointment.status);

    return Padding(
      padding: const EdgeInsets.only(
          bottom: 16),
      child: InkWell(
        borderRadius:
            BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding:
              const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .surfaceVariant,
            borderRadius:
                BorderRadius.circular(20),
          ),
          child: Row(
            children: [

              // Left Icon
              Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  color: color
                      .withOpacity(0.15),
                  borderRadius:
                      BorderRadius.circular(
                          16),
                ),
                child: Icon(
                  Icons.build,
                  color: color,
                ),
              ),

              const SizedBox(width: 16),

              // Title + Date
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    Text(
                      appointment.jobId ,
                      style: Theme.of(
                              context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                    ),
                    const SizedBox(
                        height: 6),
                    Text(
                      "${appointment.appointmentDate.toLocal().toString().split(" ").first} • ${appointment.timeSlot}",
                      style: Theme.of(
                              context)
                          .textTheme
                          .bodyMedium,
                    ),
                  ],
                ),
              ),

              // Status Badge
              Container(
                padding:
                    const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6),
                decoration: BoxDecoration(
                  color: color
                      .withOpacity(0.15),
                  borderRadius:
                      BorderRadius.circular(
                          20),
                ),
                child: Text(
                  appointment.status
                      .toUpperCase(),
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}