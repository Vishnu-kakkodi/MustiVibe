import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:dating_app/providers/Coin/coins_provider.dart';
import 'package:dating_app/services/Call/call_api_service.dart';
import 'package:dating_app/views/Call/audio_video_popup.dart';
import 'package:dating_app/views/Call/call_screen.dart';
import 'package:dating_app/views/connect/connect_screen.dart';
import 'package:dating_app/views/credits/credits_screen.dart';
import 'package:dating_app/widgets/animated_text.dart';
import 'package:dating_app/widgets/coin_check.dart';
import 'package:dating_app/widgets/floatingHeartsAnimation.dart';
import 'package:dating_app/zego/custom_call_page.dart';
import 'package:dating_app/zego/zego_call_definitions.dart';
import 'package:dating_app/zego/zego_call_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/nearby_user_model.dart';
import '../../providers/nearby_user_provider.dart';

class InteractScreen extends StatefulWidget {
  final String currentUserId;

  const InteractScreen({super.key, required this.currentUserId});

  @override
  State<InteractScreen> createState() => _InteractScreenState();
}

class _InteractScreenState extends State<InteractScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final PageController _pageController;
  Timer? _pageTimer;

  // you can replace this with real logged-in name if you want
  String get _callerName => 'Guest';

  @override
  void initState() {
    super.initState();

    _pageController = PageController(viewportFraction: 0.8);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    // Fetch nearby users once the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final nearbyProvider = Provider.of<NearbyUserProvider>(
        context,
        listen: false,
      );
      nearbyProvider.fetchNearbyUsers(widget.currentUserId);
    });

    // Auto slide pages
    _pageTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      final provider = Provider.of<NearbyUserProvider>(context, listen: false);
      final users = provider.users;
      if (users.isEmpty || !_pageController.hasClients) return;

      final pageCount = (users.length / 5).ceil();
      if (pageCount <= 1) return;

      final currentPage = _pageController.page?.round() ?? 0;
      final nextPage = (currentPage + 1) % pageCount;

      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    _pageTimer?.cancel();
    super.dispose();
  }

  // ======== CALL HELPERS (same logic as Home "Call Now") =========

  String _buildOneToOneCallID(String id1, String id2) {
    final sorted = [id1, id2]..sort();
    return "call_${sorted[0]}_${sorted[1]}";
  }

  void _startVoiceCall(NearbyUser otherUser) {
    final callerId = widget.currentUserId;
    final callerName = _callerName;
    final calleeId = otherUser.id;
    print(
      "sddfffkldsfjslfjdddddddddddddddddddddddddddddddddddddddddddd$callerName",
    );
    final callID = _buildOneToOneCallID(callerId, calleeId);

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) => ZegoCallPage(
    //       userID: callerId,
    //       userName: callerName,
    //       callID: callID,
    //       type: MyCallType.oneOnOneVoice,
    //     ),
    //   ),
    // );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CustomCallPage(
          userID: callerId,
          userName: callerName,
          callID: callID,
          // type: callType,
          isVideoCall: false,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/7c4a78dbdc1142c15d075beeedd6e088924587c8.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height:
                  media.size.height - media.padding.top - media.padding.bottom,
              child: Column(
                children: [
                  // Top Bar
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 40,
                          height: 40,
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/boyimage2.png'),
                          ),
                        ),
                        // Coins
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CreditsScreen(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFFD700),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset('assets/coin.png'),
                                ),
                                const SizedBox(width: 6),
                                Consumer<CoinsProvider>(
                                  builder: (context, coinsProv, _) {
                                    return Row(
                                      children: [
                                        coinsProv.isLoading
                                            ? const SizedBox(
                                                width: 16,
                                                height: 16,
                                                child:
                                                    CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                    ),
                                              )
                                            : Text(
                                                coinsProv.coins.toString(),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Menu Icon
                        // Container(
                        //   width: 40,
                        //   height: 40,
                        //   decoration: BoxDecoration(
                        //     border:
                        //         Border.all(color: Colors.white, width: 2),
                        //     borderRadius: BorderRadius.circular(8),
                        //   ),
                        //   child: const Icon(
                        //     Icons.chat_bubble_outline,
                        //     color: Colors.white,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FloatingHeartsAnimation(),

                      FloatingHeartsAnimation(),

                      FloatingHeartsAnimation(),
                      FloatingHeartsAnimation(),

                      FloatingHeartsAnimation(),
                    ],
                  ),
                  // Title
                  AnimatedTitle(),

                  // ==== CENTER AREA : 2 - 1 - 2 LAYOUT ====
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Center(
                      child: Consumer<NearbyUserProvider>(
                        builder: (context, provider, _) {
                          if (provider.isLoading) {
                            return const CircularProgressIndicator(
                              color: Colors.white,
                            );
                          }

                          if (provider.error != null) {
                            return Text(
                              provider.error!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            );
                          }

                          if (provider.users.isEmpty) {
                            return const Text(
                              'No nearby users found',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            );
                          }

                          final users = provider.users;
                          final pageCount = (users.length / 5).ceil();

                          return SizedBox(
                            height: 500,
                            child: PageView.builder(
                              controller: _pageController,
                              itemCount: pageCount,
                              itemBuilder: (context, pageIndex) {
                                final start = pageIndex * 5;
                                final pageUsers = users
                                    .skip(start)
                                    .take(5)
                                    .toList();

                                NearbyUser? u0 = pageUsers.length > 0
                                    ? pageUsers[0]
                                    : null;
                                NearbyUser? u1 = pageUsers.length > 1
                                    ? pageUsers[1]
                                    : null;
                                NearbyUser? u2 = pageUsers.length > 2
                                    ? pageUsers[2]
                                    : null;
                                NearbyUser? u3 = pageUsers.length > 3
                                    ? pageUsers[3]
                                    : null;
                                NearbyUser? u4 = pageUsers.length > 4
                                    ? pageUsers[4]
                                    : null;

                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Top row (2)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        _buildWaveUserSlot(context, u0, 0.0),
                                        _buildWaveUserSlot(context, u1, 0.8),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    // Middle (1)
                                    _buildWaveUserSlot(context, u2, 1.6),
                                    const SizedBox(height: 20),
                                    // Bottom row (2)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        _buildWaveUserSlot(context, u3, 2.4),
                                        _buildWaveUserSlot(context, u4, 3.2),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FloatingHeartsAnimation(),

                      FloatingHeartsAnimation(),

                      FloatingHeartsAnimation(),
                      FloatingHeartsAnimation(),

                      FloatingHeartsAnimation(),
                    ],
                  ),

                  // Bottom Buttons
                  // Padding(
                  //   padding: const EdgeInsets.all(20.0),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: _buildActionButton(
                  //           context: context,
                  //           icon: Icons.phone,
                  //           label: 'Random',
                  //           subtitle: '10 coins/min',
                  //           color: const Color(0xFFE91E63),
                  //         ),
                  //       ),
                  //       const SizedBox(width: 16),
                  //       Expanded(
                  //         child: _buildActionButton(
                  //           context: context,
                  //           icon: Icons.videocam,
                  //           label: 'Random',
                  //           subtitle: '10 coins/min',
                  //           color: const Color(0xFFE91E63),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // One slot in 2-1-2 layout (can be empty)
  Widget _buildWaveUserSlot(
    BuildContext context,
    NearbyUser? user,
    double phaseOffset,
  ) {
    if (user == null) {
      return const SizedBox(width: 110, height: 110);
    }

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final t = _animationController.value;
        final wave = math.sin(t * 2 * math.pi + phaseOffset) * 6;
        return Transform.translate(offset: Offset(0, wave), child: child);
      },
      child: _buildUserCard(context: context, user: user),
    );
  }


    void checkCoinsAndProceed({
    required BuildContext context,
    required VoidCallback onAllowed,
  }) {
    final coins = context.read<CoinsProvider>().coins;

    if (coins >= 10) {
      onAllowed();
    } else {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (_) => const InsufficientCoinsSheet(),
      );
    }
  }

  Future<void> _startCall({
  required String receiverId,
  required bool isVideo,
}) async {

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const Center(
      child: CircularProgressIndicator(),
    ),
  );

  try {

    final res = await CallApiService.sendCallingRequest(
      senderId: widget.currentUserId,
      receiverId: receiverId,
      callType: isVideo ? 'video' : 'audio',
    );

    final data = jsonDecode(res.body);

    if (!data['success']) throw Exception("Call failed");

    final creds = data['zegoCredentials']['sender'];

    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CallScreen(
          roomId: creds['roomId'],
          token: creds['token'],
          userId: creds['userId'],
          isVideo: isVideo,
        ),
      ),
    );

  } catch (e) {
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Call failed: $e")),
    );
  }
}


  // Single user card (avatar + language + name)
  Widget _buildUserCard({
    required BuildContext context,
    required NearbyUser user,
  }) {
    return GestureDetector(
      // SAME BEHAVIOUR AS HOME "CALL NOW"
onTap: () {
  checkCoinsAndProceed(
    context: context,
    onAllowed: () {

      showModalBottomSheet(
        context: context,
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text("Audio Call"),
              onTap: () {
                Navigator.pop(context);
                _startCall(
                  receiverId: user.id,
                  isVideo: false,
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.videocam),
              title: const Text("Video Call"),
              onTap: () {
                Navigator.pop(context);
                _startCall(
                  receiverId: user.id,
                  isVideo: true,
                );
              },
            ),
          ],
        ),
      );

    },
  );
},

      child: Column(
        children: [
Stack(
  clipBehavior: Clip.none,
  children: [
    SizedBox(
      width: 70,
      height: 70,
      child: CircleAvatar(
        backgroundImage: user.profileImage.isNotEmpty
            ? NetworkImage(user.profileImage)
            : const AssetImage('assets/girlimage3.png')
                as ImageProvider,
      ),
    ),

    // 🔴📞 CALL ICON (top-right)
    const Positioned(
      top: -3,
      right: -3,
      child: Icon(Icons.call, color: Colors.red, size: 20),
    ),

    // 🟢⚫ ONLINE / OFFLINE DOT (bottom-right)
    Positioned(
      bottom: -2,
      right: -2,
      child: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: user.isOnline == true
              ? Colors.green
              : Colors.grey,
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
        ),
      ),
    ),
  ],
),

          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              user.language.isNotEmpty ? user.language : 'Unknown',
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            user.name.isNotEmpty ? user.name : 'User',
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String subtitle,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ConnectScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
