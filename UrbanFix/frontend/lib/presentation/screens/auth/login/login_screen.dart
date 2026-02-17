import 'package:flutter/material.dart';
import 'package:frontend/controller/user_controller.dart';
import 'package:frontend/presentation/screens/auth/login/widget/login_body.dart';
import 'package:frontend/routes/app_routes.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserController>(
        builder: (context, controller, _) {

          // Navigation based on state
          if (controller.isLoggedIn) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(
                  context, AppRoutes.home);
              controller.clearState();
            });
          }

          return LoginBody();
        },
      ),
    );
  }
}
