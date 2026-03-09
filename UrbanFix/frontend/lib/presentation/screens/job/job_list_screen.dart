import 'package:flutter/material.dart';
import 'package:frontend/data/controller/job_controller.dart';
import 'package:provider/provider.dart';
import 'widgets/job_card.dart';
import 'widgets/category_chip.dart';

class JobListScreen extends StatelessWidget {
  const JobListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      body: SafeArea(
        child: Column(
          children: [
            // ─── Header ───────────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E5BFF),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(Icons.build, color: Colors.white),
                      ),
                      const SizedBox(width: 15),
                      const Text(
                        "UrbanFix",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.notifications_none),
                      const SizedBox(width: 15),
                      const CircleAvatar(radius: 18),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Search bar
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 55,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F3F6),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.search, color: Colors.grey),
                              SizedBox(width: 10),
                              Text(
                                "Search tasks or services...",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E5BFF),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(Icons.tune, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Category chips
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CategoryChip(label: "All Jobs", isActive: true),
                        CategoryChip(label: "Plumbing"),
                        CategoryChip(label: "Electrical"),
                        CategoryChip(label: "Cleaning"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ─── Body ─────────────────────────────────────────────────────
            Expanded(
              child: Consumer<JobController>(
                builder: (context, controller, child) {
                  if (controller.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.errorMessage != null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.errorMessage!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.red),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: controller.fetchJobs,
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (controller.jobs.isEmpty) {
                    return const Center(child: Text("No jobs available"));
                  }

                  return ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      const Text(
                        "AVAILABLE NEARBY",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 15),
                      ...controller.jobs.map(
                        (job) => Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: JobCard(
                            title: job.title,
                            location: job.location,
                            price: "₹${job.budget ?? 0}",
                            status: job.status,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // ─── Bottom Nav ───────────────────────────────────────────────────────
      bottomNavigationBar: Container(
        height: 75,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.explore, color: Color(0xFF2E5BFF)),
            Icon(Icons.check_circle_outline, color: Colors.grey),
            Icon(Icons.message_outlined, color: Colors.grey),
            Icon(Icons.person_outline, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}