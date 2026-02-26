// OLD CODE:
// class MainNavigationScreen extends StatelessWidget {
//   final int initialIndex;
//
//   const MainNavigationScreen({
//     super.key,
//     this.initialIndex = 0,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<UserController>(
//       builder: (context, controller, child) {
//         return Scaffold(
//           body: IndexedStack(
//             index: controller.currentIndex,
//             children: const [
//               HomeScreen(),
//               BookingScreen(),
//               ChatListScreen(),
//               ProfileScreen(),
//             ],
//           ),
//           bottomNavigationBar: BottomNavBar(
//             currentIndex: controller.currentIndex,
//             onTap: controller.changeTab,
//           ),
//         );
//       },
//     );
//   }
// }

// NEW CODE:
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
          body: child, // This will show the current tab's content
          bottomNavigationBar: BottomNavBar(
            currentIndex: controller.currentIndex,
            onTap: (index) {
              controller.changeTab(index);

              // Navigate using GoRouter based on index
              switch (index) {
                case 0:
                  context.go('/home');
                  break;
                case 1:
                  context.go('/bookings');
                  break;
                case 2:
                  context.go('/profile');
                  break;
                // case 3:
                //   context.go('/chats');
                //   break;
              }
            },
          ),
        );
      },
    );
  }
}
