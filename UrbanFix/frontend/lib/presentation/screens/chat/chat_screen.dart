import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/data/controller/chat_controller.dart';
import 'package:provider/provider.dart';
import 'package:frontend/presentation/screens/chat/widgets/chat_header.dart';
import 'package:frontend/presentation/screens/chat/widgets/chat_input_bar.dart';
import 'package:frontend/presentation/screens/chat/widgets/chat_messages.dart';
import 'package:frontend/presentation/screens/chat/widgets/chat_safety_banner.dart';

class ChatScreen extends StatelessWidget {
  final String chatId;

  const ChatScreen({super.key, required this.chatId});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatController>(
      builder: (context, controller, _) {
        // Trigger fetch after the current frame when:
        //   • this chat isn't already loaded, AND
        //   • a request isn't already in-flight, AND
        //   • there is no pending error (user must tap Retry explicitly)
        // fetchChatById clears stale state internally, so no dispose hook needed.
        if (controller.selectedChat?.id != chatId &&
            !controller.isLoading &&
            controller.errorMessage == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              context.read<ChatController>().fetchChatById(chatId);
            }
          });
        }

        if (controller.isLoading && controller.selectedChat == null) {
          return const Scaffold(
            backgroundColor: AppColors.lightBackground,
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (controller.errorMessage != null &&
            controller.selectedChat == null) {
          return Scaffold(
            backgroundColor: AppColors.lightBackground,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.error),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<ChatController>().fetchChatById(chatId),
                    child: const Text(AppStrings.retry),
                  ),
                ],
              ),
            ),
          );
        }

        return const Scaffold(
          backgroundColor: AppColors.lightBackground,
          body: Column(
            children: [
              ChatHeader(),
              Expanded(child: ChatMessages()),
              ChatSafetyBanner(),
              ChatInputBar(),
            ],
          ),
        );
      },
    );
  }
}
