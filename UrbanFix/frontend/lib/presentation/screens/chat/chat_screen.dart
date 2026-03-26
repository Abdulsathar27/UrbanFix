import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/data/controller/chat_controller.dart';
import 'package:frontend/data/controller/user_controller.dart';
import 'package:provider/provider.dart';
import 'package:frontend/presentation/screens/chat/widgets/chat_header.dart';
import 'package:frontend/presentation/screens/chat/widgets/chat_input_bar.dart';
import 'package:frontend/presentation/screens/chat/widgets/chat_messages.dart';
import 'package:frontend/presentation/screens/chat/widgets/chat_safety_banner.dart';

class ChatScreen extends StatelessWidget {
  /// The string chatId in "userId1_userId2" format.
  final String chatId;

  const ChatScreen({super.key, required this.chatId});

  @override
  Widget build(BuildContext context) {
    final currentUserId =
        context.read<UserController>().currentUser?.id ?? '';

    return Consumer<ChatController>(
      builder: (context, controller, _) {
        // Open the chat once (when not already loaded or loading)
        if (controller.selectedChat?.chatStringId != chatId &&
            !controller.isLoading &&
            controller.errorMessage == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              context
                  .read<ChatController>()
                  .openChat(chatId, currentUserId);
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
                    onPressed: () => context
                        .read<ChatController>()
                        .openChat(chatId, currentUserId),
                    child: const Text(AppStrings.retry),
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: AppColors.lightBackground,
          body: Column(
            children: [
              const ChatHeader(),
              const Expanded(child: ChatMessages()),
              const ChatSafetyBanner(),
              ChatInputBar(chatStringId: chatId),
            ],
          ),
        );
      },
    );
  }
}
