import 'package:flutter/material.dart';
import 'package:frontend/data/controller/chat_controller.dart';
import 'package:provider/provider.dart';
import 'package:frontend/presentation/screens/chat/widgets/chat_header.dart';
import 'package:frontend/presentation/screens/chat/widgets/chat_input_bar.dart';
import 'package:frontend/presentation/screens/chat/widgets/chat_messages.dart';
import 'package:frontend/presentation/screens/chat/widgets/chat_safety_banner.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;

  const ChatScreen({super.key, required this.chatId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}


class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatController>().fetchChatById(widget.chatId);
    });
  }

  @override
  void dispose() {
    context.read<ChatController>().clearMessages();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: Consumer<ChatController>(
        builder: (context, controller, child) {
          if (controller.isLoading && controller.selectedChat == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.errorMessage != null &&
              controller.selectedChat == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () =>
                        controller.fetchChatById(widget.chatId),
                    child: const Text('Retry'),
                  ),
                ],
              ),
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