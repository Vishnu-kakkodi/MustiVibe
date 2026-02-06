import 'package:dating_app/views/auth/login_screen.dart';
import 'package:dating_app/views/navbar/navbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


// class CallIntroScreen extends StatelessWidget {
//   final bool isLoggedIn;

//   const CallIntroScreen({
//     super.key,
//     required this.isLoggedIn,
//   });

//   void _onGetStarted(BuildContext context) {
//     if (isLoggedIn) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
//       );
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const LoginScreen()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         top: false,
//         child: Column(
//           children: [
//             // 🔝 Image Section
//             Expanded(
//               flex: 6,
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.only(
//                   bottomLeft: Radius.circular(32),
//                   bottomRight: Radius.circular(32),
//                 ),
//                 child: Image.asset(
//                   'assets/call.jpg', // replace with your image
//                   width: double.infinity,
//                   fit: BoxFit.fill,
//                 ),
//               ),
//             ),

//             // 📝 Text + Button Section
//             Expanded(
//               flex: 4,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 24),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const SizedBox(height: 24),

//                     // Title
//                     const Text(
//                       'Where Calls Meet\nConvenience',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 26,
//                         fontWeight: FontWeight.bold,
//                         height: 1.3,
//                       ),
//                     ),

//                     const SizedBox(height: 12),

//                     // Subtitle
//                     Text(
//                       'Better Call management, Better Productivity',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey.shade600,
//                       ),
//                     ),

//                     const SizedBox(height: 28),

//                     // 🟠 Get Started Button
//                     SizedBox(
//                       width: double.infinity,
//                       height: 52,
//                       child: ElevatedButton(
//                         onPressed: () => _onGetStarted(context),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFFFF7A00),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(26),
//                           ),
//                           elevation: 0,
//                         ),
//                         child: const Text(
//                           'Get Started',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 14),

//                     // Bottom text
//                     Text(
//                       'Don’t miss an opportunity • Try now',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey.shade500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }















import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerModal extends StatefulWidget {
  const VideoPlayerModal({Key? key}) : super(key: key);

  @override
  State<VideoPlayerModal> createState() => _VideoPlayerModalState();
}

class _VideoPlayerModalState extends State<VideoPlayerModal> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('assets/demo.mp4')
      ..initialize().then((_) {
        if (!mounted) return;

        setState(() {});
        _controller.play();

        // 👇 Listen for video end
        _controller.addListener(_videoListener);
      });
  }

  void _videoListener() {
    if (_controller.value.position >= _controller.value.duration &&
        _controller.value.isInitialized) {
      Navigator.of(context).pop(); // 🔥 close modal automatically
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: _controller.value.isInitialized
          ? FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFE91E63),
              ),
            ),
    );
  }
}



class DatingAppWelcomeScreen extends StatelessWidget {
  final bool isLoggedIn;

  const DatingAppWelcomeScreen({
    super.key,
    required this.isLoggedIn,
  });


  void _showVideoModal(BuildContext context) {
    print("calledddddddddddddddddddddddddddddddddddddddddd");
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Allows the modal to take up more space
    backgroundColor: Colors.black,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => const VideoPlayerModal(),
  );
}


    void _onGetStarted(BuildContext context) {
      print("oooooooooooooooooooooooooooooo$isLoggedIn");
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 60),
                      // Hero Section with floating elements
                      SizedBox(
                        height: 350,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Main hexagonal image container
                            Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFE91E63),
                                    Color(0xFF9C27B0),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.purple.withOpacity(0.3),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  'https://images.unsplash.com/photo-1516589178581-6cd7833ae3b2?w=400',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[300],
                                      child: const Icon(Icons.image, size: 50),
                                    );
                                  },
                                ),
                              ),
                            ),
                            
                            // Top left small circular image
                            Positioned(
                              top: 30,
                              left: 20,
                              child: _buildFloatingCircle(
                                'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200',
                                50,
                              ),
                            ),
                            
                            // Top right emoji circle (love)
                            Positioned(
                              top: 10,
                              right: 50,
                              child: _buildEmojiCircle('❤️', const Color(0xFFE91E63)),
                            ),
                            
                            // Top center emoji circle (food/emoji)
                            Positioned(
                              top: 40,
                              left: 70,
                              child: _buildEmojiCircle('🍔', const Color(0xFFFF9800)),
                            ),
                            
                            // Left side like icon
                            Positioned(
                              left: 0,
                              top: 160,
                              child: _buildIconCircle(Icons.favorite, const Color(0xFFE91E63)),
                            ),
                            
                            // Right top small profile
                            Positioned(
                              right: 10,
                              top: 100,
                              child: _buildFloatingCircle(
                                'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
                                45,
                              ),
                            ),
                            
                            // Bottom left small profile
                            Positioned(
                              left: 30,
                              bottom: 20,
                              child: _buildFloatingCircle(
                                'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200',
                                55,
                              ),
                            ),
                            
                            // Bottom right chat icon
                            Positioned(
                              right: 0,
                              bottom: 80,
                              child: _buildIconCircle(Icons.chat_bubble, const Color(0xFF03A9F4)),
                            ),
                            
                            // Bottom center add icon
                            Positioned(
                              bottom: 40,
                              right: 80,
                              child: _buildIconCircle(Icons.add, const Color(0xFF03A9F4)),
                            ),
                            
                            // Top right green dot
                            Positioned(
                              top: 90,
                              right: 40,
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF4CAF50),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            
                            // Small checkmark circle
                            Positioned(
                              top: 20,
                              left: 90,
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF4CAF50),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                            
                            // Bottom right small profile
                            Positioned(
                              right: 20,
                              bottom: 10,
                              child: _buildFloatingCircle(
                                'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200',
                                48,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 40),
                      
                      // Title
                      const Text(
                        'The Best Dating App',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      
                      const SizedBox(height: 12),
                      
                      // Main heading
                      const Text(
                        'Your Journey to\nLove Starts Now',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3142),
                          height: 1.3,
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Subtitle
                      const Text(
                        'Get started or see how the app works?',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                      
                      const SizedBox(height: 30),
                      
                      // Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                                           _showVideoModal(context);

                              },
                              icon: const Icon(Icons.play_arrow, size: 20),
                              label: const Text(
                                'Play Video',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE91E63),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 0,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _onGetStarted(context);
                              },
                              icon: const Icon(Icons.arrow_forward, size: 20),
                              label: const Text(
                                'Get Started',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF03A9F4),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 30),
                      
                      // Sign up text
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     const Text(
                      //       "Don't have an account? ",
                      //       style: TextStyle(
                      //         fontSize: 14,
                      //         color: Colors.grey,
                      //       ),
                      //     ),
                      //     GestureDetector(
                      //       onTap: () {},
                      //       child: const Text(
                      //         'Sign Up',
                      //         style: TextStyle(
                      //           fontSize: 14,
                      //           color: Color(0xFFE91E63),
                      //           fontWeight: FontWeight.w600,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      
                      // const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingCircle(String imageUrl, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipOval(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[300],
              child: const Icon(Icons.person, size: 20),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmojiCircle(String emoji, Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Center(
        child: Text(
          emoji,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget _buildIconCircle(IconData icon, Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Icon(
        icon,
        color: color,
        size: 20,
      ),
    );
  }
}
