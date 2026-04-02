import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:frontend/data/models/service_model.dart';
import 'package:go_router/go_router.dart';

class ServiceDetailsPage extends StatelessWidget {
  final Service service;

  const ServiceDetailsPage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(service.name),
        backgroundColor: service.color,
        foregroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            context.go('/home');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: service.color.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(service.icon, size: 48, color: service.color),
                ),
                kGapW16,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.name,
                        style: const TextStyle(
                          fontSize: kFontDisplay,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      kGapH4,
                      Text(
                        '${AppStrings.startingAt}${service.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: kFontLarge,
                          color: AppColors.greyDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              AppStrings.description,
              style: TextStyle(fontSize: kFontXLarge, fontWeight: FontWeight.w600),
            ),
            kGapH8,
            Text(
              service.description,
              style: const TextStyle(fontSize: kFontBase, height: 1.5),
            ),
            const SizedBox(height: 30),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.go('/bookings');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: service.color,
                  foregroundColor: AppColors.white,
                  padding: kPaddingVMedium,
                  shape: RoundedRectangleBorder(
                    borderRadius: kBorderRadiusMedium,
                  ),
                ),
                child: const Text(
                  AppStrings.bookThisService,
                  style: TextStyle(fontSize: kFontLarge),
                ),
              ),
            ),
            kGapH20,
          ],
        ),
      ),
    );
  }
}
