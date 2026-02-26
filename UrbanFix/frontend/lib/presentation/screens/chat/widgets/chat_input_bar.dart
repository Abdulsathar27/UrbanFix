import 'package:flutter/material.dart';
import 'package:frontend/data/controller/chat_controller.dart';
import 'package:provider/provider.dart';


class ChatInputBar extends StatelessWidget {
  const ChatInputBar({super.key});

  @override
  Widget build(BuildContext context) {

    // 🔹 ADDED: Text controller (local variable inside build)
    final TextEditingController messageController =
        TextEditingController();

    return Container(
      padding: const EdgeInsets.all(12),
      color: Colors.white,
      child: Row(
        children: [
          const Icon(Icons.add, color: Colors.grey),
          const SizedBox(width: 10),

          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField( // 🔹 REMOVED const
                controller: messageController, // 🔹 ADDED
                decoration: const InputDecoration(
                  hintText: "Type a message...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          // 🔹 UPDATED: Send Button wrapped with GestureDetector
          GestureDetector(
            onTap: () async {
              final text = messageController.text.trim();

              if (text.isEmpty) return;

              final controller =
                  context.read<ChatController>();

              final chat = controller.selectedChat;

              if (chat == null) return;

              // 🔹 ADDED: Call sendMessage
              await controller.sendMessage(
                chatId: chat.id,
                message: text,
              );

              // 🔹 ADDED: Clear field after sending
              messageController.clear();
            },
            child: Container(
              height: 48,
              width: 48,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF2D6CDF),
              ),
              child: const Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}