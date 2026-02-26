import 'package:flutter/material.dart';
import 'package:frontend/data/controller/chat_controller.dart';
import 'package:provider/provider.dart'; // 🔹 ADDED
import 'package:frontend/presentation/screens/chat/widgets/chat_header.dart';
import 'package:frontend/presentation/screens/chat/widgets/chat_input_bar.dart';
import 'package:frontend/presentation/screens/chat/widgets/chat_messages.dart';
import 'package:frontend/presentation/screens/chat/widgets/chat_safety_banner.dart';


class ChatScreen extends StatelessWidget {
  final String chatId;

  const ChatScreen({super.key, required this.chatId});

  @override
  Widget build(BuildContext context) {
    // 🔹 ADDED: Fetch chat when screen builds
    Future.microtask(() {
      context.read<ChatController>().fetchChatById(chatId);
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: Consumer<ChatController>(
        builder: (context, controller, child) {
          
          // 🔹 ADDED: Loading State
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // 🔹 ADDED: Error State
          if (controller.errorMessage != null) {
            return Center(
              child: Text(controller.errorMessage!),
            );
          }

          return Column(
            children: [
              const ChatHeader(),
              const Expanded(child: ChatMessages()),
              const ChatSafetyBanner(),
              const ChatInputBar(),
            ],
          );
        },
      ),
    );
  }
}