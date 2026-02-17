import 'package:flutter/material.dart';
import 'package:frontend/data/models/job_model.dart';
import 'job_status_badge.dart';

class JobCard extends StatelessWidget {
  final JobModel job;
  final VoidCallback? onTap;

  const JobCard({
    super.key,
    required this.job,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(
          job.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text("Category: ${job.category}"),
            if (job.budget != null)
              Text(
                  "Budget: ₹${job.budget!.toStringAsFixed(0)}"),
          ],
        ),
        trailing: JobStatusBadge(
          status: job.status,
        ),
      ),
    );
  }
}
