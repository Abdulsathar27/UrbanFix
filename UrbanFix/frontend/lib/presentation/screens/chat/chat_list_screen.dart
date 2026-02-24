import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  static const List<Map<String, Object>> _chats = <Map<String, Object>>[
    {
      'id': 'chat-1',
      'name': 'John Doe',
      'lastMessage': 'I can be there at 2 PM today.',
      'time': '11:06 AM',
      'unread': 2,
    },
    {
      'id': 'chat-2',
      'name': 'Sarah Kim',
      'lastMessage': 'Thanks, see you tomorrow.',
      'time': 'Yesterday',
      'unread': 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: ListView.separated(
        itemCount: _chats.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final chat = _chats[index];
          final chatId = chat['id'] as String;
          final name = chat['name'] as String;
          final lastMessage = chat['lastMessage'] as String;
          final time = chat['time'] as String;
          final unread = chat['unread'] as int;

          return ListTile(
            leading: CircleAvatar(
              child: Text(name[0]),
            ),
            title: Text(name),
            subtitle: Text(
              lastMessage,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: unread > 0
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      unread.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : Text(
                    time,
                    style: const TextStyle(
                        color: Colors.grey),
                  ),
            onTap: () {
              context.pushNamed(
                'chatDetails',
                pathParameters: {'chatId': chatId},
              );
            },
          );
        },
      ),
    );
  }
}
