import 'package:flutter/material.dart';
import 'package:frontend/data/controller/chat_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatController>().fetchChats();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),

        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: Consumer<ChatController>(
        builder: (context, controller, child) {

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
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: controller.fetchChats,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (controller.chats.isEmpty) {
            return const Center(
              child: Text(
                'No chats yet.',
                style: TextStyle(color: Colors.grey),
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
                  : 'Unknown';
              final lastMessage = chat.lastMessage ?? 'No messages yet';
              final time = chat.lastMessageTime != null
                  ? _formatTime(chat.lastMessageTime!)
                  : '';

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFF2D6CDF).withOpacity(0.15),
                  child: Text(
                    displayName.isNotEmpty ? displayName[0].toUpperCase() : '?',
                    style: const TextStyle(
                      color: Color(0xFF2D6CDF),
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
                  style: const TextStyle(color: Colors.grey),
                ),
                trailing: chat.unreadCount > 0
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2D6CDF),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          chat.unreadCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    : Text(
                        time,
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
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
        },
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final msgDay = DateTime(time.year, time.month, time.day);

    if (msgDay == today) {
      final h = time.hour.toString().padLeft(2, '0');
      final m = time.minute.toString().padLeft(2, '0');
      return '$h:$m';
    }

    final yesterday = today.subtract(const Duration(days: 1));
    if (msgDay == yesterday) return 'Yesterday';

    return '${time.day}/${time.month}/${time.year}';
  }
}