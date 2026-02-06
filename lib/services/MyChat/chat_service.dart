import 'dart:convert';
import 'package:dating_app/core/api_constants.dart';
import 'package:dating_app/models/MyChat/chat_model.dart';
import 'package:http/http.dart' as http;

class ChatService {
  final String baseUrl = ApiConstants.baseUrl;

  Future<List<ChatModel>> fetchMyChats(String userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/my-chats/$userId'),
    );
    print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkksfjfdjdkfjdj;lk$userId");

print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkksfjfdjdkfjdj;lk${response.body}");
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List chats = body['chats'];

      return chats.map((e) => ChatModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load chats');
    }
  }
}
