import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/appsize_constants.dart';

class EmptyState extends StatelessWidget {
  final VoidCallback onAdd;

  const EmptyState({required this.onAdd, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: kPaddingAllLarge,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.location_on_outlined,
              size: kIconXLarge,
              color: AppColors.primary.withValues(alpha: 0.6),
            ),
          ),
          kGapH16,
          const Text(
            'No saved addresses',
            style: TextStyle(fontSize: kFontBase, fontWeight: FontWeight.w600),
          ),
          kGapH8,
          Text(
            'Add an address to get started',
            style: TextStyle(
              fontSize: kFontSmall,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
          kGapH24,
          TextButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add, size: kIconMedium),
            label: const Text('Add Address'),
            style: TextButton.styleFrom(foregroundColor: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
