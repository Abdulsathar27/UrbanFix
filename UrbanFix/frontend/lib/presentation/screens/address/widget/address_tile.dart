import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:frontend/data/models/address_model.dart';

class AddressTile extends StatelessWidget {
  final AddressModel address;
  final VoidCallback onDelete;

  const AddressTile({required this.address, required this.onDelete, super.key});

  IconData get _labelIcon {
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
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: kBorderRadiusLarge,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: kSpaceSmall,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: kPaddingSymMedium,
        leading: Container(
          padding: const EdgeInsets.all(kSpaceSmall + kSpaceXSmall),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.08),
            borderRadius: kBorderRadiusSmall,
          ),
          child: Icon(_labelIcon, color: AppColors.primary, size: kIconMedium),
        ),
        title: Text(
          address.label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: kFontMedium),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: kSpaceXSmall / 2),
          child: Text(
            address.address,
            style: TextStyle(
              fontSize: kFontSmall,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, size: kIconSmall),
          color: AppColors.error,
          onPressed: onDelete,
        ),
      ),
    );
  }
}
