import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/presentation/screens/setting/widget/icon_box.dart';
import 'package:frontend/presentation/screens/setting/widget/settings_card.dart';

class ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ActionTile({
    required this.icon,
    required this.title,
    required this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        leading: IconBox(icon: icon),
        title: Text(title,
            style:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.arrow_forward_ios,
            size: 14, color: AppColors.greyMedium),
        onTap: onTap,
      ),
    );
  }
}