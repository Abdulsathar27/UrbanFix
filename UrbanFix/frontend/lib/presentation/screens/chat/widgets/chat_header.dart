import 'package:flutter/material.dart';
import 'package:frontend/data/controller/chat_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatController>(
      builder: (context, controller, child) {
        final chat = controller.selectedChat;

        // Display participant count or a placeholder until chat loads
        final title = chat != null
            ? 'Chat (${chat.participantIds.length} participants)'
            : 'Loading...';

        return Container(
          padding: const EdgeInsets.only(
            top: 50,
            left: 4,
            right: 16,
            bottom: 16,
          ),
          color: Colors.white,
          child: Row(
            children: [
              // FIX: icon wrapped in Icon() widget
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () => context.go('/chats'),
              ),

              const CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            title,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.verified, color: Colors.blue, size: 18),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Online',
                      style: TextStyle(color: Colors.green, fontSize: 12),
                    ),
                  ],
                ),
              ),

              IconButton(
                icon: const Icon(Icons.call_outlined),
                onPressed: () {
                  // TODO: implement call
                },
              ),

              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  // TODO: implement options menu
                },
              ),
            ],
          ),
        );
      },
    );
  }
}