import 'package:flutter/material.dart';
import 'package:frontend/core/constants/appsize_constants.dart';

class ServiceIcon extends StatelessWidget {
  final String workTitle;
  final Color statusColor;

  const ServiceIcon({required this.workTitle, required this.statusColor,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kIconXLarge,
      height: kIconXLarge,
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.12),
        borderRadius: kBorderRadiusMedium,
      ),
      child: Icon(
        _iconForTitle(workTitle),
        size: kIconSmall,
        color: statusColor,
      ),
    );
  }

  IconData _iconForTitle(String title) {
    final t = title.toLowerCase();
    if (t.contains('plumb')) return Icons.plumbing_rounded;
    if (t.contains('electr')) return Icons.electrical_services_rounded;
    if (t.contains('clean')) return Icons.cleaning_services_rounded;
    if (t.contains('paint')) return Icons.format_paint_rounded;
    if (t.contains('carpen') || t.contains('wood')) return Icons.handyman_rounded;
    if (t.contains('mov') || t.contains('shift')) return Icons.local_shipping_rounded;
    if (t.contains('cook') || t.contains('chef')) return Icons.restaurant_rounded;
    if (t.contains('health') || t.contains('medic')) return Icons.medical_services_rounded;
    return Icons.build_circle_outlined;
  }
}


