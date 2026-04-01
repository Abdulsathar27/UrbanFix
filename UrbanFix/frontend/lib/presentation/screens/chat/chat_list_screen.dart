import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/data/controller/chat_controller.dart';
import 'package:frontend/data/controller/user_controller.dart';
import 'package:frontend/data/models/chat_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  String _getDisplayName(BuildContext context, ChatModel chat) {
    final currentUserId =
        context.read<UserController>().currentUser?.id ?? '';

    for (final entry in chat.participantNames.entries) {
      if (entry.key != currentUserId) return entry.value;
    }

    final otherId = chat.participantIds.firstWhere(
      (id) => id != currentUserId,
      orElse: () =>
          chat.participantIds.isNotEmpty ? chat.participantIds.first : '',
    );
    return otherId.isNotEmpty ? AppStrings.unknown : AppStrings.unknown;
  }

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
        if (!controller.chatsFetched && !controller.isLoading) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) context.read<ChatController>().fetchChats();
          });
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              AppStrings.chats,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            elevation: 0,
            scrolledUnderElevation: 0,
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
    // ── Loading ────────────────────────────────────────────────
    if (controller.isLoading && controller.chats.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    // ── Error ──────────────────────────────────────────────────
    if (controller.errorMessage != null && controller.chats.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.10),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.wifi_off_rounded,
                    color: AppColors.error, size: 32),
              ),
              const SizedBox(height: 16),
              Text(
                controller.errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.error),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => context.read<ChatController>().fetchChats(),
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: const Text(AppStrings.retry),
              ),
            ],
          ),
        ),
      );
    }

    // ── Empty ──────────────────────────────────────────────────
    if (controller.chats.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.chat_bubble_outline_rounded,
                color: AppColors.primary,
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              AppStrings.noChatsYet,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Your conversations will appear here',
              style: TextStyle(fontSize: 13, color: AppColors.greyMedium),
            ),
          ],
        ),
      );
    }

    // ── List ───────────────────────────────────────────────────
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: controller.chats.length,
      separatorBuilder: (_, __) => Divider(
        height: 1,
        indent: 80,
        endIndent: 16,
        color: Theme.of(context).dividerColor,
      ),
      itemBuilder: (context, index) {
        final chat = controller.chats[index];
        final displayName = _getDisplayName(context, chat);
        final lastMessage = chat.lastMessage ?? AppStrings.noMessagesYet;
        final time =
            chat.lastMessageTime != null ? _formatTime(chat.lastMessageTime!) : '';
        final hasUnread = chat.unreadCount > 0;
        final initial =
            displayName.isNotEmpty ? displayName[0].toUpperCase() : '?';

        return InkWell(
          onTap: () => context.pushNamed(
            'chatDetails',
            pathParameters: {'chatId': chat.chatStringId},
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // ── Avatar ──────────────────────────────────────
                CircleAvatar(
                  radius: 26,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                  child: Text(
                    initial,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 14),

                // ── Name + last message ──────────────────────────
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: TextStyle(
                          fontWeight: hasUnread
                              ? FontWeight.w700
                              : FontWeight.w600,
                          fontSize: 15,
                          color:
                              Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: hasUnread
                              ? Theme.of(context).colorScheme.onSurface
                              : AppColors.greyMedium,
                          fontWeight: hasUnread
                              ? FontWeight.w500
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),

                // ── Time + unread badge ──────────────────────────
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 11,
                        color: hasUnread
                            ? AppColors.primary
                            : AppColors.greyMedium,
                        fontWeight: hasUnread
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                    if (hasUnread) ...[
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          chat.unreadCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
