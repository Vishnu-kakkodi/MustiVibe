import 'package:dating_app/core/api_constants.dart';
import 'package:dating_app/models/ChatMessage/chat_message_model.dart';
import 'package:dio/dio.dart';

class ChatMessageService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      headers: {'Content-Type': 'application/json'},
    ),
  );

  /// Send Message
  Future<ChatMessage> sendMessage({
    required String senderId,
    required String receiverId,
    required String text,
  }) async {
    final response = await _dio.post(
      '/api/send-message',
      data: {
        'senderId': senderId,
        'receiverId': receiverId,
        'messageType': 'text',
        'text': text,
      },
    );

    return ChatMessage.fromJson(response.data['message']);
  }

  /// Get Conversation
  Future<List<ChatMessage>> getConversation(
    String senderId,
    String receiverId,
  ) async {
    final response = await _dio.get(
      '/api/conversation/$senderId/$receiverId',
    );

    final List list = response.data['messages'];
    return list.map((e) => ChatMessage.fromJson(e)).toList();
  }

  /// Mark Message as Read
  Future<void> markAsRead(String messageId) async {
    await _dio.patch(
      '/api/message/status/$messageId',
      data: {'status': 'read'},
    );
  }
}
