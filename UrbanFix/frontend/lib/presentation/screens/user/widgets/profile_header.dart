import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/appsize_constants.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String? imageUrl;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: AppColors.warning.withValues(alpha: 0.3),
              backgroundImage:
                  imageUrl != null ? NetworkImage(imageUrl!) : null,
              child: imageUrl == null
                  ? const Icon(Icons.person, size: 60)
                  : null,
            ),

            /// Green Online Dot
            Container(
              height: 22,
              width: 22,
              decoration: BoxDecoration(
                color: AppColors.success,
                shape: BoxShape.circle,
                border: Border.all(color: Theme.of(context).colorScheme.surface, width: 3),
              ),
            ),
          ],
        ),

        kGapH20,

        Text(
          name,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 5),

        Text(
          email,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: AppColors.greyMedium),
        ),
      ],
    );
  }
}
