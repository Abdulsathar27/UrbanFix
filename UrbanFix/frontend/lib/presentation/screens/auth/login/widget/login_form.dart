import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
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
    Helpers.showError(context, controller.errorMessage ?? "Login failed");
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
                  prefixIcon: const Icon(Icons.person),
                  // Add a border that is always visible
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  // Style when the field is enabled but not focused
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  // Style when the field is focused
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  // Style when there’s an error
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.red, width: 1.0),
                  ),
                  // Style when focused and in error state
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.red, width: 2.0),
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
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: controller.togglePasswordVisibility,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  // Style when the field is enabled but not focused
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  // Style when the field is focused
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  // Style when there’s an error
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.red, width: 1.0),
                  ),
                  // Style when focused and in error state
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.red, width: 2.0),
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
