import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:frontend/data/controller/user_controller.dart';
import 'package:provider/provider.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (context, controller, _) {
        return SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: controller.isLoading ? AppColors.greyLight : AppColors.error,
              foregroundColor: AppColors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: kBorderRadiusMedium,
              ),
            ),
            onPressed: controller.isLoading
                ? null
                : () => controller.handleLogout(context, controller),
            icon: controller.isLoading
                ? const SizedBox(
                    height: kHeight20,
                    width: kWidth20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.white,
                    ),
                  )
                : const Icon(Icons.logout),
            label: controller.isLoading
                ? const Text(AppStrings.loggingOut)
                : const Text(
                    AppStrings.logout,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
          ),
        );
      },
    );
  }
}
