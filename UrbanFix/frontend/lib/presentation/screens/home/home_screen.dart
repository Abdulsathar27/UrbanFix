import 'package:flutter/material.dart';
import 'package:frontend/controller/appointment_controller.dart';
import 'package:frontend/controller/job_controller.dart';
import 'package:frontend/controller/notification_controller.dart';
import 'package:frontend/controller/user_controller.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/helpers.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<JobController>().fetchJobs();
      context.read<AppointmentController>().fetchAppointments();
      context.read<NotificationController>().fetchNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        actions: [
          Consumer<NotificationController>(
            builder: (context, controller, _) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.notifications,
                      );
                    },
                  ),
                  if (controller.unreadCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          controller.unreadCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final confirmed =
                  await Helpers.showConfirmationDialog(
                context,
                title: "Logout",
                message:
                    "Are you sure you want to logout?",
              );

              if (confirmed == true) {
                await context
                    .read<UserController>()
                    .logout();

                if (context.mounted) {
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.login,
                  );
                }
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(
            AppConstants.defaultPadding),
        child: Consumer3<JobController,
            AppointmentController, UserController>(
          builder: (context, jobController,
              appointmentController, userController, _) {

            if (jobController.isLoading ||
                appointmentController.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome, ${userController.currentUser?.name ?? ""}",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge,
                ),

                const SizedBox(height: 24),

                _buildStatCard(
                  title: AppStrings.jobs,
                  value: jobController.jobs.length
                      .toString(),
                  icon: Icons.work,
                ),

                const SizedBox(height: 16),

                _buildStatCard(
                  title: AppStrings.appointments,
                  value: appointmentController
                      .appointments.length
                      .toString(),
                  icon: Icons.calendar_today,
                ),

                const SizedBox(height: 32),

                Expanded(
                  child: ListView.builder(
                    itemCount:
                        jobController.jobs.length,
                    itemBuilder: (context, index) {
                      final job =
                          jobController.jobs[index];

                      return Card(
                        child: ListTile(
                          title: Text(job.title),
                          subtitle:
                              Text(job.status),
                          trailing: const Icon(
                              Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.jobDetails,
                              arguments: job.id,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(
            AppConstants.defaultPadding),
        child: Row(
          children: [
            Icon(icon, size: 32),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
