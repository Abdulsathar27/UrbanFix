import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/data/controller/appointment_controller.dart';
import 'package:frontend/data/controller/job_controller.dart';
import 'package:frontend/presentation/screens/booking/widgets/job_card.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


class SelectJobScreen extends StatelessWidget {
  final String category;

  const SelectJobScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ Trigger loading when screen mounts
    Future.microtask(() {
      if (!context.mounted) return;
      final controller = context.read<JobController>();
      
      // Only fetch if not already loaded
      if (controller.jobs.isEmpty) {
        controller.fetchJobs();
      }
      
      // Filter by selected category
      controller.filterJobsByCategory(category);
    });

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.transparent,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.lightTextPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Select a $category Job',
          style: const TextStyle(
            color: AppColors.lightTextPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Consumer<JobController>(
        builder: (context, controller, _) {
          // ✅ Loading state
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // ✅ Error state
          if (controller.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: AppColors.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    controller.errorMessage ?? AppStrings.errorLoadingJobs,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      controller.fetchJobs();
                      controller.filterJobsByCategory(category);
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text(AppStrings.retry),
                  ),
                ],
              ),
            );
          }

          // ✅ Empty state
          if (controller.filteredJobs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.work_outline,
                    size: 48,
                    color: AppColors.greyMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No $category jobs available',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.greyMedium,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      controller.filterJobsByCategory(category);
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text(AppStrings.refresh),
                  ),
                ],
              ),
            );
          }

          // ✅ Jobs list
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.filteredJobs.length,
            itemBuilder: (context, index) {
              final job = controller.filteredJobs[index];
              return JobCard(
                job: job,
                onTap: () {
                  // Validate job before selection
                  if (!controller.validateJobSelection(job)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          controller.errorMessage ?? AppStrings.cannotSelectJob,
                        ),
                        backgroundColor: AppColors.error,
                      ),
                    );
                    return;
                  }

                  final jobData = controller.prepareJobForBooking(job);
                  final workerId = jobData['workerId'] as String? ?? '';

                  if (workerId.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(AppStrings.workerInfoMissing),
                        backgroundColor: AppColors.error,
                      ),
                    );
                    return;
                  }

                  // Save service details in controller
                  context.read<AppointmentController>().setServiceDetails(
                    jobId: jobData['jobId'] as String,
                    workerId: workerId,
                    category: jobData['category'] as String,
                    workTitle: jobData['workTitle'] as String,
                    requestedWage: jobData['requestedWage'] as double,
                    description: jobData['description'] as String?,
                  );

                  // Navigate directly to booking screen
                  context.goNamed('bookings');
                },
              );
            },
          );
        },
      ),
    );
  }
}

/// Job Card Widget
