import 'package:flutter/material.dart';

class ChatInputBar extends StatelessWidget {
  const ChatInputBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.all(12),
      color: Colors.white,
      child: Row(
        children: [
          const Icon(Icons.add,
              color: Colors.grey),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(
                      horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey
                    .shade200,
                borderRadius:
                    BorderRadius.circular(
                        30),
              ),
              child: const TextField(
                decoration:
                    InputDecoration(
                  hintText:
                      "Type a message...",
                  border:
                      InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            height: 48,
            width: 48,
            decoration:
                const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF2D6CDF),
            ),
            child: const Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}