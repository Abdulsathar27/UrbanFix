import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F0FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.cleaning_services,
                color: Colors.blue),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "House Cleaning",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  "Professional deep cleaning",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$50",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              Text(
                "Fixed rate",
                style: TextStyle(color: Colors.grey),
              )
            ],
          )
        ],
      ),
    );
  }
}