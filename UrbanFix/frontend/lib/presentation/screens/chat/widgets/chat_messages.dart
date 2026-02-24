import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/chat/widgets/day_separator.dart';
import 'package:frontend/presentation/screens/chat/widgets/message_bubble.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding:
          const EdgeInsets.symmetric(horizontal: 16),
      children: const [
        SizedBox(height: 20),
        Center(
          child: DaySeparator(),
        ),
        SizedBox(height: 20),
        MessageBubble(
          message:
              "Hi, I can be there at 2 PM today to look at the wiring.",
          isMine: false,
          time: "11:02 AM",
        ),
        MessageBubble(
          message:
              "That works for me. Do I need to buy any supplies?",
          isMine: true,
          time: "11:05 AM",
        ),
        MessageBubble(
          message:
              "No, I have everything needed. Could you please send a photo of the fuse box so I can prepare the right components?",
          isMine: false,
          time: "11:06 AM",
        ),
        SizedBox(height: 20),
      ],
    );
  }
}