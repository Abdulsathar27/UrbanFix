import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/setting/widget/icon_box.dart';
import 'package:frontend/presentation/screens/setting/widget/settings_card.dart';

class InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget trailing;

  const InfoTile({
    required this.icon,
    required this.title,
    required this.trailing,
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
        trailing: trailing,
      ),
    );
  }
}