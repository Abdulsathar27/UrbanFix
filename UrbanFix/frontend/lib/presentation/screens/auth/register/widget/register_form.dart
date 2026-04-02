import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/auth/register/widget/register_confirm_password_field.dart';
import 'package:frontend/presentation/screens/auth/register/widget/register_email_field.dart';
import 'package:frontend/presentation/screens/auth/register/widget/register_name_field.dart';
import 'package:frontend/presentation/screens/auth/register/widget/register_password_field.dart';
import 'package:frontend/presentation/screens/auth/register/widget/register_phone_field.dart';
import 'package:frontend/presentation/screens/auth/register/widget/register_terms_checkbox.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:frontend/data/controller/user_controller.dart';
import 'package:frontend/core/utils/helpers.dart';
import 'register_button.dart';
import 'register_redirect_text.dart';

class RegisterForm extends StatelessWidget {
  RegisterForm({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _submit(BuildContext context) async {
    final controller = context.read<UserController>();
    final success = await controller.submitRegistration();
    if (!context.mounted) return;
    if (!success) {
      Helpers.showError(context, controller.errorMessage ?? "Registration failed");
      return;
    }
    context.goNamed('home');
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
                RegisterNameField(controller: controller.nameController),
                kGapH16,
                RegisterEmailField(controller: controller.emailController),
                kGapH16,
                RegisterPhoneField(controller: controller.phoneController),
                kGapH16,
                RegisterPasswordField(
                  controller: controller.passwordController,
                  isVisible: controller.isRegisterPasswordVisible,
                  onToggle: controller.toggleRegisterPassword,
                ),
                kGapH16,
                RegisterConfirmPasswordField(
                  controller: controller.confirmPasswordController,
                  isVisible: controller.isConfirmPasswordVisible,
                  onToggle: controller.toggleConfirmPassword,
                ),
                kGapH20,
                RegisterTermsCheckbox(
                  value: controller.agreeTerms,
                  onChanged: controller.toggleAgreeTerms,
                ),
                kGapH20,
                RegisterButton(isLoading: controller.isLoading, onPressed: () => _submit(context)),
                kGapH20,
                const RegisterRedirectText(),
              ],
            ),
          ),
        );
      },
    );
  }
}
