import 'package:dating_app/core/api_constants.dart';
import 'package:dating_app/models/ChatMessage/chat_message_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatSocketService {
  static final ChatSocketService _instance = ChatSocketService._internal();
  factory ChatSocketService() => _instance;
  ChatSocketService._internal();

  IO.Socket? socket;

  void connect(String userId) {
    socket = IO.io(
      '${ApiConstants.baseUrl}', // ex: http://localhost:606
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket!.connect();

    socket!.onConnect((_) {
      print('Socket connected');

      socket!.emit('user-online', userId);
    });

    socket!.onDisconnect((_) {
      print('Socket disconnected');
    });
  }

  void joinChat(String userId, String otherUserId) {
    socket?.emit('join-chat', {
      'userId': userId,
      'otherUserId': otherUserId,
    });
  }

  void sendMessage({
    required String senderId,
    required String receiverId,
    required ChatMessage message,
  }) {
    socket?.emit('send-message', {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message.toJson(),
    });
  }

  void markDelivered(String messageId, String userId) {
    socket?.emit('message-delivered', {
      'messageId': messageId,
      'userId': userId,
    });
  }

  void markRead(String messageId, String userId) {
    socket?.emit('message-read', {
      'messageId': messageId,
      'userId': userId,
    });
  }

  void typing(String senderId, String receiverId) {
    socket?.emit('typing', {
      'senderId': senderId,
      'receiverId': receiverId,
    });
  }

  void stopTyping(String senderId, String receiverId) {
    socket?.emit('stop-typing', {
      'senderId': senderId,
      'receiverId': receiverId,
    });
  }

  void disconnect() {
    socket?.disconnect();
    socket?.dispose();
  }
}
