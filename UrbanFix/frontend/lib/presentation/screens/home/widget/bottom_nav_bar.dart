// OLD CODE:
// class BottomNavBar extends StatelessWidget {
//   final int currentIndex;
//   final Function(int) onTap;
//
//   const BottomNavBar({
//     super.key,
//     required this.currentIndex,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: currentIndex,
//       onTap: (index) {
//         onTap(index); // Update controller state
//         
//         // Navigate using GoRouter based on index
//         switch (index) {
//           case 0:
//             context.go('/home');
//             break;
//           case 1:
//             context.go('/bookings'); // You'll need to create this route
//             break;
//           case 2:
//             context.go('/chats'); // Navigate to chat list
//             break;
//           case 3:
//             context.go('/profile');
//             break;
//         }
//       },
//       type: BottomNavigationBarType.fixed,
//       selectedItemColor: Colors.blue,
//       unselectedItemColor: Colors.grey,
//       items: const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: "Home",
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.calendar_today),
//           label: "Bookings",
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.chat_bubble),
//           label: "Chats",
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.person),
//           label: "Profile",
//         ),
//       ],
//     );
//   }
// }

// NEW CODE:
import 'package:flutter/material.dart';


class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap, // The navigation logic is now in MainNavigationScreen
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: "Bookings",
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.chat_bubble),
        //   label: "Chats",
        // ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
    );
  }
}