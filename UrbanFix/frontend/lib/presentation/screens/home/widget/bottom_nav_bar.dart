import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';

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
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.greyMedium,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: AppStrings.home,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: AppStrings.bookings,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_active_rounded),
          label: AppStrings.notifications,
        ),
      ],
    );
  }
}
