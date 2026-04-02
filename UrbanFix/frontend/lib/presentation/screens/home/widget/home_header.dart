import 'package:flutter/material.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import '../../../../data/controller/location_controller.dart';
import '../../../../data/controller/user_controller.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserController, LocationController>(
      builder: (context, userController, locationController, _) {
        final user = userController.currentUser;

        return Padding(
          padding: kPaddingAllMedium,
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.go('/profile');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.warning, AppColors.warning],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 24,
                          backgroundColor: Theme.of(context).colorScheme.surface,
                          child: Text(
                            user != null && user.name.isNotEmpty
                                ? user.name[0].toUpperCase()
                                : AppStrings.defaultInitial,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.warning,
                            ),
                          ),
                        ),
                      ),
                    ),
                    kGapW12,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            AppStrings.welcomeBack,
                            style: TextStyle(color: AppColors.greyMedium),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  user?.name ?? AppStrings.defaultUser,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Real-time location chip
              TweenAnimationBuilder(
                duration: const Duration(seconds: 2),
                tween: Tween<double>(begin: 0, end: 1),
                builder: (context, double value, child) {
                  return Transform.translate(
                    offset: Offset(0, 5 * value),
                    child: child,
                  );
                },
                child: GestureDetector(
                  onTap: locationController.fetchLocation,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.info.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.info.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        locationController.isLoading
                            ? const SizedBox(
                                width: 14,
                                height: 14,
                                child: CircularProgressIndicator(
                                  strokeWidth: 1.5,
                                  color: AppColors.info,
                                ),
                              )
                            : const Icon(
                                Icons.navigation,
                                color: AppColors.info,
                                size: 16,
                              ),
                        kGapW4,
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: kWidth100),
                          child: Text(
                            locationController.locationLabel,
                            style: const TextStyle(
                              color: AppColors.info,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
