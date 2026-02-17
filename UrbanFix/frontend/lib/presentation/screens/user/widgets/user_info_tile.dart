import 'package:flutter/material.dart';

class UserInfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const UserInfoTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}
