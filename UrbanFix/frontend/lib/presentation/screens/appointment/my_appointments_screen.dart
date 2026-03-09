import 'package:flutter/material.dart';
import 'package:frontend/data/controller/appointment_controller.dart';
import 'package:frontend/presentation/screens/appointment/widget/appointment_list_widget.dart';
import 'package:frontend/presentation/screens/appointment/widget/error_appointments_widget.dart';
import 'package:frontend/presentation/screens/appointment/widget/loading_appointments_widget.dart';
import 'package:go_router/go_router.dart';

class MyAppointmentsScreen extends StatelessWidget {
  final AppointmentController controller;

  const MyAppointmentsScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    controller.initialize();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Appointments'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              context.go('/profile');
            },
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(52),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(0, 26, 46, 66),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: const Color.fromARGB(179, 0, 45, 194),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  labelColor: const Color.fromARGB(255, 2, 5, 8),
                  unselectedLabelColor: const Color(0xFF7A9BBF),
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    letterSpacing: 0.4,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                  tabs: [
                    Tab(
                      height: 38,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.calendar_today_rounded, size: 14),
                          SizedBox(width: 6),
                          Text('Upcoming'),
                        ],
                      ),
                    ),
                    Tab(
                      height: 38,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.history_rounded, size: 14),
                          SizedBox(width: 6),
                          Text('Past'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            if (!controller.isInitialized && controller.isLoading) {
              return const LoadingAppointmentsWidget();
            }

            if (controller.errorMessage != null &&
                controller.upcomingAppointments.isEmpty &&
                controller.pastAppointments.isEmpty) {
              return ErrorAppointmentsWidget(
                error: controller.errorMessage!,
                onRetry: controller.refreshAppointments,
              );
            }

            return RefreshIndicator(
              onRefresh: controller.refreshAppointments,
              child: TabBarView(
                children: [
                  AppointmentListWidget(
                    controller: controller,
                    appointments: controller.upcomingAppointments,
                    emptyMessage: 'No upcoming appointments',
                  ),
                  AppointmentListWidget(
                    controller: controller,
                    appointments: controller.pastAppointments,
                    emptyMessage: 'No past appointments',
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
