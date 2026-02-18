import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/auth/register/widget/register_confirm_password_field.dart';
import 'package:frontend/presentation/screens/auth/register/widget/register_email_field.dart';
import 'package:frontend/presentation/screens/auth/register/widget/register_name_field.dart';
import 'package:frontend/presentation/screens/auth/register/widget/register_password_field.dart';
import 'package:frontend/presentation/screens/auth/register/widget/register_phone_field.dart';
import 'package:frontend/presentation/screens/auth/register/widget/register_terms_checkbox.dart';
import 'package:provider/provider.dart';
import 'package:frontend/data/controller/user_controller.dart';
import 'package:frontend/core/utils/helpers.dart';
import 'package:frontend/routes/app_routes.dart';
import 'register_button.dart';
import 'register_redirect_text.dart';

class RegisterForm extends StatelessWidget {
  RegisterForm({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _submit(BuildContext context) async {
    final controller = context.read<UserController>();

    if (!_formKey.currentState!.validate()) return;

    if (!controller.agreeTerms) {
      Helpers.showError(context, "Please accept terms");
      return;
    }

    if (controller.passwordController.text !=
        controller.confirmPasswordController.text) {
      Helpers.showError(context, "Passwords do not match");
      return;
    }

    final success = await controller.register(
      name: controller.nameController.text.trim(),
      email: controller.emailController.text.trim(),
      phone: controller.phoneController.text.trim(),
      password: controller.passwordController.text.trim(),
    );

    if (!success) {
      Helpers.showError(
        context,
        controller.errorMessage ?? "Registration failed",
      );
      return;
    }

    Navigator.pushReplacementNamed(
      context,
      AppRoutes.login,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (context, controller, _) {
        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [

                /// Name
                RegisterNameField(
                  controller: controller.nameController,
                ),

                const SizedBox(height: 16),

                /// Email
                RegisterEmailField(
                  controller: controller.emailController,
                ),

                const SizedBox(height: 16),

                /// Phone
                RegisterPhoneField(
                  controller: controller.phoneController,
                ),

                const SizedBox(height: 16),

                /// Password
                RegisterPasswordField(
                  controller: controller.passwordController,
                  isVisible: controller.isRegisterPasswordVisible,
                  onToggle: controller.toggleRegisterPassword,
                ),

                const SizedBox(height: 16),

                /// Confirm Password
                RegisterConfirmPasswordField(
                  controller: controller.confirmPasswordController,
                  isVisible: controller.isConfirmPasswordVisible,
                  onToggle: controller.toggleConfirmPassword,
                ),

                const SizedBox(height: 20),

                /// Terms Checkbox
                RegisterTermsCheckbox(
                  value: controller.agreeTerms,
                  onChanged: controller.toggleAgreeTerms,
                ),

                const SizedBox(height: 20),

                /// Register Button
                RegisterButton(
                  isLoading: controller.isLoading,
                  onPressed: () => _submit(context),
                ),

                const SizedBox(height: 20),

                const RegisterRedirectText(),
              ],
            ),
          ),
        );
      },
    );
  }
}
