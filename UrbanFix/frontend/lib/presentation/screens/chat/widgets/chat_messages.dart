import 'package:flutter/material.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:frontend/data/controller/chat_controller.dart';
import 'package:frontend/data/controller/user_controller.dart';
import 'package:provider/provider.dart';
import 'package:frontend/presentation/screens/chat/widgets/day_separator.dart';
import 'package:frontend/presentation/screens/chat/widgets/message_bubble.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  bool _isDifferentDay(DateTime a, DateTime b) {
    return a.year != b.year || a.month != b.month || a.day != b.day;
  }

  @override
  Widget build(BuildContext context) {
    // Read the logged-in user's ID once — does not subscribe to rebuilds.
    final currentUserId =
        context.read<UserController>().currentUser?.id ?? '';

    return Consumer<ChatController>(
      builder: (context, controller, _) {
        final chat = controller.selectedChat;

        if (chat == null) {
          return const Center(
            child: Text('Select a chat to start messaging'),
          );
        }

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

        return ListView.builder(
          reverse: true, // newest messages at the bottom
          padding: kPaddingSymMedium,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            final isMine = message.senderId == currentUserId;
            final messageTime =
                message.createdAt ?? message.updatedAt ?? DateTime.now();

            // Show day separator between messages from different calendar days.
            // Because the list is reversed, index+1 is the previous message in time.
            final bool showDaySeparator = () {
              if (index == messages.length - 1) return true;
              final nextMessage = messages[index + 1];
              final nextTime =
                  nextMessage.createdAt ?? nextMessage.updatedAt ?? DateTime.now();
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
