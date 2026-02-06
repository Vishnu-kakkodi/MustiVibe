import 'package:dating_app/models/MyChat/chat_model.dart';
import 'package:dating_app/services/MyChat/chat_service.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  final ChatService _service = ChatService();

  bool isLoading = false;
  List<ChatModel> chats = [];

  Future<void> loadChats(String userId) async {
    isLoading = true;
    notifyListeners();

    try {
      print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh$userId');
      chats = await _service.fetchMyChats(userId);
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    notifyListeners();
  }
}
