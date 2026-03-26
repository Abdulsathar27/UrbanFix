import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/data/controller/chat_controller.dart';
import 'package:frontend/data/controller/user_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatController>(
      builder: (context, controller, child) {
        final chat = controller.selectedChat;
        final currentUserId =
            context.read<UserController>().currentUser?.id ?? '';

        String title = AppStrings.loading;
        if (chat != null) {
          // Show the other participant's name from the populated members map
          title = chat.participantNames.entries
              .firstWhere(
                (e) => e.key != currentUserId,
                orElse: () => const MapEntry('', AppStrings.unknown),
              )
              .value;
          if (title.isEmpty) title = AppStrings.unknown;
        }

        return Container(
          padding: const EdgeInsets.only(
            top: 50,
            left: 4,
            right: 16,
            bottom: 16,
          ),
          color: AppColors.white,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () {
                  controller.clearMessages();
                  context.go('/chats');
                },
              ),
              const CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.greyLight,
                child: Icon(Icons.person, color: AppColors.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.call_outlined),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}
