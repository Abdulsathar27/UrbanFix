import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final String workTitle;
  final double requestedWage;
  final String? description;
  final VoidCallback? onTap; 

  const ServiceCard({
    super.key,
    required this.workTitle,
    required this.requestedWage,
    this.description,
    this.onTap, 
  });

  IconData _getIconForService(String title) {
    final lower = title.toLowerCase();
    if (lower.contains('clean')) return Icons.cleaning_services;
    if (lower.contains('plumb')) return Icons.plumbing;
    if (lower.contains('elect')) return Icons.electrical_services;
    if (lower.contains('paint')) return Icons.brush;
    if (lower.contains('move') || lower.contains('moving')) return Icons.local_shipping;
    if (lower.contains('carpent')) return Icons.handyman;
    return Icons.build;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell( 
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
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
              child: Icon(_getIconForService(workTitle), color: Colors.blue),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    workTitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description ?? "Professional service",
                    style: const TextStyle(color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "₹${requestedWage.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const Text(
                  "Fixed rate",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}