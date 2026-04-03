import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:frontend/data/controller/chat_controller.dart';
import 'package:frontend/data/controller/user_controller.dart';
import 'package:frontend/data/models/chat_model.dart';
import 'package:frontend/presentation/screens/chat/widgets/chat_empty_state.dart';
import 'package:frontend/presentation/screens/chat/widgets/chat_error_state.dart';
import 'package:frontend/presentation/screens/chat/widgets/chat_tile.dart';
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
    if (controller.isLoading && controller.chats.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.errorMessage != null && controller.chats.isEmpty) {
      return ChatErrorState(
        message: controller.errorMessage!,
        onRetry: () => context.read<ChatController>().fetchChats(),
      );
    }

    if (controller.chats.isEmpty) {
      return const ChatEmptyState();
    }

    return ListView.separated(
      padding: kPaddingVSmall,
      itemCount: controller.chats.length,
      separatorBuilder: (_, __) => Divider(
        height: 1,
        indent: 80,
        endIndent: 16,
        color: Theme.of(context).dividerColor,
      ),
      itemBuilder: (context, index) {
        final chat = controller.chats[index];
        return ChatTile(
          displayName: _getDisplayName(context, chat),
          lastMessage: chat.lastMessage ?? AppStrings.noMessagesYet,
          time: chat.lastMessageTime != null
              ? _formatTime(chat.lastMessageTime!)
              : '',
          unreadCount: chat.unreadCount,
          onTap: () => context.pushNamed(
            'chatDetails',
            pathParameters: {'chatId': chat.chatStringId},
          ),
        );
      },
    );
  }
}














