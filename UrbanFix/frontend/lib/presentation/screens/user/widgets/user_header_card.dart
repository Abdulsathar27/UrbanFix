import 'package:flutter/material.dart';
import 'user_avatar.dart';

class UserHeaderCard extends StatelessWidget {
  final String name;
  final String email;
  final String? imageUrl;

  const UserHeaderCard({
    super.key,
    required this.name,
    required this.email,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserAvatar(imageUrl: imageUrl),
        const SizedBox(height: 16),
        Text(
          name,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          email,
          style: Theme.of(context)
              .textTheme
              .bodyMedium,
        ),
      ],
    );
  }
}
