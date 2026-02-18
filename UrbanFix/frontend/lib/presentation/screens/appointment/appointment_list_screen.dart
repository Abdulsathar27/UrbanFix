import 'package:flutter/material.dart';
import 'package:frontend/data/controller/appointment_controller.dart';
import 'package:frontend/routes/app_routes.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_strings.dart';


class AppointmentListScreen extends StatefulWidget {
  const AppointmentListScreen({super.key});

  @override
  State<AppointmentListScreen> createState() =>
      _AppointmentListScreenState();
}

class _AppointmentListScreenState
    extends State<AppointmentListScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<AppointmentController>()
          .fetchAppointments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text(AppStrings.appointments),
      ),
      body: Consumer<AppointmentController>(
        builder: (context, controller, _) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (controller.appointments.isEmpty) {
            return const Center(
              child: Text(
                  AppStrings.noAppointments),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(
                AppConstants.defaultPadding),
            child: ListView.builder(
              itemCount:
                  controller.appointments.length,
              itemBuilder: (context, index) {
                final appointment =
                    controller
                        .appointments[index];

                return Card(
                  child: ListTile(
                    title: Text(
                      "Time: ${appointment.timeSlot}",
                    ),
                    subtitle: Text(
                      "Status: ${appointment.status}",
                    ),
                    trailing: const Icon(
                        Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes
                            .appointmentDetails,
                        arguments:
                            appointment.id,
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
