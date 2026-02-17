import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/controller/user_controller.dart';
import 'package:frontend/core/utils/helpers.dart';
import 'package:frontend/presentation/screens/auth/register/widget/register_confirm_password_field.dart';
import 'package:frontend/presentation/screens/auth/register/widget/register_email_field.dart';
import 'package:frontend/presentation/screens/auth/register/widget/register_name_field.dart';
import 'package:frontend/presentation/screens/auth/register/widget/register_password_field.dart';
import 'package:frontend/presentation/screens/auth/register/widget/register_phone_field.dart';
import 'package:frontend/presentation/screens/auth/register/widget/register_terms_checkbox.dart';
import 'package:frontend/routes/app_routes.dart';
import 'register_button.dart';
import 'register_redirect_text.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final controller = context.read<UserController>();

    if (!_formKey.currentState!.validate()) return;

    if (!controller.agreeTerms) {
      Helpers.showError(context, "Please accept terms");
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      Helpers.showError(context, "Passwords do not match");
      return;
    }

    await controller.register(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      password: _passwordController.text.trim(),
    );

    if (controller.errorMessage != null && mounted) {
      Helpers.showError(context, controller.errorMessage!);
      return;
    }

    if (!mounted) return;
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.otp,
      arguments: _emailController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [

            /// Static Fields (No Consumer Needed)
            RegisterNameField(controller: _nameController),

            const SizedBox(height: 16),

            RegisterEmailField(controller: _emailController),

            const SizedBox(height: 16),

            RegisterPhoneField(controller: _phoneController),

            const SizedBox(height: 16),

            /// Password Field (Reactive)
            Consumer<UserController>(
              builder: (context, controller, _) {
                return RegisterPasswordField(
                  controller: _passwordController,
                  isVisible: controller.isRegisterPasswordVisible,
                  onToggle: controller.toggleRegisterPassword,
                );
              },
            ),

            const SizedBox(height: 16),

            /// Confirm Password Field (Reactive)
            Consumer<UserController>(
              builder: (context, controller, _) {
                return RegisterConfirmPasswordField(
                  controller: _confirmPasswordController,
                  isVisible: controller.isConfirmPasswordVisible,
                  onToggle: controller.toggleConfirmPassword,
                );
              },
            ),

            const SizedBox(height: 20),

            /// Terms Checkbox (Reactive)
            Consumer<UserController>(
              builder: (context, controller, _) {
                return RegisterTermsCheckbox(
                  value: controller.agreeTerms,
                  onChanged: controller.toggleAgreeTerms,
                );
              },
            ),

            const SizedBox(height: 20),

            /// Register Button (Reactive)
            Consumer<UserController>(
              builder: (context, controller, _) {
                return RegisterButton(
                  isLoading: controller.isLoading,
                  onPressed: _submit,
                );
              },
            ),

            const SizedBox(height: 20),

            const RegisterRedirectText(),
          ],
        ),
      ),
    );
  }
}
