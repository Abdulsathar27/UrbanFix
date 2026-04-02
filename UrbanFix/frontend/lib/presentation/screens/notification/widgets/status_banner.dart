import 'package:flutter/material.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:frontend/data/models/notification_model.dart';

class StatusBanner extends StatelessWidget {
  final StatusConfig config;
  final bool isDark;

  const StatusBanner({required this.config, required this.isDark,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: config.color.withValues(alpha: isDark ? 0.16 : 0.08),
        borderRadius: kBorderRadiusLarge,
        border: Border.all(color: config.color.withValues(alpha: 0.28)),
      ),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: config.color.withValues(alpha: 0.18),
              borderRadius: kBorderRadiusMedium,
            ),
            child: Icon(config.icon, color: config.color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  config.label,
                  style: TextStyle(
                    fontSize: kFontMedium,
                    fontWeight: FontWeight.w700,
                    color: config.color,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  config.subtitle,
                  style: TextStyle(
                    fontSize: kFontSmall,
                    color: config.color.withValues(alpha: 0.75),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
