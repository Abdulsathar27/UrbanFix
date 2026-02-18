import 'package:flutter/material.dart';
import 'package:frontend/data/controller/chat_controller.dart';
import 'package:frontend/data/controller/message_controller.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_constants.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() =>
      _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController =
      TextEditingController();

  late String chatId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    chatId = ModalRoute.of(context)!
        .settings
        .arguments as String;

    Future.microtask(() {
      context
          .read<MessageController>()
          .fetchMessages(chatId);

      context
          .read<ChatController>()
          .markChatAsRead(chatId);
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isEmpty)
      return;

    await context
        .read<MessageController>()
        .sendMessage(
          chatId: chatId,
          receiverId: "receiver_id", // Replace dynamically
          message: _messageController.text.trim(),
        );

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<MessageController>(
              builder: (context, controller, _) {
                if (controller.isLoading) {
                  return const Center(
                    child:
                        CircularProgressIndicator(),
                  );
                }

                if (controller.messages.isEmpty) {
                  return const Center(
                    child:
                        Text("No messages yet"),
                  );
                }

                return Padding(
                  padding:
                      const EdgeInsets.all(
                          AppConstants
                              .defaultPadding),
                  child: ListView.builder(
                    itemCount:
                        controller.messages
                            .length,
                    itemBuilder:
                        (context, index) {
                      final message =
                          controller
                                  .messages[
                              index];

                      final isMine =
                          message.senderId ==
                              "current_user_id"; 
                      // Replace dynamically

                      return Align(
                        alignment: isMine
                            ? Alignment
                                .centerRight
                            : Alignment
                                .centerLeft,
                        child: Container(
                          margin:
                              const EdgeInsets
                                  .symmetric(
                                      vertical:
                                          4),
                          padding:
                              const EdgeInsets
                                  .all(12),
                          decoration:
                              BoxDecoration(
                            color: isMine
                                ? Colors.blue
                                : Colors.grey
                                    .shade300,
                            borderRadius:
                                BorderRadius
                                    .circular(
                                        12),
                          ),
                          child: Text(
                            message.message,
                            style:
                                TextStyle(
                              color: isMine
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),

          // Input Field
          Padding(
            padding: const EdgeInsets.all(
                AppConstants.defaultPadding),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller:
                        _messageController,
                    decoration:
                        const InputDecoration(
                      hintText:
                          "Type a message...",
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon:
                      const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
