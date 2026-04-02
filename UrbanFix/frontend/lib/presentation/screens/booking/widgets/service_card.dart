import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/core/constants/appsize_constants.dart';

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

  bool get _isEmpty => workTitle == AppStrings.selectAJob;

  IconData _iconFor(String title) {
    final t = title.toLowerCase();
    if (t.contains('clean')) return Icons.cleaning_services_rounded;
    if (t.contains('plumb')) return Icons.plumbing_rounded;
    if (t.contains('elect')) return Icons.electrical_services_rounded;
    if (t.contains('paint')) return Icons.brush_rounded;
    if (t.contains('mov')) return Icons.local_shipping_rounded;
    if (t.contains('carpent')) return Icons.handyman_rounded;
    return Icons.build_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: kPaddingAllMedium,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: kBorderRadiusLarge,
          border: _isEmpty
              ? Border.all(
                  color: AppColors.primary.withValues(alpha: 0.35),
                  width: 1.5,
                  strokeAlign: BorderSide.strokeAlignInside,
                )
              : null,
          boxShadow: _isEmpty
              ? null
              : [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    blurRadius: kSpaceMedium,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: _isEmpty ? _emptyState(context) : _filledState(context),
      ),
    );
  }

  Widget _emptyState(BuildContext context) {
    return Row(
      children: [
        Container(
          width: kWidth48,
          height: kHeight48,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: kBorderRadiusMedium,
          ),
          child: const Icon(Icons.add_rounded, color: AppColors.primary),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.whatServiceDoYouNeed,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: kFontMedium,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                AppStrings.tapToChooseService,
                style: TextStyle(fontSize: kFontSmall, color: AppColors.greyMedium),
              ),
            ],
          ),
        ),
        const Icon(Icons.chevron_right_rounded, color: AppColors.greyMedium),
      ],
    );
  }

  Widget _filledState(BuildContext context) {
    return Row(
      children: [
        Container(
          width: kWidth48,
          height: kHeight48,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: kBorderRadiusMedium,
          ),
          child: Icon(_iconFor(workTitle), color: AppColors.primary),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                workTitle,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                description ?? AppStrings.professionalService,
                style: const TextStyle(fontSize: kFontSmall, color: AppColors.greyMedium),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        kGapW8,
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '₹${requestedWage.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const Text(
              AppStrings.fixedRate,
              style: TextStyle(fontSize: 11, color: AppColors.greyMedium),
            ),
          ],
        ),
      ],
    );
  }
}
