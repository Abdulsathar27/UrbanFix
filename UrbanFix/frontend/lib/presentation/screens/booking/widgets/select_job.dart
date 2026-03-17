import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/data/controller/appointment_controller.dart';
import 'package:frontend/data/controller/job_controller.dart';
import 'package:frontend/data/models/job_model.dart';
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
class JobCard extends StatelessWidget {
  final JobModel job;
  final VoidCallback onTap;

  const JobCard({
    required this.job,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Convert wage string to display format
    final wageText = job.wage;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Job title and wage
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      job.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '₹$wageText',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // ✅ Description
              Text(
                job.description,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.greyMedium,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),

              // ✅ Skills and location
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 14,
                    color: AppColors.greyDark,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      job.location,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.greyDark,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // ✅ Worker info (if available)
              if (job.user != null)
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: job.user!['profileImage'] != null
                          ? NetworkImage(job.user!['profileImage'])
                          : null,
                      child: job.user!['profileImage'] == null
                          ? const Icon(Icons.person)
                          : null,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            job.user!['name'] ?? AppStrings.labelWorker,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            job.user!['profession'] ?? job.category,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.greyMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Rating
                    if (job.averageRating > 0)
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            size: 14,
                            color: AppColors.categoryElectrical,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${job.averageRating.toStringAsFixed(1)} (${job.reviewCount})',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}