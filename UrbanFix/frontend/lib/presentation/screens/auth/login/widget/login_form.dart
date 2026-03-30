import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/core/utils/helpers.dart';
import 'package:frontend/core/utils/validators.dart';
import 'package:frontend/data/controller/user_controller.dart';
import 'login_button.dart';
import 'social_login_section.dart';
import 'register_redirect_text.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    final controller = context.read<UserController>();

    final success = await controller.submitLogin();

    if (!context.mounted) return;

    if (success) {
      // User already verified
      context.goNamed('home');
      return;
    }

    // If login failed because email not verified
    if (controller.errorMessage == "Please verify your email") {
      context.goNamed(
        'otp',
        extra: controller.emailloginController.text.trim(),
      );
      return;
    }

    // Other login errors
    Helpers.showError(context, controller.errorMessage ?? AppStrings.loginFailed);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (context, controller, _) {
        return Form(
          key: _formKey,
          child: ListView(
            children: [
              /// Email Field
              TextFormField(
                controller: controller.emailloginController,
                validator: Validators.validateEmail,
                decoration: InputDecoration(
                  hintText: AppStrings.emailOrPhoneNumber,
                  prefixIcon: const Icon(Icons.email_outlined, color: AppColors.primary),
                  filled: true,
                  fillColor: AppColors.inputFill,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: AppColors.greyMedium),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: AppColors.greyMedium,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 2.0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: AppColors.error, width: 1.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: AppColors.error, width: 2.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              /// Password Field
              TextFormField(
                controller: controller.passwordLoginController,
                obscureText: !controller.isPasswordVisible,
                validator: Validators.validatePassword,
                decoration: InputDecoration(
                  hintText: AppStrings.enterPassword,
                  prefixIcon: const Icon(Icons.lock_outline, color: AppColors.primary),
                  filled: true,
                  fillColor: AppColors.inputFill,
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: controller.togglePasswordVisibility,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: AppColors.greyMedium),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: AppColors.greyMedium,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 2.0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: AppColors.error, width: 1.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: AppColors.error, width: 2.0),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              /// Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // You can add navigation later
                  },
                  child: const Text(AppStrings.forgotPassword),
                ),
              ),

              const SizedBox(height: 20),

              /// Login Button
              LoginButton(
                isLoading: controller.isLoading,
                onPressed: () => _submit(context),
              ),

              const SizedBox(height: 30),

              const SocialLoginSection(),

              const SizedBox(height: 30),

              const RegisterRedirectText(),
            ],
          ),
        );
      },
    );
  }
}
