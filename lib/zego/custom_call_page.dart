
// import 'dart:async';
// import 'dart:math' as math;
// import 'dart:ui';

// import 'package:dating_app/services/Call/call_api_service.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:zego_uikit/zego_uikit.dart';

// class CustomCallPage extends StatefulWidget {
//   final String userID;
//   final String userName;
//   final String callID;
//   final bool isVideoCall;

//   const CustomCallPage({
//     super.key,
//     required this.userID,
//     required this.userName,
//     required this.callID,
//     required this.isVideoCall,
//   });

//   @override
//   State<CustomCallPage> createState() => _CustomCallPageState();
// }

// class _CustomCallPageState extends State<CustomCallPage>
//     with SingleTickerProviderStateMixin {
//   bool _isMicOn = true;
//   bool _isSpeakerOn = true;
//   bool _isVideoOn = false;
//   bool _isTopMenuVisible = false;

//   final Stopwatch _stopwatch = Stopwatch();
//   Timer? _timer;
//   String _durationText = '0:00';

//   late final AnimationController _waveController;
//   late final PageController _pageController;
//   Timer? _pageTimer;

//   @override
//   void initState() {
//     super.initState();

//     _pageController = PageController(viewportFraction: 0.9);
//     _waveController =
//         AnimationController(vsync: this, duration: const Duration(seconds: 4))
//           ..repeat();

//     _joinRoom();
//   }

//   // ================= JOIN ZEGO ROOM =================
// Future<void> _joinRoom() async {
//   debugPrint('Joining room: ${widget.callID}');

//   // 1️⃣ Join room
//   await ZegoUIKit().joinRoom(widget.callID);

//   // 2️⃣ Enable microphone
//   ZegoUIKit().turnMicrophoneOn(true, userID: widget.userID);

//   // 3️⃣ Speaker
//   ZegoUIKit().setAudioOutputToSpeaker(true);

//   // 4️⃣ Enable camera if video call
//   if (widget.isVideoCall) {
//     final cam = await Permission.camera.request();
//     if (cam.isGranted) {
//       ZegoUIKit().turnCameraOn(true, userID: widget.userID);
//       _isVideoOn = true;
//     }
//   }

//   setState(() {
//     _isMicOn = true;
//     _isSpeakerOn = true;
//   });

//   _startTimer();
// }



//   // ================= TIMER =================
//   void _startTimer() {
//     _stopwatch.start();
//     _timer = Timer.periodic(const Duration(seconds: 1), (_) {
//       final s = _stopwatch.elapsed.inSeconds;
//       setState(() {
//         _durationText = '${s ~/ 60}:${(s % 60).toString().padLeft(2, '0')}';
//       });
//     });
//   }

//   // ================= LEAVE ROOM =================
//   // Future<void> _leaveRoom() async {
//   //   _timer?.cancel();
//   //   _pageTimer?.cancel();
//   //   _stopwatch.stop();

//   //   ZegoUIKit().turnCameraOn(false, userID: widget.userID);
//   //   ZegoUIKit().turnMicrophoneOn(false, userID: widget.userID);
//   //     // await CallApiService.updateCallStatus(widget.callID, 'ended');


//   //   await ZegoUIKit().leaveRoom();

//   //   if (mounted) Navigator.pop(context);
//   // }


//   Future<void> _leaveRoom() async {
//   _timer?.cancel();
//   _stopwatch.stop();

//   ZegoUIKit().turnCameraOn(false, userID: widget.userID);
//   ZegoUIKit().turnMicrophoneOn(false, userID: widget.userID);

//   await ZegoUIKit().leaveRoom();

//   if (mounted) Navigator.pop(context);
// }


//   // ================= TOGGLES =================
//   void _toggleMic() {
//     final v = !_isMicOn;
//     ZegoUIKit().turnMicrophoneOn(v, userID: widget.userID);
//     setState(() => _isMicOn = v);
//   }

//   void _toggleSpeaker() {
//     final v = !_isSpeakerOn;
//     ZegoUIKit().setAudioOutputToSpeaker(v);
//     setState(() => _isSpeakerOn = v);
//   }

//   Future<void> _enableVideo() async {
//     if (!widget.isVideoCall) return;

//     final status = await Permission.camera.request();
//     if (!status.isGranted) return;

//     ZegoUIKit().turnCameraOn(true, userID: widget.userID);
//     setState(() => _isVideoOn = true);
//   }

//   void _disableVideo() {
//     ZegoUIKit().turnCameraOn(false, userID: widget.userID);
//     setState(() => _isVideoOn = false);
//   }

//   @override
//   void dispose() {
//     _waveController.dispose();
//     _pageController.dispose();
//     _timer?.cancel();
//     _pageTimer?.cancel();
//     super.dispose();
//   }

//   // ================= UI =================
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Image.asset('assets/background.jpg', fit: BoxFit.cover),
//           ),
//           SafeArea(
//             child: Stack(
//               children: [
//                 Positioned.fill(
//                   child:
//                       _isVideoOn ? _buildVideoArea() : _buildVoiceBackground(),
//                 ),
//                 _buildTopBar(),
//                 _buildBottomBar(),
//                 if (_isTopMenuVisible) _buildTopPopupMenu(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ================= VIDEO AREA (REMOTE USER) =================
//   Widget _buildVideoArea() {
//     return StreamBuilder<List<ZegoUIKitUser>>(
//       stream: ZegoUIKit().getUserListStream(),
//       builder: (context, snapshot) {
//         final users = snapshot.data ?? [];

//         final remoteUser = users.firstWhere(
//           (u) => u.id != widget.userID,
//           orElse: () => ZegoUIKitUser.empty(),
//         );

//         if (remoteUser.id.isEmpty) {
//           return const Center(
//             child: Text(
//               'Waiting for video...',
//               style: TextStyle(color: Colors.white),
//             ),
//           );
//         }

//         final notifier =
//             ZegoUIKit().getAudioVideoViewNotifier(remoteUser.id);

//         return ValueListenableBuilder<Widget?>(
//           valueListenable: notifier,
//           builder: (_, view, __) {
//             return view ??
//                 const Center(child: CircularProgressIndicator());
//           },
//         );
//       },
//     );
//   }

//   // ================= VOICE UI =================
//   Widget _buildVoiceBackground() {
//     return Center(
//       child: AnimatedBuilder(
//         animation: _waveController,
//         builder: (_, __) {
//           final wave =
//               math.sin(_waveController.value * 2 * math.pi) * 8;
//           return Transform.translate(
//             offset: Offset(0, wave),
//             child: const CircleAvatar(
//               radius: 60,
//               backgroundImage: AssetImage('assets/girlimage1.png'),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // ================= TOP BAR =================
//   Widget _buildTopBar() {
//     return Positioned(
//       top: 12,
//       left: 16,
//       right: 16,
//       child: Row(
//         children: [
//           const CircleAvatar(
//             backgroundImage: AssetImage('assets/girlimage1.png'),
//           ),
//           const SizedBox(width: 10),
//           Text('+ $_durationText',
//               style: const TextStyle(color: Colors.white)),
//           const Spacer(),
//           IconButton(
//             icon: const Icon(Icons.more_vert, color: Colors.white),
//             onPressed: () =>
//                 setState(() => _isTopMenuVisible = !_isTopMenuVisible),
//           ),
//         ],
//       ),
//     );
//   }

//   // ================= BOTTOM BAR =================
//   Widget _buildBottomBar() {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: ElevatedButton.icon(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.white,
//             foregroundColor: Colors.red,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//           ),
//           icon: const Icon(Icons.call_end),
//           label: const Text('End Call'),
//           onPressed: _leaveRoom,
//         ),
//       ),
//     );
//   }

//   // ================= POPUP MENU =================
//   Widget _buildTopPopupMenu() {
//     return Positioned(
//       top: 70,
//       right: 16,
//       child: Row(
//         children: [
//           IconButton(
//             icon: Icon(_isMicOn ? Icons.mic : Icons.mic_off),
//             color: Colors.white,
//             onPressed: _toggleMic,
//           ),
//           IconButton(
//             icon:
//                 Icon(_isSpeakerOn ? Icons.volume_up : Icons.volume_off),
//             color: Colors.white,
//             onPressed: _toggleSpeaker,
//           ),
//           if (widget.isVideoCall)
//             IconButton(
//               icon: Icon(
//                   _isVideoOn ? Icons.videocam : Icons.videocam_off),
//               color: Colors.white,
//               onPressed: _isVideoOn ? _disableVideo : _enableVideo,
//             ),
//         ],
//       ),
//     );
//   }
// }


















import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:dating_app/services/Call/call_api_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zego_uikit/zego_uikit.dart';

class CustomCallPage extends StatefulWidget {
  final String userID;
  final String userName;
  final String callID;
  final bool isVideoCall;

  const CustomCallPage({
    super.key,
    required this.userID,
    required this.userName,
    required this.callID,
    required this.isVideoCall,
  });

  @override
  State<CustomCallPage> createState() => _CustomCallPageState();
}

class _CustomCallPageState extends State<CustomCallPage>
    with SingleTickerProviderStateMixin {
  bool _isMicOn = true;
  bool _isSpeakerOn = true;
  bool _isVideoOn = false;
  bool _isTopMenuVisible = false;
  bool _isFrontCamera = true;

  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  String _durationText = '0:00';

  late final AnimationController _waveController;
  
  // For pinning functionality
  String? _pinnedUserId;

  @override
  void initState() {
    super.initState();

    _waveController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..repeat();

    _joinRoom();
  }

  // ================= JOIN ZEGO ROOM =================
  Future<void> _joinRoom() async {
    debugPrint('Joining room: ${widget.callID}');

    // 1️⃣ Join room
    await ZegoUIKit().joinRoom(widget.callID);

    // 2️⃣ Enable microphone
    ZegoUIKit().turnMicrophoneOn(true, userID: widget.userID);

    // 3️⃣ Speaker
    ZegoUIKit().setAudioOutputToSpeaker(true);

    // 4️⃣ Enable camera if video call
    if (widget.isVideoCall) {
      final cam = await Permission.camera.request();
      if (cam.isGranted) {
        ZegoUIKit().turnCameraOn(true, userID: widget.userID);
        _isVideoOn = true;
      }
    }

    setState(() {
      _isMicOn = true;
      _isSpeakerOn = true;
    });

    _startTimer();
  }

  // ================= TIMER =================
  void _startTimer() {
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final s = _stopwatch.elapsed.inSeconds;
      setState(() {
        _durationText = '${s ~/ 60}:${(s % 60).toString().padLeft(2, '0')}';
      });
    });
  }

  // ================= LEAVE ROOM =================
  Future<void> _leaveRoom() async {
    _timer?.cancel();
    _stopwatch.stop();

    ZegoUIKit().turnCameraOn(false, userID: widget.userID);
    ZegoUIKit().turnMicrophoneOn(false, userID: widget.userID);

    await ZegoUIKit().leaveRoom();

    if (mounted) Navigator.pop(context);
  }

  // ================= TOGGLES =================
  void _toggleMic() {
    final v = !_isMicOn;
    ZegoUIKit().turnMicrophoneOn(v, userID: widget.userID);
    setState(() => _isMicOn = v);
  }

  void _toggleSpeaker() {
    final v = !_isSpeakerOn;
    ZegoUIKit().setAudioOutputToSpeaker(v);
    setState(() => _isSpeakerOn = v);
  }

  Future<void> _enableVideo() async {
    if (!widget.isVideoCall) return;

    final status = await Permission.camera.request();
    if (!status.isGranted) return;

    ZegoUIKit().turnCameraOn(true, userID: widget.userID);
    setState(() => _isVideoOn = true);
  }

  void _disableVideo() {
    ZegoUIKit().turnCameraOn(false, userID: widget.userID);
    setState(() => _isVideoOn = false);
  }

  void _toggleCamera() {
    final newValue = !_isFrontCamera;
    ZegoUIKit().useFrontFacingCamera(newValue);
    setState(() => _isFrontCamera = newValue);
  }

  // ================= PIN USER =================
  void _togglePinUser(String userId) {
    setState(() {
      if (_pinnedUserId == userId) {
        _pinnedUserId = null; // Unpin
      } else {
        _pinnedUserId = userId; // Pin this user
      }
    });
  }

  @override
  void dispose() {
    _waveController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/background.jpg', fit: BoxFit.cover),
          ),
          SafeArea(
            child: Stack(
              children: [
                Positioned.fill(
                  child:
                      _isVideoOn ? _buildVideoArea() : _buildVoiceBackground(),
                ),
                _buildTopBar(),
                _buildBottomBar(),
                if (_isTopMenuVisible) _buildTopPopupMenu(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= VIDEO AREA =================
  Widget _buildVideoArea() {
    return StreamBuilder<List<ZegoUIKitUser>>(
      stream: ZegoUIKit().getUserListStream(),
      builder: (context, snapshot) {
        final allUsers = snapshot.data ?? [];

        if (allUsers.isEmpty) {
          return const Center(
            child: Text(
              'Connecting...',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          );
        }

        // If someone is pinned, show pinned layout
        if (_pinnedUserId != null) {
          return _buildPinnedLayout(allUsers);
        }

        // If only current user (alone in call)
        if (allUsers.length == 1) {
          return _buildSingleUserView(allUsers.first);
        }

        // Multiple users - show in grid
        return _buildGridView(allUsers);
      },
    );
  }

  // ================= PINNED LAYOUT =================
  Widget _buildPinnedLayout(List<ZegoUIKitUser> allUsers) {
    final pinnedUser = allUsers.firstWhere(
      (u) => u.id == _pinnedUserId,
      orElse: () => allUsers.first,
    );

    final otherUsers = allUsers.where((u) => u.id != _pinnedUserId).toList();

    return Stack(
      children: [
        // Main pinned user (full screen) - tap to unpin
        Positioned.fill(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _pinnedUserId = null; // Unpin
              });
            },
            child: _buildUserVideoView(pinnedUser, isPinned: true, showUnpinHint: true),
          ),
        ),

        // Bottom scrollable thumbnails
        if (otherUsers.isNotEmpty)
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Container(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: otherUsers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: _buildThumbnailView(otherUsers[index]),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }

  // ================= THUMBNAIL VIEW =================
  Widget _buildThumbnailView(ZegoUIKitUser user) {
    final notifier = ZegoUIKit().getAudioVideoViewNotifier(user.id);
    final isCurrentUser = user.id == widget.userID;

    return GestureDetector(
      onTap: () => _togglePinUser(user.id),
      child: Container(
        width: 90,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isCurrentUser ? Colors.blue : Colors.white,
            width: 2,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              ValueListenableBuilder<Widget?>(
                valueListenable: notifier,
                builder: (_, view, __) {
                  return view ??
                      Center(
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.grey[800],
                          child: Text(
                            user.name.isNotEmpty
                                ? user.name[0].toUpperCase()
                                : '?',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                },
              ),
              // Name overlay
              Positioned(
                bottom: 4,
                left: 4,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    isCurrentUser ? 'You' : user.name,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= SINGLE USER VIEW =================
  Widget _buildSingleUserView(ZegoUIKitUser user) {
    return Center(
      child: _buildUserVideoView(user),
    );
  }

  // ================= GRID VIEW FOR MULTIPLE USERS =================
  Widget _buildGridView(List<ZegoUIKitUser> users) {
    // Determine grid layout based on user count
    int crossAxisCount;
    double childAspectRatio;

    if (users.length == 2) {
      crossAxisCount = 1;
      childAspectRatio = 9 / 16;
    } else if (users.length <= 4) {
      crossAxisCount = 2;
      childAspectRatio = 3 / 4;
    } else if (users.length <= 6) {
      crossAxisCount = 2;
      childAspectRatio = 2 / 3;
    } else {
      crossAxisCount = 3;
      childAspectRatio = 2 / 3;
    }

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: users.length,
      itemBuilder: (context, index) {
        return _buildUserVideoView(users[index], showPinButton: true);
      },
    );
  }

  // ================= USER VIDEO VIEW =================
  Widget _buildUserVideoView(ZegoUIKitUser user,
      {bool isPinned = false, bool showPinButton = false, bool showUnpinHint = false}) {
    final notifier = ZegoUIKit().getAudioVideoViewNotifier(user.id);
    final isCurrentUser = user.id == widget.userID;

    return GestureDetector(
      onTap: showPinButton ? () => _togglePinUser(user.id) : null,
      child: Stack(
        children: [
          // Video view
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: isPinned ? BorderRadius.zero : BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: isPinned ? BorderRadius.zero : BorderRadius.circular(12),
              child: ValueListenableBuilder<Widget?>(
                valueListenable: notifier,
                builder: (_, view, __) {
                  return view ??
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: isPinned ? 60 : 40,
                              backgroundColor: Colors.grey[800],
                              child: Text(
                                user.name.isNotEmpty
                                    ? user.name[0].toUpperCase()
                                    : '?',
                                style: TextStyle(
                                  fontSize: isPinned ? 48 : 32,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              isCurrentUser ? 'You' : user.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isPinned ? 18 : 14,
                              ),
                            ),
                          ],
                        ),
                      );
                },
              ),
            ),
          ),

          // User name overlay at bottom
          Positioned(
            bottom: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isCurrentUser ? 'You' : user.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isPinned ? 14 : 12,
                      fontWeight: isCurrentUser ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  if (isCurrentUser) ...[
                    const SizedBox(width: 4),
                    Icon(
                      Icons.person,
                      color: Colors.blue,
                      size: isPinned ? 16 : 14,
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Pin indicator with unpin hint
          if (isPinned)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.push_pin,
                      color: Colors.white,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Pinned',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (showUnpinHint) ...[
                      const SizedBox(width: 8),
                      const Text(
                        '• Tap to unpin',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

          // Tap to pin hint (show on hover or always for grid)
          if (showPinButton && !isPinned)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.push_pin_outlined,
                  color: Colors.white70,
                  size: 16,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ================= VOICE UI =================
  Widget _buildVoiceBackground() {
    return StreamBuilder<List<ZegoUIKitUser>>(
      stream: ZegoUIKit().getUserListStream(),
      builder: (context, snapshot) {
        final allUsers = snapshot.data ?? [];
        final remoteUsers = allUsers.where((u) => u.id != widget.userID).toList();

        if (remoteUsers.isEmpty) {
          return Center(
            child: AnimatedBuilder(
              animation: _waveController,
              builder: (_, __) {
                final wave = math.sin(_waveController.value * 2 * math.pi) * 8;
                return Transform.translate(
                  offset: Offset(0, wave),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('assets/girlimage1.png'),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Waiting for others...',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }

        // Show remote user avatars in voice call
        return Center(
          child: Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: remoteUsers.map((user) {
              return AnimatedBuilder(
                animation: _waveController,
                builder: (_, __) {
                  final wave = math.sin(_waveController.value * 2 * math.pi) * 8;
                  return Transform.translate(
                    offset: Offset(0, wave),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: const AssetImage('assets/girlimage1.png'),
                          backgroundColor: Colors.grey[800],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          user.name,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  // ================= TOP BAR =================
  Widget _buildTopBar() {
    return Positioned(
      top: 12,
      left: 16,
      right: 16,
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/girlimage1.png'),
          ),
          const SizedBox(width: 10),
          Text('$_durationText',
              style: const TextStyle(color: Colors.white, fontSize: 16)),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () =>
                setState(() => _isTopMenuVisible = !_isTopMenuVisible),
          ),
        ],
      ),
    );
  }

  // ================= BOTTOM BAR =================
  Widget _buildBottomBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Mic toggle
            _buildCircleButton(
              icon: _isMicOn ? Icons.mic : Icons.mic_off,
              onPressed: _toggleMic,
              backgroundColor: _isMicOn ? Colors.white24 : Colors.red,
            ),
            
            // Video toggle (if video call)
            if (widget.isVideoCall)
              _buildCircleButton(
                icon: _isVideoOn ? Icons.videocam : Icons.videocam_off,
                onPressed: _isVideoOn ? _disableVideo : _enableVideo,
                backgroundColor: _isVideoOn ? Colors.white24 : Colors.red,
              ),
            
            // End call
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              icon: const Icon(Icons.call_end),
              label: const Text('End Call'),
              onPressed: _leaveRoom,
            ),
            
            // Speaker toggle
            _buildCircleButton(
              icon: _isSpeakerOn ? Icons.volume_up : Icons.volume_off,
              onPressed: _toggleSpeaker,
              backgroundColor: _isSpeakerOn ? Colors.white24 : Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback onPressed,
    Color backgroundColor = Colors.white24,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
        iconSize: 28,
      ),
    );
  }

  // ================= POPUP MENU =================
  Widget _buildTopPopupMenu() {
    return Positioned(
      top: 70,
      right: 16,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            IconButton(
              icon: Icon(_isMicOn ? Icons.mic : Icons.mic_off),
              color: Colors.white,
              onPressed: _toggleMic,
            ),
            IconButton(
              icon: Icon(_isSpeakerOn ? Icons.volume_up : Icons.volume_off),
              color: Colors.white,
              onPressed: _toggleSpeaker,
            ),
            if (widget.isVideoCall)
              IconButton(
                icon: Icon(_isVideoOn ? Icons.videocam : Icons.videocam_off),
                color: Colors.white,
                onPressed: _isVideoOn ? _disableVideo : _enableVideo,
              ),
            if (widget.isVideoCall && _isVideoOn)
              IconButton(
                icon: const Icon(Icons.flip_camera_android),
                color: Colors.white,
                onPressed: _toggleCamera,
              ),
          ],
        ),
      ),
    );
  }
}
