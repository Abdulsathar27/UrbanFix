import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/data/controller/chat_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  static String _formatTime(DateTime time) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final msgDay = DateTime(time.year, time.month, time.day);

    if (msgDay == today) {
      return '${time.hour.toString().padLeft(2, '0')}:'
          '${time.minute.toString().padLeft(2, '0')}';
    }

    final yesterday = today.subtract(const Duration(days: 1));
    if (msgDay == yesterday) return AppStrings.yesterday;

    return '${time.day}/${time.month}/${time.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatController>(
      builder: (context, controller, _) {
        // Trigger fetch after the current frame when chats have never been
        // loaded and no request is already in-flight.
        // _chatsFetched is reset to false on error, so Retry works naturally.
        if (!controller.chatsFetched && !controller.isLoading) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              context.read<ChatController>().fetchChats();
            }
          });
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.chats),
            backgroundColor: AppColors.white,
            elevation: 0,
            iconTheme:
                const IconThemeData(color: AppColors.lightTextPrimary),
            titleTextStyle: const TextStyle(
              color: AppColors.lightTextPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () => context.go('/home'),
            ),
          ),
          body: _buildBody(context, controller),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, ChatController controller) {
    if (controller.isLoading && controller.chats.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.errorMessage != null && controller.chats.isEmpty) {
      return Center(
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
              onPressed: () => context.read<ChatController>().fetchChats(),
              child: const Text(AppStrings.retry),
            ),
          ],
        ),
      );
    }

    if (controller.chats.isEmpty) {
      return const Center(
        child: Text(
          AppStrings.noChatsYet,
          style: TextStyle(color: AppColors.greyMedium),
        ),
      );
    }

    return ListView.separated(
      itemCount: controller.chats.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final chat = controller.chats[index];
        final displayName = chat.participantIds.isNotEmpty
            ? chat.participantIds.first
            : AppStrings.unknown;
        final lastMessage = chat.lastMessage ?? AppStrings.noMessagesYet;
        final time = chat.lastMessageTime != null
            ? _formatTime(chat.lastMessageTime!)
            : '';

        return ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColors.primary.withValues(alpha: 0.15),
            child: Text(
              displayName.isNotEmpty
                  ? displayName[0].toUpperCase()
                  : '?',
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            displayName,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            lastMessage,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: AppColors.greyMedium),
          ),
          trailing: chat.unreadCount > 0
              ? Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    chat.unreadCount.toString(),
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              : Text(
                  time,
                  style: const TextStyle(
                      color: AppColors.greyMedium, fontSize: 12),
                ),
          onTap: () {
            controller.setSelectedChat(chat);
            context.pushNamed(
              'chatDetails',
              pathParameters: {'chatId': chat.id},
            );
          },
        );
      },
    );
  }
}
