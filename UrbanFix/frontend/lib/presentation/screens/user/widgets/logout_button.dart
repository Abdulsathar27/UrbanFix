import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../data/controller/user_controller.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (context, controller, _) {
        return SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade200,
              foregroundColor: Colors.black87,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: controller.isLoading
                ? null
                : () async {
                    await controller.logout();
                    if (!context.mounted) return;
                    context.go('/login');
                  },
            icon: const Icon(Icons.logout),
            label: controller.isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text(
                    "Logout",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
          ),
        );
      },
    );
  }
}