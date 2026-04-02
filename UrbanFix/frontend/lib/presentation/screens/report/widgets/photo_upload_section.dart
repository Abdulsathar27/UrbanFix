import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/core/constants/appsize_constants.dart';

class PhotoUploadSection extends StatelessWidget {
  const PhotoUploadSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          children: [


            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: kBorderRadiusLarge,
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
                      style: TextStyle(fontSize: kFontSmall))
                ],
              ),
            ),

            const SizedBox(width: 15),


            Stack(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: kBorderRadiusLarge,
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


            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.greyLight,
                borderRadius: kBorderRadiusLarge,
              ),
              child: const Icon(Icons.image,
                  color: AppColors.greyMedium),
            ),
          ],
        ),

        kGapH10,

        const Text(
          AppStrings.photoUploadHint,
          style: TextStyle(
            fontSize: kFontSmall,
            color: AppColors.greyMedium,
          ),
        )
      ],
    );
  }
}
