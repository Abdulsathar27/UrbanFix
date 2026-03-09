import 'package:flutter/material.dart';
import 'package:frontend/data/controller/chat_controller.dart';
import 'package:provider/provider.dart';
import 'package:frontend/presentation/screens/chat/widgets/day_separator.dart';
import 'package:frontend/presentation/screens/chat/widgets/message_bubble.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  // FIX: Formats time nicely instead of calling .toString() on DateTime
  // which produces an ugly "2025-01-01 12:00:00.000" string
  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  // FIX: Checks if two messages are on different calendar days
  bool _isDifferentDay(DateTime a, DateTime b) {
    return a.year != b.year || a.month != b.month || a.day != b.day;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatController>(
      builder: (context, controller, child) {
        final chat = controller.selectedChat;

        if (chat == null) {
          return const Center(
            child: Text('Select a chat to start messaging'),
          );
        }

        // Loading messages state
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final messages = controller.messages;

        if (messages.isEmpty) {
          return const Center(
            child: Text(
              'No messages yet.\nSay hello! 👋',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          );
        }

        // FIX: currentUserId should come from your AuthController/UserController.
        // Replace this with: context.read<UserController>().currentUser?.id ?? ''
        final currentUserId = 'CURRENT_USER_ID';

        return ListView.builder(
          reverse: true, // newest messages at the bottom
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            final isMine = message.senderId == currentUserId;
            final messageTime =
                message.createdAt ?? message.updatedAt ?? DateTime.now();

            // FIX: Show day separator between messages from different days,
            // not just once at the very top. Because list is reversed,
            // "next" item in the list is actually the previous message in time.
            final bool showDaySeparator = () {
              if (index == messages.length - 1) return true; // oldest message
              final nextMessage = messages[index + 1];
              final nextTime = nextMessage.createdAt ??
                  nextMessage.updatedAt ??
                  DateTime.now();
              return _isDifferentDay(messageTime, nextTime);
            }();

            return Column(
              children: [
                if (showDaySeparator)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: DaySeparator(date: messageTime),
                  ),
                MessageBubble(
                  message: message.message,
                  isMine: isMine,
                  time: _formatTime(messageTime),
                ),
              ],
            );
          },
        );
      },
    );
  }
}