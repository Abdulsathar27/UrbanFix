import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? iconColor;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: backgroundColor ??
                  Theme.of(context)
                      .colorScheme
                      .surfaceVariant,
              borderRadius:
                  BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              size: 36,
              color: iconColor ??
                  Theme.of(context)
                      .colorScheme
                      .primary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
                  fontWeight:
                      FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}