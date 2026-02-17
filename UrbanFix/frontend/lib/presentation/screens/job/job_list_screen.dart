import 'package:flutter/material.dart';
import 'package:frontend/controller/job_controller.dart';
import 'package:frontend/routes/app_routes.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_strings.dart';

class JobListScreen extends StatefulWidget {
  const JobListScreen({super.key});

  @override
  State<JobListScreen> createState() =>
      _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<JobController>().fetchJobs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.jobs),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AppRoutes.createJob,
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<JobController>(
        builder: (context, controller, _) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (controller.jobs.isEmpty) {
            return const Center(
              child: Text(AppStrings.noJobs),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(
                AppConstants.defaultPadding),
            child: ListView.builder(
              itemCount: controller.jobs.length,
              itemBuilder: (context, index) {
                final job = controller.jobs[index];

                return Card(
                  child: ListTile(
                    title: Text(job.title),
                    subtitle: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text("Category: ${job.category}"),
                        Text("Status: ${job.status}"),
                      ],
                    ),
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
          );
        },
      ),
    );
  }
}
