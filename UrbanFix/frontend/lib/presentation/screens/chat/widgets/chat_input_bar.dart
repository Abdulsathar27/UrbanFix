import 'package:flutter/material.dart';
import 'package:frontend/data/controller/chat_controller.dart';
import 'package:provider/provider.dart';

class ChatInputBar extends StatefulWidget {
  const ChatInputBar({super.key});

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

// FIX: ChatInputBar must be StatefulWidget.
// Placing TextEditingController inside build() of a StatelessWidget
// creates a NEW controller on every rebuild — the text field resets
// every time the Consumer above rebuilds (e.g. after each message).
class _ChatInputBarState extends State<ChatInputBar> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose(); // FIX: always dispose controllers
    super.dispose();
  }

  Future<void> _onSend(ChatController controller) async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final chat = controller.selectedChat;
    if (chat == null) return;

    _messageController.clear(); // Clear immediately for snappy UX

    await controller.sendMessage(
      chatId: chat.id,
      message: text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatController>(
      builder: (context, controller, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          color: Colors.white,
          child: Row(
            children: [
              // Attachment button
              const Icon(Icons.add, color: Colors.grey),
              const SizedBox(width: 10),

              // Input field
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    controller: _messageController,
                    textCapitalization: TextCapitalization.sentences,
                    minLines: 1,
                    maxLines: 4, // FIX: allow multiline input
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    onSubmitted: (_) => _onSend(controller),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // Send button — shows spinner while sending
              GestureDetector(
                onTap: controller.isSending ? null : () => _onSend(controller),
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: controller.isSending
                        ? Colors.grey.shade400
                        : const Color(0xFF2D6CDF),
                  ),
                  child: controller.isSending
                      ? const Padding(
                          padding: EdgeInsets.all(12),
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.send_rounded, color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}