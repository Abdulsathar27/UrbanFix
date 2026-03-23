import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterRedirectText extends StatelessWidget {
  const RegisterRedirectText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center,
      children: [
        const Text("Already have an account? "),
        GestureDetector(
          onTap: () {
            context.goNamed('login');
          },
          child: const Text(
            "Login",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
