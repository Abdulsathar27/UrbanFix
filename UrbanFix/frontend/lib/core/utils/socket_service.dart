import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:frontend/core/constants/api_constants.dart';
import 'package:frontend/core/utils/token_store.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  SocketService._internal();

  io.Socket? _socket;

  bool get isConnected => _socket?.connected ?? false;

  void connect(String userId) {
    if (isConnected) return;

    _socket = io.io(
      ApiConstants.socketUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setAuth({'token': TokenStore.token ?? ''})
          .disableAutoConnect()
          .build(),
    );

    _socket!.onConnect((_) {
      _socket!.emit('online', userId);
    });

    _socket!.onDisconnect((_) {});

    _socket!.connect();
  }

  void joinChat(String chatStringId, String userId) {
    _socket?.emit('joinChat', {'chatId': chatStringId, 'userId': userId});
  }

  void leaveChat(String chatStringId) {
    _socket?.emit('leaveChat', chatStringId);
  }

  void sendMessage({
    required String chatStringId,
    required String text,
    required String senderId,
  }) {
    _socket?.emit('sendMessage', {
      'chatId': chatStringId,
      'text': text,
      'sender': senderId,
      'tempId': DateTime.now().millisecondsSinceEpoch.toString(),
    });
  }

  /// Sets the receive-message callback (replaces any existing one).
  void onReceiveMessage(void Function(Map<String, dynamic>) callback) {
    _socket?.off('receiveMessage');
    _socket?.on('receiveMessage', (data) {
      if (data is Map) callback(Map<String, dynamic>.from(data));
    });
  }

  void offReceiveMessage() {
    _socket?.off('receiveMessage');
  }

  void disconnect() {
    _socket?.disconnect();
    _socket?.dispose();
    _socket = null;
  }
}
