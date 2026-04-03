import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';

class ChatInfo extends StatelessWidget {
  const ChatInfo({
    required this.displayName,
    required this.lastMessage,
    required this.hasUnread,
    super.key
  });

  final String displayName;
  final String lastMessage;
  final bool hasUnread;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          displayName,
          style: TextStyle(
            fontWeight: hasUnread ? FontWeight.w700 : FontWeight.w600,
            fontSize: 15,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          lastMessage,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 13,
            color: hasUnread ? colorScheme.onSurface : AppColors.greyMedium,
            fontWeight: hasUnread ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}