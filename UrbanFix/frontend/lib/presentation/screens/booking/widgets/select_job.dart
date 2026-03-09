import 'package:flutter/material.dart';
import 'package:frontend/data/controller/job_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SelectJobScreen extends StatelessWidget {
  final String category;
  const SelectJobScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final jobController = context.watch<JobController>();
    final filteredJobs = jobController.jobs
        .where(
          (job) =>
              job.category.trim().toLowerCase() ==
              category.trim().toLowerCase(),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text('Select a $category Job')),
      body: jobController.isLoading
          ? const Center(child: CircularProgressIndicator())
          : filteredJobs.isEmpty
          ? Center(child: Text('No jobs found for $category'))
          : ListView.builder(
              itemCount: filteredJobs.length,
              itemBuilder: (context, index) {
                final job = filteredJobs[index];
                return ListTile(
                  title: Text(job.title),
                  subtitle: Text('\$${job.budget ?? 0} - ${job.description}'),
                  onTap: () {
                    if (job.assignedWorkerId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('This job has no assigned worker yet.'),
                        ),
                      );
                      return;
                    }
                    context.pop({
                      'jobId': job.id,
                      'workerId': job.assignedWorkerId!,
                      'category': job.category,
                      'workTitle': job.title,
                      'requestedWage': job.budget ?? 0.0,
                      'description': job.description,
                    });
                  },
                );
              },
            ),
    );
  }
}
