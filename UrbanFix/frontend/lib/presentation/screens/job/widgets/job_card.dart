import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/job/widgets/job_status_badge.dart';


class JobCard extends StatelessWidget {
  final String title;
  final String location;
  final String price;
  final String status;
  final String imageUrl;

  const JobCard({
    super.key,
    required this.title,
    required this.location,
    required this.price,
    required this.status,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              color: Colors.black12, blurRadius: 8)
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20)),
                child: Image.network(
                  imageUrl,
                  height: 170,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 15,
                left: 15,
                child:
                    JobStatusBadge(status: status),
              )
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold),
                      ),
                    ),
                    Text(
                      price,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                          color:
                              Color(0xFF2E5BFF)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  location,
                  style: const TextStyle(
                      color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}