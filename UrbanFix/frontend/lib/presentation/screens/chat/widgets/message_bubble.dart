import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMine;
  final String time;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMine,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 3),
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.72,
            ),
            decoration: BoxDecoration(
              // Mine: primary gradient; Theirs: surface with subtle border
              gradient: isMine
                  ? const LinearGradient(
                      colors: [Color(0xFF4F7EFF), AppColors.primary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              color: isMine
                  ? null
                  : isDark
                      ? Theme.of(context).colorScheme.surfaceContainerHighest
                      : Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(18),
                topRight: const Radius.circular(18),
                bottomLeft: Radius.circular(isMine ? 18 : 4),
                bottomRight: Radius.circular(isMine ? 4 : 18),
              ),
              border: isMine
                  ? null
                  : Border.all(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.08),
                    ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              message,
              style: TextStyle(
                color: isMine
                    ? Colors.white
                    : Theme.of(context).colorScheme.onSurface,
                fontSize: 15,
                height: 1.4,
              ),
            ),
          ),

          // Time label
          Padding(
            padding: EdgeInsets.only(
              left: isMine ? 0 : 6,
              right: isMine ? 6 : 0,
              bottom: 4,
            ),
            child: Text(
              time,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.greyMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
