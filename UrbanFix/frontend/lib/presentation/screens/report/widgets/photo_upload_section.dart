import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';

class PhotoUploadSection extends StatelessWidget {
  const PhotoUploadSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          children: [

            /// Add Photo Card
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.greyLight,
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.add, color: AppColors.primary),
                  SizedBox(height: 6),
                  Text(AppStrings.addPhoto,
                      style: TextStyle(fontSize: 12))
                ],
              ),
            ),

            const SizedBox(width: 15),

            /// Preview Image
            Stack(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: AssetImage("assets/sample_road.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.greyDark,
                      shape: BoxShape.circle,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(Icons.close,
                          size: 14,
                          color: AppColors.white),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 15),

            /// Empty Placeholder
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.greyLight,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.image,
                  color: AppColors.greyMedium),
            ),
          ],
        ),

        const SizedBox(height: 10),

        const Text(
          AppStrings.photoUploadHint,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.greyMedium,
          ),
        )
      ],
    );
  }
}
