import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:frontend/data/models/address_model.dart';

class SelectableTile extends StatelessWidget {
  final AddressModel address;
  final VoidCallback onTap;

  const SelectableTile({required this.address, required this.onTap, super.key});

  IconData get _icon {
    switch (address.label) {
      case 'Home':
        return Icons.home_outlined;
      case 'Work':
        return Icons.work_outline;
      default:
        return Icons.location_on_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kSpaceSmall),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: kSpaceMedium, vertical: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.greyLight),
          ),
          child: Row(
            children: [
              Container(
                padding: kPaddingAllSmall,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: kBorderRadiusSmall,
                ),
                child: Icon(_icon, color: AppColors.primary, size: kIconSmall),
              ),
              kGapW12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      address.label,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      address.address,
                      style: TextStyle(
                        fontSize: kFontSmall,
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, size: kIconSmall, color: AppColors.greyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
