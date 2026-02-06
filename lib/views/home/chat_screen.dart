import 'package:dating_app/views/chat/connecting_friends.dart';
import 'package:dating_app/views/chat/messages_screen.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF3F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF3F5),
        elevation: 0,
        title: const Text(
          "Messages",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
        centerTitle: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 70,
              color: Colors.grey.shade500,
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MessagesScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 40,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFE0A62),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  "Find Friend",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
