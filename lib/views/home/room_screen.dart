import 'package:dating_app/providers/Coin/coins_provider.dart';
import 'package:dating_app/views/MyRoom/my_rooms_screen.dart';
import 'package:dating_app/views/credits/credits_screen.dart';
import 'package:dating_app/zego/custom_call_page.dart';
import 'package:dating_app/zego/zego_call_definitions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/room_model.dart';
import '../../providers/room_provider.dart';

/// ---------- GLOBAL DIALOG HELPERS ----------

void showConnectDialog(BuildContext context, String currentUserId) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Connect with friends',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      showAudioCallDialog(context, currentUserId);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFE0A62),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 0,
                    ),
                    icon: const Icon(Icons.phone),
                    label: const Text(
                      'Voice call',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: handle video call option
                      Navigator.pop(context);
                      showVideoCallDialog(context, currentUserId);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFE0A62),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 0,
                    ),
                    icon: const Icon(Icons.videocam),
                    label: const Text(
                      'Video call',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

void showAudioCallDialog(BuildContext context, String currentUserId) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (context) => Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: AudioCallDialog(currentUserId: currentUserId),
    ),
  );
}

void showVideoCallDialog(BuildContext context, String currentUserId) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (context) => Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: VideoCallDialog(currentUserId: currentUserId),
    ),
  );
}

/// ---------- ROOM SCREEN ----------

class RoomScreen extends StatefulWidget {
  const RoomScreen({super.key});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  String? userId;
  String? username;

  @override
  void initState() {
    super.initState();
    _initializeData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RoomProvider>().fetchRooms();
    });
  }

  Future<void> _initializeData() async {
    try {
      await _loadUserId();
      print("8888888888888888888888");
    } catch (e) {
      debugPrint('Initialization error: $e');
    }
  }

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('userId');
    final user = prefs.getString('name');

    if (id != null && id.isNotEmpty) {
      setState(() {
        userId = id;
        username = user;
      });
    } else {
      // Not logged in → show onboarding
      setState(() {
        userId = '';
        username = user;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = userId.toString();
    final currentName = username.toString();

    return Scaffold(
      backgroundColor: Colors.white,
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
          child: Column(
            children: [
              _buildHeader(context, currentUserId),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Consumer<RoomProvider>(
                    builder: (context, roomProvider, _) {
                      if (roomProvider.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (roomProvider.error != null) {
                        return Center(
                          child: Text(
                            roomProvider.error!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }

                      final rooms = roomProvider.rooms;

                      if (rooms.isEmpty) {
                        return const Center(
                          child: Text(
                            'No rooms available yet',
                            style: TextStyle(color: Colors.black54),
                          ),
                        );
                      }

                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.6,
                            ),
                        itemCount: rooms.length,
                        itemBuilder: (context, index) {
                          return RoomCard(
                            room: rooms[index],
                            currentUserId: currentUserId,
                            currentName: currentName,
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String currentUserId) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/boyimage2.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.person, color: Colors.orange);
                },
              ),
            ),
          ),
          const SizedBox(width: 14),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreditsScreen()),
              );
            },
            child: Consumer<CoinsProvider>(
              builder: (context, coinsProv, _) {
                return Row(
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
                    coinsProv.isLoading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(
                            coinsProv.coins.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 220, 81),
                            ),
                          ),
                  ],
                );
              },
            ),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.pink, width: 2),
              borderRadius: BorderRadius.circular(9),
            ),
            child: IconButton(
              icon: const Icon(Icons.person, color: Colors.pink, size: 28),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyRoomsScreen()),
                );
              },
            ),
          ),
          SizedBox(width: 15),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.pink, width: 2),
              borderRadius: BorderRadius.circular(9),
            ),
            child: IconButton(
              icon: const Icon(Icons.add, color: Colors.pink, size: 28),
              onPressed: () {
                showConnectDialog(context, currentUserId);
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------- ROOM CARD (UI SAME, DATA FROM API) ----------

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

class RoomCard extends StatelessWidget {
  final Room room;
  final String currentUserId;
  final String currentName;

  const RoomCard({
    super.key,
    required this.room,
    required this.currentUserId,
    required this.currentName,
  });

  @override
  Widget build(BuildContext context) {
    final user = room.user;

    final DateTime startTime = parseRoomDateTime(room.startDateTime);
    final DateTime now = DateTime.now();

    final bool isBeforeStart = now.isBefore(startTime);
    final Duration remaining = startTime.difference(now);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.pink[100]!, Colors.pink[50]!],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.pink[200]!, width: 1),
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 5,
                          top: 15,
                          child: _buildAvatar(user.profileImage),
                        ),
                        Positioned(
                          top: 0,
                          child: _buildAvatar(user.profileImage, isLarge: true),
                        ),
                        Positioned(
                          right: 5,
                          top: 15,
                          child: _buildAvatar(user.profileImage),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      user.language.isNotEmpty ? user.language : room.tag,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    room.tag
                        ,
                    style:  TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          if (isBeforeStart) ...[
            const SizedBox(height: 6),
Text(
  'Starts @\n${room.startDateTime}',
  textAlign: TextAlign.center,
  style: const TextStyle(
    fontSize: 12,
    color: Colors.redAccent,
    fontWeight: FontWeight.w600,
  ),
),

          ],

          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isBeforeStart
                    ? null // disables button
                    : () {
                        _joinGroupCall(context, currentUserId, currentName);
                      },

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFE0A62),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Join Now',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _joinGroupCall(BuildContext context, String currentUserId, String name) {
    // 1. Get current user data
    // Replace with your real auth logic
    // final auth = context.read<AuthProvider>();
    // final userId = auth.user.id;
    // final userName = auth.user.nickname ?? auth.user.name ?? 'Guest';

    // TEMP hardcoded just to test:
    final userId = currentUserId;
    final userName = name;

    // 2. Decide audio or video based on room.type
    final typeStr = room.type.toLowerCase(); // "Voice" / "chat" / "Video"
    final MyCallType callType = typeStr == 'voice'
        ? MyCallType.groupVoice
        : MyCallType.groupVideo;

    // 3. Use backend room id as Zego room/call id
    final callId = room.id; // or room._id from your model
    print("sjdhfdskdsjgfdsjlsj$userId");
    print(userName);

    print(callId);

    print(callType);

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) => ZegoCallPage(
    //       userID: userId,
    //       userName: userName,
    //       callID: callId,
    //       type: callType,
    //     ),
    //   ),
    // );
    if (callType.toString() == 'MyCallType.groupVoice') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CustomCallPage(
            userID: userId,
            userName: userName,
            callID: callId,
            // type: callType,
            isVideoCall: false,
          ),
        ),
      );
    } else if (callType.toString() == 'MyCallType.groupVideo') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CustomCallPage(
            userID: userId,
            userName: userName,
            callID: callId,
            // type: callType,
            isVideoCall: true,
          ),
        ),
      );
    }
  }
}

Widget _buildAvatar(String imageUrl, {bool isLarge = false}) {
  final size = isLarge ? 50.0 : 35.0;
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: Colors.grey[300],
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white, width: 2),
    ),
    child: ClipOval(
      child: imageUrl.isNotEmpty
          ? Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.person, color: Colors.white, size: 20);
              },
            )
          : const Icon(Icons.person, color: Colors.white, size: 20),
    ),
  );
}

/// ---------- AUDIO CALL DIALOG (CREATES ROOM) ----------

class AudioCallDialog extends StatefulWidget {
  final String currentUserId;

  const AudioCallDialog({super.key, required this.currentUserId});

  @override
  State<AudioCallDialog> createState() => _AudioCallDialogState();
}

class _AudioCallDialogState extends State<AudioCallDialog> {
final List<String> topics = [
  'Love',
  'Dating',
  'Flirting',
  'Late Night Talks',
  'Truth or Dare',
  'Movies',
  'Music',
  'Games',
  'Travel',
  'Deep Talks',
  'Random Chat',
];

  final Set<String> selectedTopics = {};

  DateTime? selectedDateTime;

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    setState(() {
      selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     padding: const EdgeInsets.all(24),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         const Text(
  //           'Audio Call',
  //           style: TextStyle(
  //             fontSize: 18,
  //             fontWeight: FontWeight.bold,
  //             color: Colors.black,
  //           ),
  //         ),
  //         const SizedBox(height: 24),
  //         Wrap(
  //           spacing: 10,
  //           runSpacing: 12,
  //           alignment: WrapAlignment.center,
  //           children: topics.map((topic) => _buildTopicChip(topic)).toList(),
  //         ),
  //         const SizedBox(height: 24),
  //         SizedBox(
  //           width: double.infinity,
  //           child: ElevatedButton(
  //             onPressed: () async {
  //               if (selectedTopics.isEmpty) {
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   const SnackBar(
  //                     content: Text('Please select at least one topic'),
  //                   ),
  //                 );
  //                 return;
  //               }

  //               final tag = selectedTopics.first;
  //               const type = 'Voice';

  //               final roomProvider = Provider.of<RoomProvider>(
  //                 context,
  //                 listen: false,
  //               );

  //               // show loader
  //               showDialog(
  //                 context: context,
  //                 barrierDismissible: false,
  //                 builder: (_) =>
  //                     const Center(child: CircularProgressIndicator()),
  //               );

  //               final ok = await roomProvider.createRoom(
  //                 userId: widget.currentUserId,
  //                 type: type,
  //                 tag: tag,
  //               );

  //               // close loader
  //               Navigator.of(context).pop();

  //               if (!mounted) return;

  //               if (ok) {
  //                 // close the AudioCallDialog
  //                 Navigator.of(context).pop();

  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   const SnackBar(content: Text('Room created successfully')),
  //                 );
  //                 // rooms are already re-fetched in provider
  //               } else {
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   const SnackBar(
  //                     content: Text('Failed to create room. Please try again.'),
  //                   ),
  //                 );
  //               }
  //             },

  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: Colors.white,
  //               foregroundColor: const Color(0xFFFE0A62),
  //               padding: const EdgeInsets.symmetric(vertical: 14),
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(25),
  //                 side: const BorderSide(color: Color(0xFFFE0A62), width: 2),
  //               ),
  //               elevation: 0,
  //             ),
  //             child: const Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Icon(Icons.add, size: 20),
  //                 SizedBox(width: 8),
  //                 Text(
  //                   'Create Room',
  //                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  String _formatDateTime(DateTime dateTime) {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year;

    final hour12 = dateTime.hour > 12
        ? dateTime.hour - 12
        : dateTime.hour == 0
        ? 12
        : dateTime.hour;

    final minute = dateTime.minute.toString().padLeft(2, '0');
    final amPm = dateTime.hour >= 12 ? 'PM' : 'AM';

    return '$day-$month-$year $hour12:$minute $amPm';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Audio Call',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 24),

          /// 🔹 TOPIC SELECTION
          Wrap(
            spacing: 10,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: topics.map((topic) => _buildTopicChip(topic)).toList(),
          ),

          const SizedBox(height: 20),

          /// ✅ ADD DATE & TIME FIELD EXACTLY HERE
          GestureDetector(
            onTap: _pickDateTime,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: selectedDateTime == null
                      ? Colors.grey.shade300
                      : const Color(0xFFFE0A62),
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedDateTime == null
                        ? 'Select date & time'
                        : _formatDateTime(selectedDateTime!),
                    style: TextStyle(
                      fontSize: 14,
                      color: selectedDateTime == null
                          ? Colors.grey
                          : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Icon(
                    Icons.calendar_today,
                    size: 18,
                    color: Color(0xFFFE0A62),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          /// 🔹 CREATE ROOM BUTTON (already exists)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (selectedTopics.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select at least one topic'),
                    ),
                  );
                  return;
                }

                if (selectedDateTime == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select date & time')),
                  );
                  return;
                }

                final tag = selectedTopics.first;
                const type = 'Voice';

                final roomProvider = Provider.of<RoomProvider>(
                  context,
                  listen: false,
                );

                // show loader
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                );

                final ok = await roomProvider.createRoom(
                  userId: widget.currentUserId,
                  type: type,
                  tag: selectedTopics.first,
                  startDateTime: _formatDateTime(selectedDateTime!), // 🔥
                );
              },
              child: const Text('Create Room'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopicChip(String topic) {
    final isSelected = selectedTopics.contains(topic);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedTopics.remove(topic);
          } else {
            selectedTopics.add(topic);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFFFE0A62) : Colors.grey[300]!,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              topic,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected ? const Color(0xFFFE0A62) : Colors.black87,
              ),
            ),
            const SizedBox(width: 6),
            Icon(
              isSelected ? Icons.favorite : Icons.favorite_border,
              size: 16,
              color: const Color(0xFFFE0A62),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoCallDialog extends StatefulWidget {
  final String currentUserId;

  const VideoCallDialog({super.key, required this.currentUserId});

  @override
  State<VideoCallDialog> createState() => _VideoCallDialogState();
}

class _VideoCallDialogState extends State<VideoCallDialog> {
final List<String> topics = [
  'Love',
  'Dating',
  'Flirting',
  'Late Night Talks',
  'Truth or Dare',
  'Movies',
  'Music',
  'Games',
  'Travel',
  'Deep Talks',
  'Random Chat',
];

  final Set<String> selectedTopics = {};

  DateTime? selectedDateTime;

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    setState(() {
      selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  String _formatDateTime(DateTime dateTime) {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year;

    final hour12 = dateTime.hour > 12
        ? dateTime.hour - 12
        : dateTime.hour == 0
        ? 12
        : dateTime.hour;

    final minute = dateTime.minute.toString().padLeft(2, '0');
    final amPm = dateTime.hour >= 12 ? 'PM' : 'AM';

    return '$day-$month-$year $hour12:$minute $amPm';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Video Call',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 10,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: topics.map((topic) => _buildTopicChip(topic)).toList(),
          ),
          const SizedBox(height: 24),

          /// ✅ ADD DATE & TIME FIELD EXACTLY HERE
          GestureDetector(
            onTap: _pickDateTime,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: selectedDateTime == null
                      ? Colors.grey.shade300
                      : const Color(0xFFFE0A62),
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedDateTime == null
                        ? 'Select date & time'
                        : _formatDateTime(selectedDateTime!),
                    style: TextStyle(
                      fontSize: 14,
                      color: selectedDateTime == null
                          ? Colors.grey
                          : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Icon(
                    Icons.calendar_today,
                    size: 18,
                    color: Color(0xFFFE0A62),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (selectedTopics.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select at least one topic'),
                    ),
                  );
                  return;
                }

                final tag = selectedTopics.first;
                const type = 'Video';

                final roomProvider = Provider.of<RoomProvider>(
                  context,
                  listen: false,
                );

                // show loader
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                );

                final ok = await roomProvider.createRoom(
                  userId: widget.currentUserId,
                  type: type,
                  tag: tag,
                  startDateTime: _formatDateTime(selectedDateTime!),
                );

                // close loader
                Navigator.of(context).pop();

                if (!mounted) return;

                if (ok) {
                  // close the AudioCallDialog
                  Navigator.of(context).pop();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Room created successfully')),
                  );
                  // rooms are already re-fetched in provider
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Failed to create room. Please try again.'),
                    ),
                  );
                }
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFFFE0A62),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: const BorderSide(color: Color(0xFFFE0A62), width: 2),
                ),
                elevation: 0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Create Room',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopicChip(String topic) {
    final isSelected = selectedTopics.contains(topic);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedTopics.remove(topic);
          } else {
            selectedTopics.add(topic);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFFFE0A62) : Colors.grey[300]!,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              topic,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected ? const Color(0xFFFE0A62) : Colors.black87,
              ),
            ),
            const SizedBox(width: 6),
            Icon(
              isSelected ? Icons.favorite : Icons.favorite_border,
              size: 16,
              color: const Color(0xFFFE0A62),
            ),
          ],
        ),
      ),
    );
  }
}
