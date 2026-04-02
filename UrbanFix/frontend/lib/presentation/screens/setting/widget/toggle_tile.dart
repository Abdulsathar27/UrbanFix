import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:frontend/presentation/screens/setting/widget/icon_box.dart';
import 'package:frontend/presentation/screens/setting/widget/settings_card.dart';

class ToggleTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const ToggleTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      child: SwitchListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        secondary: IconBox(icon: icon),
        title: Text(title,
            style:
                const TextStyle(fontSize: kFontMedium, fontWeight: FontWeight.w500)),
        value: value,
        onChanged: onChanged,
        activeThumbColor: AppColors.primary,
      ),
    );
  }
}
