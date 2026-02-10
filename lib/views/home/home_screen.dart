
// import 'package:dating_app/config/zego_config.dart';
// import 'package:dating_app/models/nearby_user_model.dart';
// import 'package:dating_app/models/room_model.dart';
// import 'package:dating_app/providers/Coin/coins_provider.dart';
// import 'package:dating_app/providers/LocationProvider/location_provider.dart';
// import 'package:dating_app/providers/nearby_user_provider.dart';
// import 'package:dating_app/providers/room_provider.dart';
// import 'package:dating_app/providers/user_profile_provider.dart';
// import 'package:dating_app/services/Online/online.dart';
// import 'package:dating_app/utils/screen_size.dart';
// import 'package:dating_app/views/Call/audio_video_popup.dart';
// import 'package:dating_app/views/chat/messages_screen.dart';
// import 'package:dating_app/views/credits/credits_screen.dart';
// import 'package:dating_app/views/home/room_screen.dart';
// import 'package:dating_app/views/profile/profile_screen.dart';
// import 'package:dating_app/views/random/random_screen.dart';
// import 'package:dating_app/widgets/coin_check.dart';
// import 'package:dating_app/zego/custom_call_page.dart';
// import 'package:dating_app/zego/zego_call_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:zego_uikit/zego_uikit.dart';
// import 'package:permission_handler/permission_handler.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();

//   void checkCoinsAndProceed({
//     required BuildContext context,
//     required VoidCallback onAllowed,
//   }) {
//     final coins = context.read<CoinsProvider>().coins;

//     if (coins >= 10) {
//       onAllowed();
//     } else {
//       showModalBottomSheet(
//         context: context,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//         ),
//         builder: (_) => InsufficientCoinsSheet(),
//       );
//     }
//   }

//   // ================= ROOM CARD =================
//   static Widget buildRoomCard(
//     BuildContext context,
//     Room room,
//     String userId,
//     String name,
//   ) {
//     final theme = Theme.of(context);
//     SizeConfig.init(context);

//     DateTime parseRoomDateTime(String value) {
//       // format: dd-MM-yyyy hh:mm a
//       final parts = value.split(' ');
//       final date = parts[0].split('-');
//       final time = parts[1].split(':');
//       final amPm = parts[2];

//       int hour = int.parse(time[0]);
//       final minute = int.parse(time[1]);

//       if (amPm == 'PM' && hour != 12) hour += 12;
//       if (amPm == 'AM' && hour == 12) hour = 0;

//       return DateTime(
//         int.parse(date[2]),
//         int.parse(date[1]),
//         int.parse(date[0]),
//         hour,
//         minute,
//       );
//     }

//     String formatDuration(Duration d) {
//       final h = d.inHours;
//       final m = d.inMinutes.remainder(60);
//       final s = d.inSeconds.remainder(60);

//       if (h > 0) return '${h}h ${m}m';
//       if (m > 0) return '${m}m ${s}s';
//       return '${s}s';
//     }

//     final DateTime startTime = parseRoomDateTime(room.startDateTime);
//     final DateTime now = DateTime.now();

//     final bool isBeforeStart = now.isBefore(startTime);
//     final Duration remaining = startTime.difference(now);

//     void checkCoinsAndProceed({
//       required BuildContext context,
//       required VoidCallback onAllowed,
//     }) {
//       final coins = context.read<CoinsProvider>().coins;

//       if (coins >= 10) {
//         onAllowed();
//       } else {
//         showModalBottomSheet(
//           context: context,
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//           ),
//           builder: (_) => const InsufficientCoinsSheet(),
//         );
//       }
//     }

//     return GestureDetector(
//       onTap: () {
//         if (isBeforeStart) {
//           // ❌ Do nothing before start time
//           return;
//         }

//         checkCoinsAndProceed(
//           context: context,
//           onAllowed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => CustomCallPage(
//                   userID: userId,
//                   userName: name,
//                   callID: room.id,
//                   isVideoCall: room.type.toLowerCase() == 'video',
//                 ),
//               ),
//             );
//           },
//         );
//       },
//       child: Container(
//         padding: EdgeInsets.all(SizeConfig.blockWidth * 4),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               theme.colorScheme.primary.withOpacity(0.25),
//               theme.colorScheme.surface,
//             ],
//           ),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: theme.dividerColor),
//         ),
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image.network(
//                 room.user.profileImage,
//                 width: SizeConfig.blockWidth * 15,
//                 height: SizeConfig.blockWidth * 15,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             SizedBox(width: SizeConfig.blockWidth * 4),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     room.tag.isNotEmpty ? room.tag : 'Random connections',
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontSize: SizeConfig.blockWidth * 4,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     room.type,
//                     style: TextStyle(
//                       fontSize: SizeConfig.blockWidth * 3,
//                       color: theme.colorScheme.onSurface.withOpacity(0.7),
//                     ),
//                   ),

//                   if (isBeforeStart) ...[
//                     const SizedBox(height: 6),
//                     Text(
//                       'Starts @ ${room.startDateTime}',
//                       style: TextStyle(
//                         fontSize: SizeConfig.blockWidth * 3,
//                         color: Colors.redAccent,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//             const Icon(Icons.chevron_right),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ================= FRIEND CARD =================
// class FriendCard extends StatelessWidget {
//   final NearbyUser user;
//   final String userId;
//   final String name;

//   const FriendCard({
//     super.key,
//     required this.user,
//     required this.userId,
//     required this.name,
//   });

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig.init(context);
//     final theme = Theme.of(context);

//     void checkCoinsAndProceed({
//       required BuildContext context,
//       required VoidCallback onAllowed,
//     }) {
//       final coins = context.read<CoinsProvider>().coins;

//       if (coins >= 10) {
//         onAllowed();
//       } else {
//         showModalBottomSheet(
//           context: context,
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//           ),
//           builder: (_) => const InsufficientCoinsSheet(),
//         );
//       }
//     }

//     return Container(
//       padding: EdgeInsets.all(SizeConfig.blockWidth * 3),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             theme.colorScheme.primary.withOpacity(0.25),
//             theme.colorScheme.surface,
//           ],
//         ),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: theme.dividerColor),
//       ),
//       child: Column(
//         children: [
// Stack(
//   children: [
//     ClipOval(
//       child: Image.network(
//         user.profileImage,
//         height: SizeConfig.blockWidth * 12,
//         width: SizeConfig.blockWidth * 12,
//         fit: BoxFit.cover,
//       ),
//     ),

//     // 🟢⚫ ONLINE / OFFLINE DOT
//     Positioned(
//       bottom: 2,
//       right: 2,
//       child: Container(
//         width: 12,
//         height: 12,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: user.isOnline == true
//               ? Colors.green
//               : Colors.grey,
//           border: Border.all(
//             color: theme.colorScheme.surface,
//             width: 2,
//           ),
//         ),
//       ),
//     ),
//   ],
// ),

//           const SizedBox(height: 8),
//           Text(user.nickname.isNotEmpty ? user.nickname : user.name),
//           const SizedBox(height: 10),
//           GestureDetector(
//             onTap: () {
//               checkCoinsAndProceed(
//                 context: context,
//                 onAllowed: () {
//                   if (!ZegoCallManager.isReady) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text('Call service initializing…'),
//                       ),
//                     );
//                     return;
//                   }

//                   showCallOptions(
//                     context: context,
//                     targetUserId: user.id,
//                     targetUserName: user.name,
//                   );
//                 },
//               );
//             },

//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               decoration: BoxDecoration(
//                 color: theme.colorScheme.primary,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: const Text(
//                 'Call Now',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ================= HOME STATE =================
// class _HomeScreenState extends State<HomeScreen> {
//   String? userId;
//   String? name;
//   bool loading = true;

//   @override
//   void initState() {
//     super.initState();
//     _init();
//   }
//   // Future<void> _init() async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   userId = prefs.getString('userId');
//   //   name = prefs.getString('name') ?? 'Guest';

//   //   if (userId == null || userId!.isEmpty) {
//   //     setState(() => loading = false);
//   //     return;
//   //   }

//   //   // 🔥 1️⃣ LOGIN ZEGO CORE
//   //   ZegoUIKit().login(userId!, name!);
//   //   debugPrint('✅ Zego logged in: $userId');

//   //   // 🔥 2️⃣ INIT CALL INVITATION AFTER FIRST FRAME
//   //   WidgetsBinding.instance.addPostFrameCallback((_) {
//   //     ZegoCallManager.init(
//   //       userId: userId!,
//   //       userName: name!,
//   //     );
//   //   });

//   //   // 🔥 3️⃣ LOAD APP DATA
//   //   await Future.wait([
//   //     context.read<NearbyUserProvider>().fetchNearbyUsers(userId!),
//   //     context.read<RoomProvider>().fetchRooms(),
//   //     context.read<UserProfileProvider>().loadUserProfile(userId!),
//   //     context.read<CoinsProvider>().fetchUserCoins(userId!),
//   //   ]);

//   //   // 🔥 4️⃣ DONE — SHOW UI
//   //   if (mounted) {
//   //     setState(() => loading = false);
//   //   }
//   // }

//   Future<void> _init() async {
//     final prefs = await SharedPreferences.getInstance();
//     userId = prefs.getString('userId');
//     name = prefs.getString('name') ?? 'Guest';

//     // Always unblock UI
//     if (userId == null || userId!.isEmpty) {
//       if (mounted) setState(() => loading = false);
//       return;
//     }

//     // 🔔 1️⃣ REQUEST REQUIRED PERMISSIONS (ONCE)
//     // Android 13+ notification permission is CRITICAL for background calls
//     if (await Permission.notification.isDenied) {
//       await Permission.notification.request();
//     }

//     // Mic + Camera for calls
//     await [
//       Permission.microphone,
//       Permission.camera,
//       Permission.notification,
//       Permission.ignoreBatteryOptimizations,
//       Permission.systemAlertWindow,
//     ].request();

//     // 🔥 2️⃣ LOGIN ZEGO CORE (NO UI DEPENDENCY)
//     ZegoUIKit().login(userId!, name!);
//     debugPrint('✅ Zego logged in: $userId');
    

//     // 🔥 3️⃣ INIT CALL INVITATION AFTER FIRST FRAME
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ZegoCallManager.init(userId: userId!, userName: name!);
//     });

//     // 🔥 4️⃣ LOAD APP DATA
//     await Future.wait([
//       context.read<NearbyUserProvider>().fetchNearbyUsers(userId!),
//       context.read<RoomProvider>().fetchRooms(),
//       context.read<UserProfileProvider>().loadUserProfile(userId!),
//       context.read<CoinsProvider>().fetchUserCoins(userId!),
//     ]);

//     if (userId != null) {
//       SocketPresenceService().connect(userId!);
//     }

//     // 🔥 5️⃣ SHOW UI
//     if (mounted) {
//       setState(() => loading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig.init(context);
//     final theme = Theme.of(context);

//     if (loading) {
//       return const Scaffold(body: Center(child: CircularProgressIndicator()));
//     }

//     return Scaffold(
//       backgroundColor: theme.colorScheme.background,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.all(SizeConfig.blockWidth * 4),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Consumer<UserProfileProvider>(
//                     builder: (context, profileProv, _) {
//                       final user = profileProv.user;
//                       return GestureDetector(
//                         onTap: () => Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => const ProfileScreen(),
//                           ),
//                         ),
//                         child: CircleAvatar(
//                           radius: SizeConfig.blockHeight * 3,
//                           backgroundColor: Colors.grey.shade200,
//                           backgroundImage:
//                               (user != null &&
//                                   user.profileImage != null &&
//                                   user.profileImage!.isNotEmpty)
//                               ? NetworkImage(user.profileImage!)
//                               : const AssetImage('assets/boyimage2.png')
//                                     as ImageProvider,
//                         ),
//                       );
//                     },
//                   ),
//                   const SizedBox(width: 14),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => CreditsScreen()),
//                       );
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 12,
//                         vertical: 6,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.grey[200],
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 20,
//                             height: 20,
//                             decoration: const BoxDecoration(
//                               color: Color(0xFFFFD700),
//                               shape: BoxShape.circle,
//                             ),
//                             child: Image.asset('assets/coin.png'),
//                           ),
//                           const SizedBox(width: 6),
//                           Consumer<CoinsProvider>(
//                             builder: (context, coinsProv, _) {
//                               return Row(
//                                 children: [
//                                   coinsProv.isLoading
//                                       ? const SizedBox(
//                                           width: 16,
//                                           height: 16,
//                                           child: CircularProgressIndicator(
//                                             strokeWidth: 2,
//                                           ),
//                                         )
//                                       : Text(
//                                           coinsProv.coins.toString(),
//                                           style: const TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                 ],
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const Spacer(),
//                   IconButton(
//                     icon: const Icon(
//                       Icons.message_outlined,
//                       color: Colors.pink,
//                       size: 25,
//                     ),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const MessagesScreen(),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 20),
//               Container(
//                 width: double.infinity,
//                 height: 56,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                   gradient: LinearGradient(
//                     colors: [Colors.pink.shade400, Colors.purple.shade400],
//                     begin: Alignment.centerLeft,
//                     end: Alignment.centerRight,
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.pink.shade300.withOpacity(0.4),
//                       blurRadius: 12,
//                       offset: const Offset(0, 6),
//                     ),
//                   ],
//                 ),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     elevation: 0,
//                     backgroundColor: Colors.transparent,
//                     shadowColor: Colors.transparent,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => RandomScreen()),
//                     );
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: const [
//                       Icon(
//                         Icons.shuffle_rounded,
//                         color: Colors.white,
//                         size: 24,
//                       ),
//                       SizedBox(width: 12),
//                       Text(
//                         'Random',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           letterSpacing: 0.5,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               const Text(
//                 'Connect with nearby friends',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),

//               const SizedBox(height: 10),
//               Consumer<NearbyUserProvider>(
//                 builder: (_, nearby, __) => SizedBox(
//                   height: 180,
//                   child: ListView.separated(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: nearby.users.length,
//                     separatorBuilder: (_, __) => const SizedBox(width: 8),
//                     itemBuilder: (_, i) => SizedBox(
//                       width: 140,
//                       child: FriendCard(
//                         user: nearby.users[i],
//                         userId: userId!,
//                         name: name!,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 30),
// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   children: [
//     const Text(
//       'Discover all Rooms',
//       style: TextStyle(
//         fontSize: 18,
//         fontWeight: FontWeight.bold,
//       ),
//     ),

//     IconButton(
//       icon: const Icon(Icons.arrow_forward_ios, size: 18),
//       onPressed: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => const RoomScreen(), // 👈 your rooms page
//           ),
//         );
//       },
//     ),
//   ],
// ),


//               const SizedBox(height: 10),
//               Consumer<RoomProvider>(
//                 builder: (_, rooms, __) => Column(
//                   children: rooms.rooms
//                       .take(3)
//                       .map(
//                         (r) => Padding(
//                           padding: const EdgeInsets.only(bottom: 12),
//                           child: HomeScreen.buildRoomCard(
//                             context,
//                             r,
//                             userId!,
//                             name!,
//                           ),
//                         ),
//                       )
//                       .toList(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

















import 'package:dating_app/config/zego_config.dart';
import 'package:dating_app/models/nearby_user_model.dart';
import 'package:dating_app/models/room_model.dart';
import 'package:dating_app/providers/Coin/coins_provider.dart';
import 'package:dating_app/providers/LocationProvider/location_provider.dart';
import 'package:dating_app/providers/nearby_user_provider.dart';
import 'package:dating_app/providers/room_provider.dart';
import 'package:dating_app/providers/user_profile_provider.dart';
import 'package:dating_app/services/Online/online.dart';
import 'package:dating_app/utils/screen_size.dart';
import 'package:dating_app/views/Call/audio_video_popup.dart';
import 'package:dating_app/views/chat/messages_screen.dart';
import 'package:dating_app/views/credits/credits_screen.dart';
import 'package:dating_app/views/home/room_screen.dart';
import 'package:dating_app/views/notification/notification.dart';
import 'package:dating_app/views/profile/profile_screen.dart';
import 'package:dating_app/views/random/random_screen.dart';
import 'package:dating_app/widgets/coin_check.dart';
import 'package:dating_app/widgets/matching_loade.dart';
import 'package:dating_app/zego/custom_call_page.dart';
import 'package:dating_app/zego/zego_call_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

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
        builder: (_) => InsufficientCoinsSheet(),
      );
    }
  }

  // ================= ROOM CARD =================
  static Widget buildRoomCard(
    BuildContext context,
    Room room,
    String userId,
    String name,
  ) {
    final theme = Theme.of(context);
    SizeConfig.init(context);

    DateTime parseRoomDateTime(String value) {
      // format: dd-MM-yyyy hh:mm a
      final parts = value.split(' ');
      final date = parts[0].split('-');
      final time = parts[1].split(':');
      final amPm = parts[2];

      int hour = int.parse(time[0]);
      final minute = int.parse(time[1]);

      if (amPm == 'PM' && hour != 12) hour += 12;
      if (amPm == 'AM' && hour == 12) hour = 0;

      return DateTime(
        int.parse(date[2]),
        int.parse(date[1]),
        int.parse(date[0]),
        hour,
        minute,
      );
    }

    String formatDuration(Duration d) {
      final h = d.inHours;
      final m = d.inMinutes.remainder(60);
      final s = d.inSeconds.remainder(60);
      if (h > 0) return '${h}h ${m}m';
      if (m > 0) return '${m}m ${s}s';
      return '${s}s';
    }

    final DateTime startTime = parseRoomDateTime(room.startDateTime);
    final DateTime now = DateTime.now();
    final bool isBeforeStart = now.isBefore(startTime);
    final Duration remaining = startTime.difference(now);

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

    return GestureDetector(
onTap: () async {
  if (isBeforeStart) return;

  checkCoinsAndProceed(
    context: context,
    onAllowed: () async {
      final alreadyJoined = room.joinedUsers
          .any((u) => u.userId == userId);

      bool canEnter = alreadyJoined;

      /// ✅ If not joined → call join API
      if (!alreadyJoined) {
        try {
          final res = await http.post(
            Uri.parse('http://31.97.206.144:4055/api/users/joinroom'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              "roomId": room.id,
              "users": [userId],
            }),
          );
          print("iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii${room.id}");
                    print("iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii$userId");


          print("iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii${res.body}");

          final data = jsonDecode(res.body);

          if (res.statusCode == 200 && data['success'] == true) {
            canEnter = true;
          } else {
            Fluttertoast.showToast(
              msg: "Insufficient coins",
              backgroundColor: Colors.red,
              textColor: Colors.white,
            );
            return;
          }
        } catch (e) {
          Fluttertoast.showToast(
            msg: "Join room error",
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
          return;
        }
      }

      /// ✅ Enter room if allowed
      if (canEnter) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CustomCallPage(
              userID: userId,
              userName: name,
              callID: room.id,
              isVideoCall: room.type.toLowerCase() == 'video',
              startDateTime: room.startDateTime,
              duration: room.duration,
            ),
          ),
        );
      }
    },
  );
},

      child: Container(
        padding: EdgeInsets.all(SizeConfig.blockWidth * 4),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary.withOpacity(0.25),
              theme.colorScheme.surface,
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.dividerColor),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                room.user.profileImage,
                width: SizeConfig.blockWidth * 15,
                height: SizeConfig.blockWidth * 15,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: SizeConfig.blockWidth * 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    room.tag.isNotEmpty ? room.tag : 'Random connections',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: SizeConfig.blockWidth * 4,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    room.type,
                    style: TextStyle(
                      fontSize: SizeConfig.blockWidth * 3,
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  if (isBeforeStart) ...[
                    const SizedBox(height: 6),
                    Text(
                      'Starts @ ${room.startDateTime}',
                      style: TextStyle(
                        fontSize: SizeConfig.blockWidth * 3,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}

// Add this widget class in your file (after FriendCard or at the end before _HomeScreenState)

class EmptyRoomsWidget extends StatelessWidget {
  const EmptyRoomsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    SizeConfig.init(context);

    return Center(
      child: Container(
        padding: EdgeInsets.all(SizeConfig.blockWidth * 6),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary.withOpacity(0.1),
              theme.colorScheme.surface,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: theme.dividerColor.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon with gradient background
            // Container(
            //   padding: const EdgeInsets.all(20),
            //   decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //       colors: [
            //         Colors.pink.shade100.withOpacity(0.3),
            //         Colors.purple.shade100.withOpacity(0.3),
            //       ],
            //     ),
            //     shape: BoxShape.circle,
            //   ),
            //   child: Icon(
            //     Icons.video_call_outlined,
            //     size: 60,
            //     color: Colors.pink.shade300,
            //   ),
            // ),
            
            // const SizedBox(height: 20),
            
            // Title
            Text(
              'No Rooms Available',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Description
            Text(
              'There are no active rooms at the moment.\nCheck back later or create your own!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
                height: 1.5,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Action Button (Optional - if you have a create room feature)
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pink.shade400, Colors.purple.shade400],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.shade200.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                            Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RoomScreen(),
                        ),
                      );
                },
                icon: const Icon(Icons.add_circle_outline, color: Colors.white),
                label: const Text(
                  'Create Room',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
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

// ================= FRIEND CARD =================
class FriendCard extends StatelessWidget {
  final NearbyUser user;
  final String userId;
  final String name;

  const FriendCard({
    super.key,
    required this.user,
    required this.userId,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final theme = Theme.of(context);

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

    return Container(
      padding: EdgeInsets.all(SizeConfig.blockWidth * 3),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withOpacity(0.25),
            theme.colorScheme.surface,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipOval(
                child: Image.network(
                  user.profileImage,
                  height: SizeConfig.blockWidth * 12,
                  width: SizeConfig.blockWidth * 12,
                  fit: BoxFit.cover,
                ),
              ),
              // 🟢⚫ ONLINE / OFFLINE DOT
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: user.isOnline == true ? Colors.green : Colors.grey,
                    border: Border.all(
                      color: theme.colorScheme.surface,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(user.nickname.isNotEmpty ? user.nickname : user.name),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              checkCoinsAndProceed(
                context: context,
                onAllowed: () {
                  if (!ZegoCallManager.isReady) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Call service initializing…'),
                      ),
                    );
                    return;
                  }

                  showCallOptions(
                    context: context,
                    targetUserId: user.id,
                    targetUserName: user.name,
                  );
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Call Now',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= HOME STATE =================
class _HomeScreenState extends State<HomeScreen> {
  String? userId;
  String? name;
  String? userImage;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
    name = prefs.getString('name') ?? 'Guest';
    userImage = prefs.getString('userImage');

    // Always unblock UI
    if (userId == null || userId!.isEmpty) {
      if (mounted) setState(() => loading = false);
      return;
    }

    // 🔔 1️⃣ REQUEST REQUIRED PERMISSIONS (ONCE)
    // Android 13+ notification permission is CRITICAL for background calls
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }

    // Mic + Camera for calls
    await [
      Permission.microphone,
      Permission.camera,
      Permission.notification,
      Permission.ignoreBatteryOptimizations,
      Permission.systemAlertWindow,
    ].request();

    // 🔥 2️⃣ LOGIN ZEGO CORE (NO UI DEPENDENCY)
    ZegoUIKit().login(userId!, name!);
    debugPrint('✅ Zego logged in: $userId');

    // 🔥 3️⃣ INIT CALL INVITATION AFTER FIRST FRAME
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ZegoCallManager.init(userId: userId!, userName: name!);
    });

    // 🔥 4️⃣ LOAD APP DATA
    await Future.wait([
      context.read<NearbyUserProvider>().fetchNearbyUsers(userId!),
      context.read<RoomProvider>().fetchRooms(),
      context.read<UserProfileProvider>().loadUserProfile(userId!),
      context.read<CoinsProvider>().fetchUserCoins(userId!),
    ]);

    if (userId != null) {
      SocketPresenceService().connect(userId!);
    }

    // 🔥 5️⃣ SHOW UI
    if (mounted) {
      setState(() => loading = false);
    }
  }

  // 🔥 NEW: FETCH RANDOM USER API
  Future<Map<String, dynamic>?> _fetchRandomUser() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://31.97.206.144:4055/api/onlinerandomusers/$userId'),
      );

      print("llllllllllllllllllllllllllllllllllllllllllllyyyy${response.body}");
            print("llllllllllllllllllllllllllllllllllllllllllllyyyy${response.statusCode}");



if (response.statusCode == 200) {
  final data = json.decode(response.body);

  if (data['success'] == true && data['user'] != null) {
    return data['user']; // return whole user map
  }
}

      return null;
    } catch (e) {
      debugPrint('❌ Error fetching random user: $e');
      return null;
    }
  }

  // 🔥 NEW: HANDLE RANDOM BUTTON CLICK
  void _handleRandomButtonClick() async {
    // Show matching loader
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: MatchingLoader(
          topImageUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=Random',
          bottomImageUrl: userImage ??
              'https://api.dicebear.com/7.x/avataaars/svg?seed=You',
          loadingText: 'Finding\nRandom User',
          apiCall: _fetchRandomUser,
          onComplete: (response) {
            Navigator.pop(context); // Close loader
print("llllllllllllllllllllllllllllllllllllllllllll${response}");
            if (response != null) {
              // User found - show audio/video popup
              final randomUser = response as Map<String, dynamic>;
              
              showCallOptions(
                context: context,
                targetUserId: randomUser['_id'],
                targetUserName: randomUser['name'],
              );
            } else {
              // No user found - show toast
              Fluttertoast.showToast(
                msg: "No users found",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
          },
          minDisplayDuration: const Duration(seconds: 5),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final theme = Theme.of(context);

    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(SizeConfig.blockWidth * 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Consumer<UserProfileProvider>(
                    builder: (context, profileProv, _) {
                      final user = profileProv.user;
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ProfileScreen(),
                          ),
                        ),
                        child: CircleAvatar(
                          radius: SizeConfig.blockHeight * 3,
                          backgroundColor: Colors.grey.shade200,
                          backgroundImage: (user != null &&
                                  user.profileImage != null &&
                                  user.profileImage!.isNotEmpty)
                              ? NetworkImage(user.profileImage!)
                              : const AssetImage('assets/boyimage2.png')
                                  as ImageProvider,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 14),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => CreditsScreen()),
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
                                          child: CircularProgressIndicator(
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
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.message_outlined,
                      color: Colors.pink,
                      size: 25,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MessagesScreen(),
                        ),
                      );
                    },
                  ),
                                   IconButton(
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.pink,
                      size: 25,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NotificationScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 🔥 RANDOM BUTTON (UPDATED WITH LOADER)
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [Colors.pink.shade400, Colors.purple.shade400],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pink.shade300.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: _handleRandomButtonClick, // 🔥 NEW HANDLER
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.shuffle_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Random',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
              const Text(
                'Connect with nearby friends',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              Consumer<NearbyUserProvider>(
                builder: (_, nearby, __) => SizedBox(
                  height: 180,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: nearby.users.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (_, i) => SizedBox(
                      width: 140,
                      child: FriendCard(
                        user: nearby.users[i],
                        userId: userId!,
                        name: name!,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Discover all Rooms',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, size: 18),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RoomScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),

Consumer<RoomProvider>(
  builder: (_, rooms, __) {
    // Check if rooms list is empty
    if (rooms.rooms.isEmpty) {
      return const EmptyRoomsWidget();
    }
    
    // Show rooms if available
    return Column(
      children: rooms.rooms
          .take(3)
          .map(
            (r) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: HomeScreen.buildRoomCard(
                context,
                r,
                userId!,
                name!,
              ),
            ),
          )
          .toList(),
    );
  },
),
            ],
          ),
        ),
      ),
    );
  }
}