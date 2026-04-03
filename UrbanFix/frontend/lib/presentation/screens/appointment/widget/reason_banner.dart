import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/appsize_constants.dart';

class ReasonBanner extends StatelessWidget {
  final String reason;
  final bool isCancelled;

  const ReasonBanner({required this.reason, required this.isCancelled,super.key});

  @override
  Widget build(BuildContext context) {
    final color = isCancelled ? AppColors.error : AppColors.greyMedium;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: kSpaceSmall,
        vertical: kSpaceXSmall,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: kBorderRadiusSmall,
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isCancelled ? Icons.cancel_outlined : Icons.block_rounded,
            size: kIconXSmall + 2,
            color: color,
          ),
          kGapW4,
          Expanded(
            child: Text(
              reason,
              style: TextStyle(
                fontSize: kFontXSmall,
                color: color,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}