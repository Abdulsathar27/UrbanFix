import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:frontend/data/controller/appointment_controller.dart';
import 'package:frontend/data/controller/job_controller.dart';
import 'package:frontend/presentation/screens/booking/widgets/job_card.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SelectJobScreen extends StatelessWidget {
  final String category;

  const SelectJobScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      if (!context.mounted) return;
      final controller = context.read<JobController>();
      if (controller.jobs.isEmpty) controller.fetchJobs();
      controller.filterJobsByCategory(category);
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Select a $category Job',
          style: const TextStyle(fontSize: kFontXLarge, fontWeight: FontWeight.w600),
        ),
      ),
      body: Consumer<JobController>(
        builder: (context, controller, _) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: kIconXLarge, color: AppColors.error),
                  kGapH16,
                  Text(
                    controller.errorMessage ?? AppStrings.errorLoadingJobs,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: kFontBase),
                  ),
                  kGapH16,
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

          if (controller.filteredJobs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.work_outline, size: kIconXLarge, color: AppColors.greyMedium),
                  kGapH16,
                  Text(
                    'No $category jobs available',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: kFontBase, color: AppColors.greyMedium),
                  ),
                  kGapH24,
                  ElevatedButton.icon(
                    onPressed: () => controller.filterJobsByCategory(category),
                    icon: const Icon(Icons.refresh),
                    label: const Text(AppStrings.refresh),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: kPaddingAllMedium,
            itemCount: controller.filteredJobs.length,
            itemBuilder: (context, index) {
              final job = controller.filteredJobs[index];
              return JobCard(
                job: job,
                onTap: () {
                  if (!controller.validateJobSelection(job)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(controller.errorMessage ?? AppStrings.cannotSelectJob),
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

                  context.read<AppointmentController>().setServiceDetails(
                    jobId: jobData['jobId'] as String,
                    workerId: workerId,
                    category: jobData['category'] as String,
                    workTitle: jobData['workTitle'] as String,
                    requestedWage: jobData['requestedWage'] as double,
                    description: jobData['description'] as String?,
                  );

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
