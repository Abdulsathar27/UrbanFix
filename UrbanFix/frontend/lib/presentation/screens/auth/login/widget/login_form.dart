import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:frontend/controller/user_controller.dart';
import 'package:frontend/core/utils/helpers.dart';
import 'package:frontend/core/utils/validators.dart';
import 'login_button.dart';
import 'social_login_section.dart';
import 'register_redirect_text.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<UserController>().clearState();
    });
  }

  Future<void> _submit(
    dynamic emailController,
    dynamic passwordController,
  ) async {
    if (!_formKey.currentState!.validate()) return;

    final controller = context.read<UserController>();
    final email = emailController.text.trim();

    await controller.login(
      email: email,
      password: passwordController.text.trim(),
    );

    if (!mounted) return;

    if (controller.errorMessage != null) {
      final error = controller.errorMessage!.toLowerCase();
      if (error.contains("verify your email")) {
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.otp,
          arguments: email,
        );
        return;
      }
      Helpers.showError(context, controller.errorMessage!);
    } else {
      controller.clearState();
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (context, controller, _) {
        return Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: controller.emailController,
                validator: Validators.validateEmail,
                decoration: const InputDecoration(
                  hintText: AppStrings.emailOrPhoneNumber,
                  prefixIcon: Icon(Icons.person),
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: controller.passwordController,
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
                ),
              ),

              const SizedBox(height: 8),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(AppStrings.forgotPassword),
                ),
              ),

              const SizedBox(height: 20),

              LoginButton(
                isLoading: controller.isLoading,
                onPressed: () => _submit(
                  controller.emailController,
                  controller.passwordController,
                ),
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
