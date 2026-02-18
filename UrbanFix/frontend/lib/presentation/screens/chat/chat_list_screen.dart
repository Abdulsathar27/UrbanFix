import 'package:flutter/material.dart';
import 'package:frontend/data/controller/chat_controller.dart';
import 'package:frontend/routes/app_routes.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_constants.dart';


class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() =>
      _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<ChatController>().fetchChats();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chats"),
      ),
      body: Consumer<ChatController>(
        builder: (context, controller, _) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (controller.chats.isEmpty) {
            return const Center(
              child: Text("No chats available"),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(
                AppConstants.defaultPadding),
            child: ListView.builder(
              itemCount: controller.chats.length,
              itemBuilder: (context, index) {
                final chat =
                    controller.chats[index];

                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.chat),
                    ),
                    title: Text(
                        "Job: ${chat.jobId}"),
                    subtitle: Text(
                      chat.lastMessage ??
                          "No messages yet",
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                    ),
                    trailing: chat.unreadCount > 0
                        ? Container(
                            padding:
                                const EdgeInsets
                                    .all(6),
                            decoration:
                                const BoxDecoration(
                              color: Colors.red,
                              shape:
                                  BoxShape.circle,
                            ),
                            child: Text(
                              chat.unreadCount
                                  .toString(),
                              style:
                                  const TextStyle(
                                color:
                                    Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          )
                        : null,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.chatDetails,
                        arguments: chat.id,
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
