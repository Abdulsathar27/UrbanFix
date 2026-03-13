import 'package:flutter/material.dart';
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
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Select a $category Job',
          style: const TextStyle(
            color: Colors.black,
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
                    color: Colors.red[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    controller.errorMessage ?? 'Error loading jobs',
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
                    label: const Text('Retry'),
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
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No $category jobs available',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      controller.filterJobsByCategory(category);
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Refresh'),
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
                  // ✅ Validate job before selection
                  if (!controller.validateJobSelection(job)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          controller.errorMessage ?? 'Cannot select this job',
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  // ✅ Prepare job data
                  final jobData = controller.prepareJobForBooking(job);

                  // ✅ Return to previous screen with job data
                  context.pop(jobData);
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
                      color: const Color(0xFF0066FF).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '₹$wageText',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0066FF),
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
                  color: Colors.grey,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),

              // ✅ Skills and location
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 14,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      job.location,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
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
                            job.user!['name'] ?? 'Worker',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            job.user!['profession'] ?? job.category,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
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
                            color: Color(0xFFFFB800),
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