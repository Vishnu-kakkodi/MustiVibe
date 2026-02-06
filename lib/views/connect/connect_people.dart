// import 'package:flutter/material.dart';

// class ConnectPeople extends StatefulWidget {
//   const ConnectPeople({super.key});

//   @override
//   State<ConnectPeople> createState() => _ConnectPeopleState();
// }

// class _ConnectPeopleState extends State<ConnectPeople>
//     with TickerProviderStateMixin {
//   bool _showControls = false;
//   bool _showHeart = false;
//   bool _isMuted = false;
//   bool _isCameraOn = true;
//   bool _isSpeakerOn = true;
//   late AnimationController _heartController;
//   late Animation<double> _heartAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _heartController = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     );
//     _heartAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _heartController, curve: Curves.easeOut),
//     );
//     _heartController.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         setState(() {
//           _showHeart = false;
//         });
//         _heartController.reset();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _heartController.dispose();
//     super.dispose();
//   }

//   void _toggleControls() {
//     setState(() {
//       _showControls = !_showControls;
//     });
//   }

//   void _sendHeart() {
//     setState(() {
//       _showHeart = true;
//     });
//     _heartController.forward();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background image
//           Positioned.fill(
//             child: Image.asset(
//               'assets/7c4a78dbdc1142c15d075beeedd6e088924587c8.jpg',
//               fit: BoxFit.cover,
//             ),
//           ),

//           Positioned(
//             top: 300,
//             right: -30,
//             child: Container(
//               width: 150,
//               height: 150,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.pink.withOpacity(0.15),
//               ),
//             ),
//           ),
//           SafeArea(
//             child: Column(
//               children: [
//                 // Top bar
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Image.asset('assets/boyimage3.png'),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 8),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: const Text(
//                           '0:10',
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                             width: 40,
//                             height: 40,
//                             decoration: const BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: Colors.white24,
//                             ),
//                             child: const Icon(Icons.dangerous_outlined,color: Colors.red,),
//                           ),
//                           const SizedBox(width: 8),
//                           GestureDetector(
//                             onTap: _toggleControls,
//                             child: Container(
//                               width: 40,
//                               height: 40,
//                               decoration: const BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: Colors.white24,
//                               ),
//                               child: const Icon(Icons.more_vert,
//                                   color: Colors.white),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Control buttons (video, mic, speaker)
//                 if (_showControls)
//                   Padding(
//                     padding: const EdgeInsets.only(right: 16.0),
//                     child: Align(
//                       alignment: Alignment.centerRight,
//                       child: Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   _isCameraOn = !_isCameraOn;
//                                 });
//                               },
//                               child: Container(
//                                 width: 40,
//                                 height: 40,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: _isCameraOn
//                                       ? Colors.blue
//                                       : Colors.grey,
//                                 ),
//                                 child: Icon(
//                                   _isCameraOn
//                                       ? Icons.videocam
//                                       : Icons.videocam_off,
//                                   color: Colors.white,
//                                   size: 20,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 8),
//                             GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   _isMuted = !_isMuted;
//                                 });
//                               },
//                               child: Container(
//                                 width: 40,
//                                 height: 40,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color:
//                                       _isMuted ? Colors.grey : Colors.red,
//                                 ),
//                                 child: Icon(
//                                   _isMuted ? Icons.mic_off : Icons.mic,
//                                   color: Colors.white,
//                                   size: 20,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 8),
//                             GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   _isSpeakerOn = !_isSpeakerOn;
//                                 });
//                               },
//                               child: Container(
//                                 width: 40,
//                                 height: 40,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: _isSpeakerOn
//                                       ? Colors.black
//                                       : Colors.grey,
//                                 ),
//                                 child: Icon(
//                                   _isSpeakerOn
//                                       ? Icons.volume_up
//                                       : Icons.volume_off,
//                                   color: Colors.white,
//                                   size: 20,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),

//                 const Spacer(),

//                 // User avatars
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     _buildUserAvatar(
//                       imagePath: 'assets/girlimage3.png',
//                       name: 'name',
//                       onTap: _sendHeart,
//                     ),
//                     _buildUserAvatar(
//                       imagePath: 'assets/boyimage3.png',
//                       name: 'name',
//                       onTap: _sendHeart,
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 60),

//                 // Heart animation
//                 if (_showHeart)
//                   AnimatedBuilder(
//                     animation: _heartAnimation,
//                     builder: (context, child) {
//                       return Opacity(
//                         opacity: 1 - _heartAnimation.value,
//                         child: Transform.translate(
//                           offset: Offset(0, -100 * _heartAnimation.value),
//                           child: Transform.scale(
//                             scale: 0.5 + (_heartAnimation.value * 0.8),
//                             child: Column(
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   height: 100,
//                                   decoration: BoxDecoration(
//                                     color: Colors.red.withOpacity(0.9),
//                                     borderRadius: BorderRadius.circular(20),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.red.withOpacity(0.5),
//                                         blurRadius: 20,
//                                         spreadRadius: 5,
//                                       ),
//                                     ],
//                                   ),
//                                   child: const Icon(
//                                     Icons.favorite,
//                                     color: Colors.white,
//                                     size: 60,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 12),
//                                 Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 16, vertical: 8),
//                                   decoration: BoxDecoration(
//                                     color: Colors.black54,
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   child: const Text(
//                                     'name sent gift',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),

//                 const Spacer(),

//                 // End conversation button
//                 Padding(
//                   padding: const EdgeInsets.all(24.0),
//                   child: Container(
//                     width: double.infinity,
//                     height: 56,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(30),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.2),
//                           blurRadius: 10,
//                           offset: const Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.call_end,
//                           color: Colors.red[400],
//                           size: 24,
//                         ),
//                         const SizedBox(width: 12),
//                         Text(
//                           'End Conversation',
//                           style: TextStyle(
//                             color: Colors.red[400],
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildUserAvatar({
//     required String? imagePath,
//     required String name,
//     required VoidCallback onTap,
//   }) {
//     return Column(
//       children: [
//         GestureDetector(
//           onTap: onTap,
//           child: ClipOval(
//             child: imagePath != null
//                 ? Image.asset(imagePath, fit: BoxFit.cover)
//                 : const Icon(Icons.person, size: 50, color: Colors.deepPurple),
//           ),
//         ),
//         const SizedBox(height: 12),
//         Text(
//           name,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: const Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(Icons.add, color: Colors.blue, size: 16),
//               SizedBox(width: 4),
//               Text(
//                 'Follow',
//                 style: TextStyle(
//                   color: Colors.blue,
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }





// ignore_for_file: deprecated_member_use

import 'package:dating_app/views/navbar/navbar_screen.dart';
import 'package:flutter/material.dart';

class ConnectPeople extends StatefulWidget {
  const ConnectPeople({super.key});

  @override
  State<ConnectPeople> createState() => _ConnectPeopleState();
}

class _ConnectPeopleState extends State<ConnectPeople>
    with TickerProviderStateMixin {
  bool _showControls = false;
  bool _showHeart = false;
  bool _isMuted = false;
  bool _isCameraOn = true;
  bool _isSpeakerOn = true;
  bool _isVideoCallActive = false;
  late AnimationController _heartController;
  late Animation<double> _heartAnimation;

  @override
  void initState() {
    super.initState();
    _heartController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _heartAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _heartController, curve: Curves.easeOut));
    _heartController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showHeart = false;
        });
        _heartController.reset();
      }
    });
  }

  @override
  void dispose() {
    _heartController.dispose();
    super.dispose();
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
  }

  void _sendHeart() {
    setState(() {
      _showHeart = true;
    });
    _heartController.forward();
  }

  void _startVideoCall() {
    setState(() {
      _isVideoCallActive = true;
    });
  }

  void _endVideoCall() {
    setState(() {
      _isVideoCallActive = false;
    });
  }

  void _showEndConversationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Do you want to End Conversation?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const MainNavigationScreen(),
                            ),
                            (Route<dynamic> route) =>
                                false, // removes all previous routes
                          );
                          if (_isVideoCallActive) {
                            _endVideoCall();
                          }
                          // Add your navigation logic here to go back or to home screen
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              'Yes',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1.5,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'No',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isVideoCallActive) {
      return _buildVideoCallScreen();
    }

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/7c4a78dbdc1142c15d075beeedd6e088924587c8.jpg',
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            top: 300,
            right: -30,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.pink.withOpacity(0.15),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Top bar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/boyimage3.png'),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          '+ 5:10',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(
                              Icons.dangerous_outlined,
                              color: Colors.redAccent,
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: _toggleControls,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white24,
                              ),
                              child: const Icon(
                                Icons.more_vert,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Control buttons (video, mic, speaker)
                if (_showControls)
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isCameraOn = !_isCameraOn;
                                });
                                if (_isCameraOn) {
                                  _startVideoCall();
                                }
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _isCameraOn
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                                child: Icon(
                                  _isCameraOn
                                      ? Icons.videocam
                                      : Icons.videocam_off,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isMuted = !_isMuted;
                                });
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _isMuted ? Colors.grey : Colors.red,
                                ),
                                child: Icon(
                                  _isMuted ? Icons.mic_off : Icons.mic,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isSpeakerOn = !_isSpeakerOn;
                                });
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _isSpeakerOn
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                                child: Icon(
                                  _isSpeakerOn
                                      ? Icons.volume_up
                                      : Icons.volume_off,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                const Spacer(),

                // User avatars
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildUserAvatar(
                      imagePath: 'assets/girlimage3.png',
                      name: 'name',
                      onTap: _sendHeart,
                    ),
                    _buildUserAvatar(
                      imagePath: 'assets/boyimage3.png',
                      name: 'name',
                      onTap: _sendHeart,
                    ),
                  ],
                ),

                const SizedBox(height: 60),

                // Heart animation
                if (_showHeart)
                  AnimatedBuilder(
                    animation: _heartAnimation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: 1 - _heartAnimation.value,
                        child: Transform.translate(
                          offset: Offset(0, -100 * _heartAnimation.value),
                          child: Transform.scale(
                            scale: 0.5 + (_heartAnimation.value * 0.8),
                            child: Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.red.withOpacity(0.5),
                                        blurRadius: 20,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                    size: 60,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    'name sent gift',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                const Spacer(),

                // End conversation button
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: GestureDetector(
                    onTap: _showEndConversationDialog,
                    child: Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.call_end,
                            color: Colors.red[400],
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'End Conversation',
                            style: TextStyle(
                              color: Colors.red[400],
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoCallScreen() {
    return Scaffold(
      body: Stack(
        children: [
          // Video call background
          Positioned.fill(
            child: Image.asset('assets/girlimage3.png', fit: BoxFit.cover),
          ),

          SafeArea(
            child: Column(
              children: [
                // Top bar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // User info
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                              image: const DecorationImage(
                                image: AssetImage('assets/girlimage3.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Swathi',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      // Timer
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          '+ 5:10',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),

                      // Settings and more
                      Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.3),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.3),
                            ),
                            child: const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Control buttons (center top)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: const Icon(
                          Icons.messenger,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isMuted = !_isMuted;
                          });
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _isMuted ? Colors.grey : Colors.white,
                          ),
                          child: Icon(
                            _isMuted ? Icons.mic_off : Icons.mic,
                            color: _isMuted ? Colors.white : Colors.black,
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isSpeakerOn = !_isSpeakerOn;
                          });
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _isSpeakerOn ? Colors.white : Colors.grey,
                          ),
                          child: Icon(
                            _isSpeakerOn ? Icons.volume_up : Icons.volume_off,
                            color: _isSpeakerOn ? Colors.black : Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // End conversation button
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: GestureDetector(
                    onTap: _showEndConversationDialog,
                    child: Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.call_end,
                            color: Colors.red[400],
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'End Conversation',
                            style: TextStyle(
                              color: Colors.red[400],
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserAvatar({
    required String? imagePath,
    required String name,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: ClipOval(
            child: imagePath != null
                ? Image.asset(imagePath, fit: BoxFit.cover)
                : const Icon(Icons.person, size: 50, color: Colors.deepPurple),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add, color: Colors.blue, size: 16),
              SizedBox(width: 4),
              Text(
                'Follow',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
