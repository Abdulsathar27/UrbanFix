import 'package:flutter/material.dart';
import 'package:frontend/data/controller/appointment_controller.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/helpers.dart';


class AppointmentDetailsScreen extends StatelessWidget {
  const AppointmentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String appointmentId =
        ModalRoute.of(context)!.settings.arguments
            as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Appointment Details"),
      ),
      body: Consumer<AppointmentController>(
        builder: (context, controller, _) {
          final appointment =
              controller.appointments.firstWhere(
            (a) => a.id == appointmentId,
            orElse: () => controller.appointments.first,
          );

          return Padding(
            padding: const EdgeInsets.all(
                AppConstants.defaultPadding),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                _buildDetailRow(
                    "Appointment ID",
                    appointment.id),

                const SizedBox(height: 12),

                _buildDetailRow(
                    "Job ID", appointment.jobId),

                const SizedBox(height: 12),

                _buildDetailRow(
                    "Service Provider",
                    appointment
                        .serviceProviderId),

                const SizedBox(height: 12),

                _buildDetailRow(
                    "Date",
                    appointment
                        .appointmentDate
                        .toLocal()
                        .toString()
                        .split(" ")
                        .first),

                const SizedBox(height: 12),

                _buildDetailRow("Time",
                    appointment.timeSlot),

                const SizedBox(height: 12),

                _buildDetailRow("Status",
                    appointment.status),

                const SizedBox(height: 12),

                if (appointment.notes != null)
                  _buildDetailRow(
                      "Notes", appointment.notes!),

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final confirmed =
                          await Helpers
                              .showConfirmationDialog(
                        context,
                        title: "Cancel",
                        message:
                            "Cancel this appointment?",
                      );

                      if (confirmed == true) {
                        await controller
                            .updateStatus(
                          appointmentId:
                              appointment.id,
                          status:
                              "cancelled",
                        );

                        if (context.mounted) {
                          Navigator.pop(
                              context);
                        }
                      }
                    },
                    child: const Text(
                        "Cancel Appointment"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(
      String label, String value) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            "$label:",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(value),
        ),
      ],
    );
  }
}
