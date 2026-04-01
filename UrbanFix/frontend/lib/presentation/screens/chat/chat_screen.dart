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
  final String chatId;

  const ChatScreen({super.key, required this.chatId});

  @override
  Widget build(BuildContext context) {
    final currentUserId =
        context.read<UserController>().currentUser?.id ?? '';

    return Consumer<ChatController>(
      builder: (context, controller, _) {
        // Trigger openChat once when not yet loaded
        if (controller.selectedChat?.chatStringId != chatId &&
            !controller.isLoading &&
            controller.errorMessage == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              context.read<ChatController>().openChat(chatId, currentUserId);
            }
          });
        }

        // ── Loading ──────────────────────────────────────────────
        if (controller.isLoading && controller.selectedChat == null) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(color: AppColors.primary),
                  const SizedBox(height: 16),
                  Text(
                    'Opening chat…',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // ── Error ────────────────────────────────────────────────
        if (controller.errorMessage != null &&
            controller.selectedChat == null) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: AppColors.error.withValues(alpha: 0.10),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.wifi_off_rounded,
                        color: AppColors.error,
                        size: 36,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Failed to load chat',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      controller.errorMessage!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => context
                          .read<ChatController>()
                          .openChat(chatId, currentUserId),
                      icon: const Icon(Icons.refresh_rounded, size: 18),
                      label: const Text(AppStrings.retry),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        // ── Chat ─────────────────────────────────────────────────
        return Scaffold(
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
