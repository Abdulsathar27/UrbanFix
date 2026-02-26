// NEW CODE - Design 3: Minimalist Premium with Border
import 'package:flutter/material.dart';

class ServiceCards extends StatelessWidget {
  final String title;
  final bool isSelected; // Optional selection state
  final VoidCallback? onTap;

  const ServiceCards({
    super.key,
    required this.title,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.blue.shade400 : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected 
                  ? Colors.blue.withOpacity(0.2)
                  : Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon with animation
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getIconForTitle(title),
                color: isSelected ? Colors.white : Colors.grey.shade600,
                size: 24,
              ),
            ),
            const SizedBox(height: 12),
            // Title
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? Colors.blue.shade700 : Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForTitle(String title) {
    // Similar icon mapping as Design 1
    if (title.toLowerCase().contains('hair')) return Icons.content_cut;
    if (title.toLowerCase().contains('spa')) return Icons.spa;
    if (title.toLowerCase().contains('massage')) return Icons.fitness_center;
    if (title.toLowerCase().contains('facial')) return Icons.face;
    if (title.toLowerCase().contains('nail')) return Icons.brush;
    return Icons.star;
  }
}