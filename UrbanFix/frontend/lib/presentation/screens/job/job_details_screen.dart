import 'package:flutter/material.dart';
import 'package:frontend/controller/job_controller.dart';
import 'package:frontend/core/utils/helpers.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_constants.dart';


class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String jobId =
        ModalRoute.of(context)!.settings.arguments
            as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Job Details"),
      ),
      body: Consumer<JobController>(
        builder: (context, controller, _) {
          final job = controller.jobs.firstWhere(
            (j) => j.id == jobId,
            orElse: () => controller.jobs.first,
          );

          return Padding(
            padding: const EdgeInsets.all(
                AppConstants.defaultPadding),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                _buildDetailRow("Title", job.title),
                const SizedBox(height: 12),

                _buildDetailRow(
                    "Description", job.description),
                const SizedBox(height: 12),

                _buildDetailRow(
                    "Category", job.category),
                const SizedBox(height: 12),

                _buildDetailRow(
                    "Location", job.location),
                const SizedBox(height: 12),

                _buildDetailRow(
                    "Status", job.status),
                const SizedBox(height: 12),

                if (job.budget != null)
                  _buildDetailRow(
                      "Budget",
                      job.budget!
                          .toStringAsFixed(2)),

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final confirmed =
                          await Helpers
                              .showConfirmationDialog(
                        context,
                        title: "Delete Job",
                        message:
                            "Are you sure you want to delete this job?",
                      );

                      if (confirmed == true) {
                        await controller
                            .deleteJob(job.id);

                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: const Text("Delete Job"),
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
