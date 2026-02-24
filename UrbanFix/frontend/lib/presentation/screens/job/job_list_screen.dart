import 'package:flutter/material.dart';
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

            /// HEADER SECTION
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
                        child: const Icon(Icons.build,
                            color: Colors.white),
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

                  /// Search Bar
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16),
                          height: 55,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F3F6),
                            borderRadius:
                                BorderRadius.circular(18),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.search,
                                  color: Colors.grey),
                              SizedBox(width: 10),
                              Text(
                                "Search tasks or services...",
                                style: TextStyle(
                                    color: Colors.grey),
                              )
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
                          borderRadius:
                              BorderRadius.circular(18),
                        ),
                        child: const Icon(Icons.tune,
                            color: Colors.white),
                      )
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// Category Chips
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CategoryChip(
                            label: "All Jobs", isActive: true),
                        CategoryChip(label: "Plumbing"),
                        CategoryChip(label: "Electrical"),
                        CategoryChip(label: "Cleaning"),
                      ],
                    ),
                  )
                ],
              ),
            ),

            /// BODY LIST
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: const [
                  Text(
                    "AVAILABLE NEARBY",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  SizedBox(height: 15),

                  JobCard(
                    title: "Leaky Faucet Repair",
                    location: "Brooklyn, NY (2.5 miles away)",
                    price: "\$150.00",
                    status: "IN PROGRESS",
                    imageUrl:
                        "https://images.unsplash.com/photo-1581578731548-c64695cc6952",
                  ),

                  SizedBox(height: 20),

                  JobCard(
                    title: "Living Room Rewiring",
                    location: "Queens, NY (5.1 miles away)",
                    price: "\$420.00",
                    status: "COMPLETED",
                    imageUrl:
                        "https://images.unsplash.com/photo-1581090700227-1e8a2f8f32d0",
                  ),

                  SizedBox(height: 20),

                  JobCard(
                    title: "Garden Landscaping",
                    location: "Manhattan, NY (0.8 miles away)",
                    price: "\$300.00",
                    status: "PENDING",
                    imageUrl:
                        "https://images.unsplash.com/photo-1501004318641-b39e6451bec6",
                  ),
                ],
              ),
            )
          ],
        ),
      ),

      /// Bottom Navigation
      bottomNavigationBar: Container(
        height: 75,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                color: Colors.black12)
          ],
        ),
        child: const Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.explore, color: Color(0xFF2E5BFF)),
            Icon(Icons.check_circle_outline,
                color: Colors.grey),
            Icon(Icons.message_outlined,
                color: Colors.grey),
            Icon(Icons.person_outline,
                color: Colors.grey),
          ],
        ),
      ),
    );
  }
}