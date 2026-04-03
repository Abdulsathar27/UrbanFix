import 'package:flutter/material.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:frontend/presentation/screens/chat/widgets/avatar.dart';
import 'package:frontend/presentation/screens/chat/widgets/chat_info.dart';
import 'package:frontend/presentation/screens/chat/widgets/time_and_badge.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({
    required this.displayName,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.onTap,
    super.key
  });

  final String displayName;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final VoidCallback onTap;

  bool get _hasUnread => unreadCount > 0;
  String get _initial => displayName.isNotEmpty ? displayName[0].toUpperCase() : '?';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Avatar(initial: _initial),
            const SizedBox(width: 14),
            Expanded(
              child: ChatInfo(
                displayName: displayName,
                lastMessage: lastMessage,
                hasUnread: _hasUnread,
              ),
            ),
            kGapW10,
            TimeAndBadge(time: time, unreadCount: unreadCount),
          ],
        ),
      ),
    );
  }
}