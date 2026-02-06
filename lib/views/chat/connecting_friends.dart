import 'dart:async';

import 'package:dating_app/providers/ChatMessage/chat_message_provider.dart';
import 'package:dating_app/views/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConnectingFriends extends StatefulWidget {
  const ConnectingFriends({super.key});

  @override
  State<ConnectingFriends> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectingFriends> {
  void initState() {
    super.initState();
    // Navigate to ConnectPeople screen after 3 seconds
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(
        //     builder: (context) => const Chatwithpeople(),
        //   ),
        // );

        Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => ChangeNotifierProvider(
      create: (_) => ChatMessageProvider(),
      child: ChatWithPeople(
        currentUserId: '692836f779b0889d7ae988f0',
        otherUserId: '692933032aa5fd1c16ea02fa',
        otherUserName: 'gana',
        otherUserImage:
            'https://res.cloudinary.com/dwmna13fi/image/upload/v1767446487/userProfileImages/xpdlgoyrllmmerw1lonn.jpg',
      ),
    ),
  ),
);

      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE5EC),
      body: Stack(
        children: [
          // Top background image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/connectrectangle.png',
              fit: BoxFit.cover,
            ),
          ),
          
          // Bottom background image
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/connectrectanglebottom.png',
              fit: BoxFit.cover,
            ),
          ),
          
          // Main content
          SafeArea(
            child: Column(
              children: [
                // App bar with back button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const Spacer(flex: 2),
            
            // Top user with concentric circles
            Stack(
              alignment: Alignment.center,
              children: [
                // Concentric circles
                for (int i = 3; i >= 0; i--)
                  Container(
                    width: 120.0 + (i * 30.0),
                    height: 120.0 + (i * 30.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                  ),
                
                // User avatar
                Container(
                  width: 80,
                  height: 80,
                 
                  child: ClipOval(
                    child: Image.asset(
                      'assets/girlimage3.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 60),
            
            // Arrow pointing down
            const Icon(
              Icons.arrow_upward,
              size: 32,
              color: Colors.white,
            ),
            
            const SizedBox(height: 40),
            
            // Bottom user (You)
            Column(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  
                  child: ClipOval(
                    child: Image.asset(
                      'assets/boyimage3.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.person,
                          size: 35,
                          color: Colors.white,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'You',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            
            const Spacer(flex: 1),
            
            // Bottom text and progress bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                children: [
                  // SizedBox(width: 50,),
                  const Text(
                    'Matching you with\nwhat truly fits',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 4,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFE91E63),
                          Color(0xFFFF4081),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
                            
            const SizedBox(height: 48),
          ],
        ),
      ),
        ],
      ),
    );
  }
}