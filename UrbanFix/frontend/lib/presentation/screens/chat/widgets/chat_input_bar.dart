import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/data/controller/chat_controller.dart';
import 'package:frontend/data/controller/user_controller.dart';
import 'package:provider/provider.dart';

class ChatInputBar extends StatelessWidget {
  final String chatStringId;

  const ChatInputBar({super.key, required this.chatStringId});

  @override
  Widget build(BuildContext context) {
    final currentUserId = context.read<UserController>().currentUser?.id ?? '';

    return Consumer<ChatController>(
      builder: (context, controller, _) {
        return SafeArea(
          top: false,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.07),
                  blurRadius: 16,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.messageInputController,
                    textCapitalization: TextCapitalization.sentences,
                    minLines: 1,
                    maxLines: 5,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.lightTextPrimary,
                      height: 1.4,
                    ),
                    decoration: InputDecoration(
                      hintText: AppStrings.typeMessage,
                      hintStyle: const TextStyle(
                        color: AppColors.greyMedium,
                        fontSize: 15,
                      ),
                      filled: true,
                      fillColor: AppColors.inputFill,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: const BorderSide(
                          color: AppColors.greyLight,
                          width: 1.2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: const BorderSide(
                          color: AppColors.primary,
                          width: 1.8,
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Icon(
                          Icons.emoji_emotions_outlined,
                          color: AppColors.greyMedium,
                          size: 22,
                        ),
                      ),
                    ),
                    onSubmitted: (_) => controller.submitMessage(
                      chatStringId: chatStringId,
                      senderId: currentUserId,
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                // ── Send / loading button ──────────────────────────
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  height: 46,
                  width: 46,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: controller.isSending
                        ? null
                        : const LinearGradient(
                            colors: [Color(0xFF4F7EFF), AppColors.primary],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                    color: controller.isSending ? AppColors.greyLight : null,
                    boxShadow: controller.isSending
                        ? []
                        : [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.4),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(23),
                      onTap: controller.isSending
                          ? null
                          : () => controller.submitMessage(
                              chatStringId: chatStringId,
                              senderId: currentUserId,
                            ),
                      child: controller.isSending
                          ? const Padding(
                              padding: EdgeInsets.all(11),
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.greyMedium,
                              ),
                            )
                          : const Icon(
                              Icons.send_rounded,
                              color: AppColors.white,
                              size: 20,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
