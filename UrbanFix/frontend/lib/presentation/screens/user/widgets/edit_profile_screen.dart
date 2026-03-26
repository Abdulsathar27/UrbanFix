import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/data/controller/user_controller.dart';
import 'package:frontend/presentation/screens/user/widgets/primary_button.dart';
import 'package:frontend/presentation/screens/user/widgets/profile_text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  // static final so the key lives for the entire app session.
  // Safe for a single-instance screen like this.
  static final _formKey = GlobalKey<FormState>();

  void _populateOnce(BuildContext context) {
    final ctrl = context.read<UserController>();
    if (!ctrl.editProfileReady) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) context.read<UserController>().prepareEditProfile();
      });
    }
  }

  Future<void> _submit(BuildContext context, UserController controller) async {
    if (!_formKey.currentState!.validate()) return;

    final success = await controller.updateProfile(
      name: controller.nameController.text.trim(),
      phone: controller.phoneController.text.trim(),
    );

    if (!context.mounted) return;

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            controller.errorMessage ?? AppStrings.failedToUpdateProfile,
          ),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile updated successfully'),
        backgroundColor: AppColors.success,
      ),
    );

    context.go('/profile');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (context, controller, _) {
        final user = controller.currentUser;

        if (user == null) {
          return const Scaffold(
            body: Center(child: Text(AppStrings.userNotFound)),
          );
        }

        // Pre-populate form controllers once per screen entry.
        // Guard prevents re-running on every rebuild → typing works correctly.
        _populateOnce(context);

        return Scaffold(
          backgroundColor: AppColors.lightBackground,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: AppColors.lightTextPrimary),
              onPressed: () =>
                  context.canPop() ? context.pop() : context.go('/profile'),
            ),
            title: const Text(
              AppStrings.editProfile,
              style: TextStyle(
                color: AppColors.lightTextPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Avatar
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 52,
                        backgroundColor: AppColors.primaryLight,
                        backgroundImage: user.profileImage != null
                            ? NetworkImage(user.profileImage!)
                            : null,
                        child: user.profileImage == null
                            ? const Icon(Icons.person,
                                size: 52, color: AppColors.primary)
                            : null,
                      ),
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.white, width: 2),
                        ),
                        child: const Icon(Icons.camera_alt,
                            size: 16, color: AppColors.white),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  /// Email (read-only — cannot be changed via this endpoint)
                  Text(
                    user.email,
                    style: const TextStyle(
                      color: AppColors.greyMedium,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 32),

                  /// Name field
                  ProfileTextField(
                    controller: controller.nameController,
                    label: AppStrings.fullName,
                    icon: Icons.person_outline,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Full name is required';
                      }
                      if (value.trim().length < 2) {
                        return 'Name must be at least 2 characters';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  /// Phone field
                  ProfileTextField(
                    controller: controller.phoneController,
                    label: AppStrings.phoneNumber,
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Phone number is required';
                      }
                      // Accept 10-digit numbers or numbers with country code
                      final digits = value.replaceAll(RegExp(r'\D'), '');
                      if (digits.length < 10) {
                        return 'Enter a valid phone number';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 40),

                  /// Save button
                  PrimaryButton(
                    text: AppStrings.saveChanges,
                    isLoading: controller.isLoading,
                    onPressed: () => _submit(context, controller),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
