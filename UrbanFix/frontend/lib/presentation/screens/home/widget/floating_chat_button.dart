import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FloatingChatButton extends StatelessWidget {
  const FloatingChatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.go('/chats');
      },
      child: const Icon(Icons.chat),
    );
  }
}