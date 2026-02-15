import 'package:flutter/material.dart';
import 'package:frontend/controller/user_controller.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/validators.dart';
import '../../../core/utils/helpers.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController =
      TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin(
      UserController controller) async {
    if (!_formKey.currentState!.validate()) return;

    await controller.login(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
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
            return Padding(
              padding: const EdgeInsets.all(
                  AppConstants.defaultPadding),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.login,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge,
                    ),
                    const SizedBox(height: 32),

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

                    const SizedBox(height: 24),

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: controller
                                .isLoading
                            ? null
                            : () =>
                                _handleLogin(
                                    controller),
                        child: controller.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child:
                                    CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color:
                                      AppColors.white,
                                ),
                              )
                            : const Text(
                                AppStrings.login),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Navigate to Register
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        const Text(
                          AppStrings
                              .dontHaveAccount,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.register,
                            );
                          },
                          child: const Text(
                            AppStrings.register,
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
