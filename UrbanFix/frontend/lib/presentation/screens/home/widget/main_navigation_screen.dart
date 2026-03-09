import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:frontend/data/controller/user_controller.dart';
import 'package:frontend/presentation/screens/home/widget/bottom_nav_bar.dart';

class MainNavigationScreen extends StatelessWidget {
  final Widget child;

  const MainNavigationScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (context, controller, _) {
        return Scaffold(
          body: child, 
          bottomNavigationBar: BottomNavBar(
            currentIndex: controller.currentIndex,
            onTap: (index) {
              controller.changeTab(index);
              switch (index) {
                case 0:
                  context.go('/home');
                  break;
                case 1:
                  context.go('/bookings');
                  break;
                case 2:
                  context.go('/notifications');
                  break;
              }
            },
          ),
        );
      },
    );
  }
}
