import 'package:flutter/material.dart';
import 'package:frontend/data/controller/chat_controller.dart';
import 'package:frontend/data/models/message_model.dart';
import 'package:provider/provider.dart';
import 'package:frontend/presentation/screens/chat/widgets/day_separator.dart';
import 'package:frontend/presentation/screens/chat/widgets/message_bubble.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  // Helper method to determine if message is from current user
  // You'll need to get the current user ID from your auth controller/service
  bool _isMessageFromCurrentUser(MessageModel message, String currentUserId) {
    return message.senderId == currentUserId;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatController>(
      builder: (context, controller, child) {
        
        final chat = controller.selectedChat;

        // If no chat selected yet
        if (chat == null) {
          return const Center(
            child: Text("Select a chat to start messaging"),
          );
        }

        // Get messages from controller
        final messages = controller.messages;

        // Show empty state
        if (messages.isEmpty) {
          return const Center(
            child: Text("No messages yet"),
          );
        }

        // Get current user ID - you need to implement this based on your auth system
        // This could come from an AuthController or shared preferences
        final currentUserId = 'CURRENT_USER_ID'; // Replace with actual current user ID

        return ListView.builder(
          reverse: true,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            
            // Determine if message is from current user
            final isMine = _isMessageFromCurrentUser(message, currentUserId);
            
            // Use createdAt for time, fallback to updatedAt or current time
            final messageTime = message.createdAt ?? message.updatedAt ?? DateTime.now();

            return Column(
              children: [
                // Show day separator for first message (which is last in list due to reverse)
                // You might want to enhance this to show separator between different days
                if (index == messages.length - 1)
                  Center(
                    child: DaySeparator(
                      date: messageTime,
                    ),
                  ),
                
                const SizedBox(height: 10),
                
                MessageBubble(
                  
                  message: message.message, // Use 'message' property, not 'content'
                  isMine: isMine,
                  time: messageTime.toString(),
                ),
              ],
            );
          },
        );
      },
    );
  }
}