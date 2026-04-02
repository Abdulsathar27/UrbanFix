import 'package:flutter/material.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:frontend/presentation/screens/setting/widget/action_tile.dart';
import 'package:frontend/presentation/screens/setting/widget/info_tile.dart';
import 'package:frontend/presentation/screens/setting/widget/section_label.dart';
import 'package:frontend/presentation/screens/setting/widget/toggle_tile.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/controller/theme_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/profile'),
        ),
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          SectionLabel('Appearance'),
          Consumer<ThemeController>(
            builder: (context, theme, _) => ToggleTile(
              icon: Icons.dark_mode_outlined,
              title: 'Dark Mode',
              value: theme.isDarkMode,
              onChanged: (_) => theme.toggleTheme(),
            ),
          ),

          kGapH24,
          SectionLabel('Notifications'),
          ToggleTile(
            icon: Icons.notifications_outlined,
            title: 'Push Notifications',
            value: true,
            onChanged: (_) {},
          ),
          ToggleTile(
            icon: Icons.email_outlined,
            title: 'Email Notifications',
            value: false,
            onChanged: (_) {},
          ),

          kGapH24,
          SectionLabel('About'),
          InfoTile(
            icon: Icons.info_outline,
            title: 'App Version',
            trailing: const Text(
              '1.0.0',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.greyMedium,
              ),
            ),
          ),
          ActionTile(
            icon: Icons.shield_outlined,
            title: 'Privacy Policy',
            onTap: () {},
          ),
          ActionTile(
            icon: Icons.description_outlined,
            title: 'Terms of Service',
            onTap: () {},
          ),

          kGapH24,
          SectionLabel('Support'),
          ActionTile(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () {},
          ),
          ActionTile(
            icon: Icons.star_outline,
            title: 'Rate the App',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
