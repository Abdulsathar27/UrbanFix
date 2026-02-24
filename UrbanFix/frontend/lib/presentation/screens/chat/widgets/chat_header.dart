import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: 50, left: 16, right: 16, bottom: 16),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => context.go('/chats'),
          ),
          const CircleAvatar(
            radius: 22,
            backgroundImage: NetworkImage(
                "https://i.pravatar.cc/150?img=3"),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "John Doe",
                      style: TextStyle(
                          fontWeight:
                              FontWeight.bold,
                          fontSize: 16),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.verified,
                        color: Colors.blue,
                        size: 18),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  "ELECTRICIAN • Online",
                  style: TextStyle(
                      color: Colors.green),
                ),
              ],
            ),
          ),
          const Icon(Icons.call),
          const SizedBox(width: 16),
          const Icon(Icons.more_vert),
        ],
      ),
    );
  }
}