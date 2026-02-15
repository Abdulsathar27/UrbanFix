import 'package:flutter/material.dart';
import 'package:frontend/controller/user_controller.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/validators.dart';
import '../../../core/utils/helpers.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController =
      TextEditingController();
  final TextEditingController _emailController =
      TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();
  final TextEditingController
      _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister(
      UserController controller) async {
    if (!_formKey.currentState!.validate()) return;

    await controller.register(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password:
          _passwordController.text.trim(),
    );

    if (controller.errorMessage != null) {
      Helpers.showError(
        context,
        controller.errorMessage!,
      );
    } else if (controller.isLoggedIn) {
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.home,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<UserController>(
          builder: (context, controller, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(
                  AppConstants.defaultPadding),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),

                    Text(
                      AppStrings.register,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge,
                    ),

                    const SizedBox(height: 32),

                    // Name
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: "Name",
                      ),
                      validator: (value) =>
                          Validators.validateRequired(
                              value, "Name"),
                    ),

                    const SizedBox(height: 16),

                    // Email
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: AppStrings.email,
                      ),
                      validator:
                          Validators.validateEmail,
                    ),

                    const SizedBox(height: 16),

                    // Password
                    TextFormField(
                      controller:
                          _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText:
                            AppStrings.password,
                      ),
                      validator:
                          Validators.validatePassword,
                    ),

                    const SizedBox(height: 16),

                    // Confirm Password
                    TextFormField(
                      controller:
                          _confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText:
                            AppStrings.confirmPassword,
                      ),
                      validator: (value) =>
                          Validators
                              .validateConfirmPassword(
                        value,
                        _passwordController.text,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Register Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: controller
                                .isLoading
                            ? null
                            : () =>
                                _handleRegister(
                                    controller),
                        child: controller.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child:
                                    CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color:
                                      Colors.white,
                                ),
                              )
                            : const Text(
                                AppStrings
                                    .register),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Navigate to Login
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        const Text(
                          AppStrings
                              .alreadyHaveAccount,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(
                                context);
                          },
                          child: const Text(
                            AppStrings.login,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
