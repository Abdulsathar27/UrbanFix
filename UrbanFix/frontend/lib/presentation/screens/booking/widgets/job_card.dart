import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:frontend/data/models/job_model.dart';

class JobCard extends StatelessWidget {
  final JobModel job;
  final VoidCallback onTap;

  const JobCard({required this.job, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final wageText = job.wage;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: kBorderRadiusMedium),
        child: Padding(
          padding: kPaddingAllMedium,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      job.title,
                      style: const TextStyle(fontSize: kFontBase, fontWeight: FontWeight.w600),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  kGapW8,
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: kBorderRadiusSmall,
                    ),
                    child: Text(
                      '₹$wageText',
                      style: const TextStyle(
                        fontSize: kFontMedium,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              kGapH12,
              Text(
                job.description,
                style: const TextStyle(fontSize: 13, color: AppColors.greyMedium),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              kGapH12,
              Row(
                children: [
                  const Icon(Icons.location_on, size: kIconXSmall, color: AppColors.greyDark),
                  kGapW4,
                  Expanded(
                    child: Text(
                      job.location,
                      style: const TextStyle(fontSize: kFontSmall, color: AppColors.greyDark),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              kGapH8,
              if (job.user != null)
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: job.user!['profileImage'] != null
                          ? NetworkImage(job.user!['profileImage'])
                          : null,
                      child: job.user!['profileImage'] == null
                          ? const Icon(Icons.person)
                          : null,
                    ),
                    kGapW8,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            job.user!['name'] ?? AppStrings.labelWorker,
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            job.user!['profession'] ?? job.category,
                            style: const TextStyle(fontSize: kFontSmall, color: AppColors.greyMedium),
                          ),
                        ],
                      ),
                    ),
                    if (job.averageRating > 0)
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, size: kIconXSmall, color: AppColors.categoryElectrical),
                          kGapW4,
                          Text(
                            '${job.averageRating.toStringAsFixed(1)} (${job.reviewCount})',
                            style: const TextStyle(fontSize: kFontSmall, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
