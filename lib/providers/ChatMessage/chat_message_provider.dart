import 'package:dating_app/services/ChatMessage/chat_message_service.dart';
import 'package:dating_app/services/ChatMessage/chat_socket_service.dart';
import 'package:flutter/material.dart';
import '../../models/ChatMessage/chat_message_model.dart';


// class ChatMessageProvider extends ChangeNotifier {
//   final ChatMessageService _service = ChatMessageService();
//   final ChatSocketService _socket = ChatSocketService();

//   List<ChatMessage> messages = [];
//   bool isLoading = false;
//   bool isTyping = false;

//   String? _currentUserId;
//   String? _otherUserId;

//   // ---------------- LOAD CHAT ----------------

//   Future<void> loadConversation(String senderId, String receiverId) async {
//     _currentUserId = senderId;
//     _otherUserId = receiverId;

//     isLoading = true;
//     notifyListeners();
// print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk$senderId");
// print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk$receiverId");

//     messages = await _service.getConversation(senderId, receiverId);

//     isLoading = false;
//     notifyListeners();
//   }

//   // ---------------- SOCKET INIT ----------------

//   void initSocket({
//     required String currentUserId,
//     required String otherUserId,
//   }) {
//     _currentUserId = currentUserId;
//     _otherUserId = otherUserId;

//     _socket.connect(currentUserId);
//     _socket.joinChat(currentUserId, otherUserId);

//     /// RECEIVE MESSAGE
// _socket.socket?.on('receive-message', (data) {
//   final msg = ChatMessage.fromJson(data);

//   WidgetsBinding.instance.addPostFrameCallback((_) {
//     messages.add(msg);
//     notifyListeners();
//   });
// });


//     /// STATUS UPDATE (delivered / read)
// _socket.socket?.on('message-status-updated', (data) {
//   WidgetsBinding.instance.addPostFrameCallback((_) {
//     final index =
//         messages.indexWhere((m) => m.id == data['messageId']);

//     if (index != -1) {
//       messages[index] =
//           messages[index].copyWith(status: data['status']);
//       notifyListeners();
//     }
//   });
// });


//     /// TYPING
// _socket.socket?.on('user-typing', (_) {
//   WidgetsBinding.instance.addPostFrameCallback((_) {
//     isTyping = true;
//     notifyListeners();
//   });
// });


// _socket.socket?.on('user-stop-typing', (_) {
//   WidgetsBinding.instance.addPostFrameCallback((_) {
//     isTyping = false;
//     notifyListeners();
//   });
// });

//   }

//   // ---------------- SEND MESSAGE ----------------

//   Future<void> sendTextMessage({
//     required String senderId,
//     required String receiverId,
//     required String text,
//   }) async {
//     final message = await _service.sendMessage(
//       senderId: senderId,
//       receiverId: receiverId,
//       text: text,
//     );

//     messages.add(message);
//     notifyListeners();

//     _socket.sendMessage(
//       senderId: senderId,
//       receiverId: receiverId,
//       message: message,
//     );
//   }

//   // ---------------- TYPING ----------------

//   void typing() {
//     if (_currentUserId != null && _otherUserId != null) {
//       _socket.typing(_currentUserId!, _otherUserId!);
//     }
//   }

//   void stopTyping() {
//     if (_currentUserId != null && _otherUserId != null) {
//       _socket.stopTyping(_currentUserId!, _otherUserId!);
//     }
//   }

//   // ---------------- DISPOSE ----------------

//   void disposeSocket() {
//     _socket.disconnect();
//   }
// }









class ChatMessageProvider extends ChangeNotifier {
  final ChatMessageService _service = ChatMessageService();
  final ChatSocketService _socket = ChatSocketService();

  final List<ChatMessage> _messages = [];
  List<ChatMessage> get messages => _messages;

  String? _currentUserId;
  String? _otherUserId;

  bool _socketInitialized = false;

  // ================= LOAD CHAT =================

  Future<void> loadConversation(String userId, String otherUserId) async {
    _currentUserId = userId;
    _otherUserId = otherUserId;

    final data = await _service.getConversation(userId, otherUserId);

    _messages
      ..clear()
      ..addAll(data);

    notifyListeners();
  }

  // ================= SOCKET =================

  void initSocket({
    required String currentUserId,
    required String otherUserId,
  }) {
    if (_socketInitialized) return;
    _socketInitialized = true;

    _currentUserId = currentUserId;
    _otherUserId = otherUserId;

    _socket.connect(currentUserId);
    _socket.joinChat(currentUserId, otherUserId);

    _socket.socket?.off('receive-message');
    _socket.socket?.on('receive-message', (data) {
      final msg = ChatMessage.fromJson(data);

      // ✅ Prevent duplicates
      if (_messages.any((m) => m.id == msg.id)) return;

      _messages.add(msg);
      notifyListeners();

      // ✅ Mark delivered/read
      if (msg.receiverId == _currentUserId) {
        _socket.markDelivered(msg.id!, _currentUserId!);
      }
    });

    _socket.socket?.off('message-status-updated');
    _socket.socket?.on('message-status-updated', (data) {
      final index =
          _messages.indexWhere((m) => m.id == data['messageId']);

      if (index != -1) {
        _messages[index] =
            _messages[index].copyWith(status: data['status']);
        notifyListeners();
      }
    });
  }

  // ================= SEND =================

  Future<void> sendTextMessage({
    required String senderId,
    required String receiverId,
    required String text,
  }) async {
    // ❌ DO NOT ADD MESSAGE HERE
    await _service.sendMessage(
      senderId: senderId,
      receiverId: receiverId,
      text: text,
    );
  }

  // ================= TYPING =================

  void typing() {
    if (_currentUserId != null && _otherUserId != null) {
      _socket.typing(_currentUserId!, _otherUserId!);
    }
  }

  void stopTyping() {
    if (_currentUserId != null && _otherUserId != null) {
      _socket.stopTyping(_currentUserId!, _otherUserId!);
    }
  }

  // ================= DISPOSE =================

  void disposeSocket() {
    _socketInitialized = false;
    _socket.disconnect();
  }
}
