// import 'package:dating_app/providers/ChatMessage/chat_message_provider.dart';
// import 'package:dating_app/providers/Follow/follow_provider.dart';
// import 'package:dating_app/providers/MyChat/chat_provider.dart';
// import 'package:dating_app/providers/moderation/moderation_provider.dart';
// import 'package:dating_app/utils/report_helper.dart';
// import 'package:dating_app/views/chat/chat_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MessagesScreen extends StatefulWidget {
//   const MessagesScreen({super.key});

//   @override
//   State<MessagesScreen> createState() => _MessagesScreenState();
// }

// class _MessagesScreenState extends State<MessagesScreen> {
//   String? currentUserId;
//   bool _loadingUser = true;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserAndChats();
//   }

//   Future<void> _loadUserAndChats() async {
//     final prefs = await SharedPreferences.getInstance();
//     currentUserId = prefs.getString('userId');

//     if (currentUserId != null && currentUserId!.isNotEmpty) {
//       await context.read<ChatProvider>().loadChats(currentUserId!);
//     }

//     if (mounted) {
//       setState(() => _loadingUser = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final chatProvider = context.watch<ChatProvider>();

//     if (_loadingUser) {
//       return const Scaffold(body: Center(child: CircularProgressIndicator()));
//     }

//     /// 🔴 HIDE BLOCKED CHATS
//     final chats = chatProvider.chats.where((c) => c.isBlocked != true).toList();

//     return Scaffold(
//       backgroundColor: const Color(0xffFFF3F8),
//       appBar: AppBar(
//         backgroundColor: const Color(0xffFFF3F8),
//         elevation: 0,
//         title: const Text(
//           'Messages',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         iconTheme: const IconThemeData(color: Colors.black),
//       ),
//       body: chatProvider.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : chats.isEmpty
//           ? const Center(child: Text('No conversations yet'))
//           : ListView.builder(
//               itemCount: chats.length,
//               itemBuilder: (context, index) {
//                 final chat = chats[index];

//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => ChangeNotifierProvider(
//                           create: (_) => ChatMessageProvider(),
//                           child: Chatwithpeople(
//                             currentUserId: currentUserId!,
//                             otherUserId: chat.userId,
//                             otherUserName: chat.name,
//                             otherUserImage: chat.profileImage,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 12,
//                     ),
//                     decoration: const BoxDecoration(
//                       border: Border(
//                         bottom: BorderSide(color: Color(0xffF2DDE7), width: 1),
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         /// AVATAR
//                         Stack(
//                           children: [
//                             CircleAvatar(
//                               radius: 26,
//                               backgroundImage: NetworkImage(chat.profileImage),
//                             ),
//                             if (chat.isOnline)
//                               Positioned(
//                                 bottom: 2,
//                                 right: 2,
//                                 child: Container(
//                                   height: 10,
//                                   width: 10,
//                                   decoration: BoxDecoration(
//                                     color: Colors.green,
//                                     shape: BoxShape.circle,
//                                     border: Border.all(
//                                       color: Colors.white,
//                                       width: 2,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ),

//                         const SizedBox(width: 12),

//                         /// NAME + MESSAGE
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 chat.name,
//                                 style: const TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 chat.lastMessage,
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: const TextStyle(
//                                   fontSize: 13,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),

//                         /// RIGHT SIDE ACTIONS
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Text(
//                               "${chat.lastMessageTime.hour}:${chat.lastMessageTime.minute.toString().padLeft(2, '0')}",
//                               style: const TextStyle(
//                                 fontSize: 11,
//                                 color: Colors.grey,
//                               ),
//                             ),

//                             const SizedBox(height: 6),

//                             /// FOLLOW BUTTON
//                             if (!chat.isFollowing)
//                               Consumer<FollowProvider>(
//                                 builder: (context, followProv, _) {
//                                   return GestureDetector(
//                                     onTap: followProv.isLoading
//                                         ? null
//                                         : () async {
//                                             final success = await followProv
//                                                 .follow(
//                                                   userId: currentUserId!,
//                                                   followId: chat.userId,
//                                                 );

//                                             if (success) {
//                                               await context
//                                                   .read<ChatProvider>()
//                                                   .loadChats(currentUserId!);
//                                             }
//                                           },
//                                     child: Container(
//                                       padding: const EdgeInsets.symmetric(
//                                         horizontal: 12,
//                                         vertical: 4,
//                                       ),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(20),
//                                         border: Border.all(
//                                           color: const Color(0xffFE0A62),
//                                         ),
//                                       ),
//                                       child: followProv.isLoading
//                                           ? const SizedBox(
//                                               height: 14,
//                                               width: 14,
//                                               child: CircularProgressIndicator(
//                                                 strokeWidth: 2,
//                                               ),
//                                             )
//                                           : const Text(
//                                               'Follow',
//                                               style: TextStyle(
//                                                 fontSize: 12,
//                                                 color: Color(0xffFE0A62),
//                                               ),
//                                             ),
//                                     ),
//                                   );
//                                 },
//                               )
//                             else
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 12,
//                                   vertical: 4,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(20),
//                                   color: Colors.grey.shade300,
//                                 ),
//                                 child: const Text(
//                                   'Following',
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ),

//                             /// THREE DOT MENU
//                             PopupMenuButton<String>(
//                               icon: const Icon(Icons.more_vert, size: 18),
//                               onSelected: (value) {
//                                 if (value == 'block') {
//                                   _confirmBlock(chat.userId);
//                                 } else if (value == 'report') {
//                                   ReportHelper.show(
//                                     context: context,
//                                     reportedBy: currentUserId
//                                         .toString(), // current user
//                                     reportedUser: chat.userId, // 🔥 STATIC
//                                     reportType: "Message",
//                                   );
//                                 }
//                               },
//                               itemBuilder: (_) => const [
//                                 PopupMenuItem(
//                                   value: 'block',
//                                   child: Text('Block'),
//                                 ),
//                                 PopupMenuItem(
//                                   value: 'report',
//                                   child: Text('Report'),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }

//   /// 🔴 BLOCK CONFIRMATION
//   void _confirmBlock(String otherUserId) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Block user?'),
//         content: const Text(
//           'You will no longer receive messages from this user.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           Consumer<ModerationProvider>(
//             builder: (context, modProv, _) {
//               return TextButton(
//                 onPressed: modProv.isLoading
//                     ? null
//                     : () async {
//                         final success = await modProv.block(
//                           fromUser: currentUserId!,
//                           toUser: otherUserId,
//                         );

//                         if (success) {
//                           Navigator.pop(context);
//                           await context.read<ChatProvider>().loadChats(
//                             currentUserId!,
//                           );
//                         }
//                       },
//                 child: modProv.isLoading
//                     ? const CircularProgressIndicator(strokeWidth: 2)
//                     : const Text('Block', style: TextStyle(color: Colors.red)),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   /// 🟡 REPORT CONFIRMATION
//   void _confirmReport(String otherUserId) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Report user?'),
//         content: const Text('This will be reviewed by our admin team.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           Consumer<ModerationProvider>(
//             builder: (context, modProv, _) {
//               return TextButton(
//                 onPressed: modProv.isLoading
//                     ? null
//                     : () async {
//                         final success = await modProv.report(
//                           reportedBy: currentUserId!,
//                           reportedUser: otherUserId,
//                           reason: 'Inappropriate behaviour',
//                         );

//                         if (success) {
//                           Navigator.pop(context);
//                         }
//                       },
//                 child: modProv.isLoading
//                     ? const CircularProgressIndicator(strokeWidth: 2)
//                     : const Text(
//                         'Report',
//                         style: TextStyle(color: Colors.orange),
//                       ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }


























import 'package:dating_app/providers/ChatMessage/chat_message_provider.dart';
import 'package:dating_app/providers/Follow/follow_provider.dart';
import 'package:dating_app/providers/MyChat/chat_provider.dart';
import 'package:dating_app/providers/MyChat/pending_request_provider.dart';
import 'package:dating_app/providers/MyChat/random_user_provider.dart';
import 'package:dating_app/providers/moderation/moderation_provider.dart';
import 'package:dating_app/utils/report_helper.dart';
import 'package:dating_app/views/chat/bell.dart';
import 'package:dating_app/views/chat/chat_screen.dart';
import 'package:dating_app/widgets/matching_loade.dart';
// import 'package:dating_app/widgets/matching_loader.dart'; // Add this import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class MessagesScreen extends StatefulWidget {
//   const MessagesScreen({super.key});

//   @override
//   State<MessagesScreen> createState() => _MessagesScreenState();
// }

// class _MessagesScreenState extends State<MessagesScreen> {
//   String? currentUserId;
//   String? currentUserImage; // Add this
//   bool _loadingUser = true;
//   bool _showLoader = true; // Add this

//   @override
//   void initState() {
//     super.initState();
//     _loadUserAndChats();
//   }

//   Future<void> _loadUserAndChats() async {
//     final prefs = await SharedPreferences.getInstance();
//     currentUserId = prefs.getString('userId');
//     currentUserImage = prefs.getString('userImage'); // Get user image if stored

//     if (currentUserId != null && currentUserId!.isNotEmpty) {
//       await context.read<ChatProvider>().loadChats(currentUserId!);
//     }

//     if (mounted) {
//       setState(() => _loadingUser = false);
//     }
//   }

//   // API call function for the loader
//   Future<dynamic> _loadChatsAPI() async {
//     final prefs = await SharedPreferences.getInstance();
//     currentUserId = prefs.getString('userId');
//     currentUserImage = prefs.getString('userImage');

//     if (currentUserId != null && currentUserId!.isNotEmpty) {
//       await context.read<ChatProvider>().loadChats(currentUserId!);
//       return {'success': true};
//     }
//     return {'success': false};
//   }

//   void _handleLoaderComplete(dynamic response) {
//     if (mounted) {
//       setState(() {
//         _showLoader = false;
//         _loadingUser = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final chatProvider = context.watch<ChatProvider>();

//     // Show matching loader on first load
//     if (_showLoader) {
//       return MatchingLoader(
//         topImageUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=Match',
//         bottomImageUrl: currentUserImage ?? 
//             'https://api.dicebear.com/7.x/avataaars/svg?seed=You',
//         loadingText: 'Finding\nConversations & Friends',
//         apiCall: _loadChatsAPI,
//         onComplete: _handleLoaderComplete,
//         minDisplayDuration: Duration(seconds: 5),
//       );
//     }

//     /// 🔴 HIDE BLOCKED CHATS
//     final chats = chatProvider.chats.where((c) => c.isBlocked != true).toList();

//     return Scaffold(
//       backgroundColor: const Color(0xffFFF3F8),
//       appBar: AppBar(
//         backgroundColor: const Color(0xffFFF3F8),
//         elevation: 0,
//         title: const Text(
//           'Messages',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         iconTheme: const IconThemeData(color: Colors.black),
//       ),
//       body: chatProvider.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : chats.isEmpty
//           ? const Center(child: Text('No conversations yet'))
//           : ListView.builder(
//               itemCount: chats.length,
//               itemBuilder: (context, index) {
//                 final chat = chats[index];

//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => ChangeNotifierProvider(
//                           create: (_) => ChatMessageProvider(),
//                           child: Chatwithpeople(
//                             currentUserId: currentUserId!,
//                             otherUserId: chat.userId,
//                             otherUserName: chat.name,
//                             otherUserImage: chat.profileImage,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 12,
//                     ),
//                     decoration: const BoxDecoration(
//                       border: Border(
//                         bottom: BorderSide(color: Color(0xffF2DDE7), width: 1),
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         /// AVATAR
//                         Stack(
//                           children: [
//                             CircleAvatar(
//                               radius: 26,
//                               backgroundImage: NetworkImage(chat.profileImage),
//                             ),
//                             if (chat.isOnline)
//                               Positioned(
//                                 bottom: 2,
//                                 right: 2,
//                                 child: Container(
//                                   height: 10,
//                                   width: 10,
//                                   decoration: BoxDecoration(
//                                     color: Colors.green,
//                                     shape: BoxShape.circle,
//                                     border: Border.all(
//                                       color: Colors.white,
//                                       width: 2,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ),

//                         const SizedBox(width: 12),

//                         /// NAME + MESSAGE
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 chat.name,
//                                 style: const TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 chat.lastMessage,
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: const TextStyle(
//                                   fontSize: 13,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),

//                         /// RIGHT SIDE ACTIONS
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Text(
//                               "${chat.lastMessageTime.hour}:${chat.lastMessageTime.minute.toString().padLeft(2, '0')}",
//                               style: const TextStyle(
//                                 fontSize: 11,
//                                 color: Colors.grey,
//                               ),
//                             ),

//                             const SizedBox(height: 6),

//                             /// FOLLOW BUTTON
//                             if (!chat.isFollowing)
//                               Consumer<FollowProvider>(
//                                 builder: (context, followProv, _) {
//                                   return GestureDetector(
//                                     onTap: followProv.isLoading
//                                         ? null
//                                         : () async {
//                                             final success = await followProv
//                                                 .follow(
//                                                   userId: currentUserId!,
//                                                   followId: chat.userId,
//                                                 );

//                                             if (success) {
//                                               await context
//                                                   .read<ChatProvider>()
//                                                   .loadChats(currentUserId!);
//                                             }
//                                           },
//                                     child: Container(
//                                       padding: const EdgeInsets.symmetric(
//                                         horizontal: 12,
//                                         vertical: 4,
//                                       ),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(20),
//                                         border: Border.all(
//                                           color: const Color(0xffFE0A62),
//                                         ),
//                                       ),
//                                       child: followProv.isLoading
//                                           ? const SizedBox(
//                                               height: 14,
//                                               width: 14,
//                                               child: CircularProgressIndicator(
//                                                 strokeWidth: 2,
//                                               ),
//                                             )
//                                           : const Text(
//                                               'Follow',
//                                               style: TextStyle(
//                                                 fontSize: 12,
//                                                 color: Color(0xffFE0A62),
//                                               ),
//                                             ),
//                                     ),
//                                   );
//                                 },
//                               )
//                             else
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 12,
//                                   vertical: 4,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(20),
//                                   color: Colors.grey.shade300,
//                                 ),
//                                 child: const Text(
//                                   'Following',
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ),

//                             /// THREE DOT MENU
//                             PopupMenuButton<String>(
//                               icon: const Icon(Icons.more_vert, size: 18),
//                               onSelected: (value) {
//                                 if (value == 'block') {
//                                   _confirmBlock(chat.userId);
//                                 } else if (value == 'report') {
//                                   ReportHelper.show(
//                                     context: context,
//                                     reportedBy: currentUserId.toString(),
//                                     reportedUser: chat.userId,
//                                     reportType: "Message",
//                                   );
//                                 }
//                               },
//                               itemBuilder: (_) => const [
//                                 PopupMenuItem(
//                                   value: 'block',
//                                   child: Text('Block'),
//                                 ),
//                                 PopupMenuItem(
//                                   value: 'report',
//                                   child: Text('Report'),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }

//   /// 🔴 BLOCK CONFIRMATION
//   void _confirmBlock(String otherUserId) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Block user?'),
//         content: const Text(
//           'You will no longer receive messages from this user.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           Consumer<ModerationProvider>(
//             builder: (context, modProv, _) {
//               return TextButton(
//                 onPressed: modProv.isLoading
//                     ? null
//                     : () async {
//                         final success = await modProv.block(
//                           fromUser: currentUserId!,
//                           toUser: otherUserId,
//                         );

//                         if (success) {
//                           Navigator.pop(context);
//                           await context.read<ChatProvider>().loadChats(
//                             currentUserId!,
//                           );
//                         }
//                       },
//                 child: modProv.isLoading
//                     ? const CircularProgressIndicator(strokeWidth: 2)
//                     : const Text('Block', style: TextStyle(color: Colors.red)),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }









// import 'package:dating_app/providers/ChatMessage/chat_message_provider.dart';
// import 'package:dating_app/providers/MyChat/chat_provider.dart';
// import 'package:dating_app/views/chat/chat_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MessagesScreen extends StatefulWidget {
//   const MessagesScreen({super.key});

//   @override
//   State<MessagesScreen> createState() => _MessagesScreenState();
// }

// class _MessagesScreenState extends State<MessagesScreen>
//     with SingleTickerProviderStateMixin {
//   String? currentUserId;
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//     _loadInitial();
//   }

//   Future<void> _loadInitial() async {
//     final prefs = await SharedPreferences.getInstance();
//     currentUserId = prefs.getString('userId');

//     if (currentUserId != null) {
//       await _refreshAll();
//     }
//   }

//   Future<void> _refreshAll() async {
//     await context.read<ChatProvider>().loadChats(currentUserId!);
//     await context.read<RandomUserProvider>().loadRandomUsers(currentUserId!);
//     await context
//         .read<PendingRequestProvider>()
//         .load(currentUserId!);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffFFF3F8),
//       appBar: AppBar(
//         backgroundColor: const Color(0xffFFF3F8),
//         elevation: 0,
//         title: const Text(
//           'Messages',
//           style: TextStyle(color: Colors.black),
//         ),
//         bottom: TabBar(
//           controller: _tabController,
//           indicatorColor: const Color(0xffFE0A62),
//           labelColor: const Color(0xffFE0A62),
//           unselectedLabelColor: Colors.black54,
//           tabs: const [
//             Tab(text: 'Discover'),
//             Tab(text: 'Chats'),
//             Tab(text: 'Pending'),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           _discoverTab(),
//           _chatTab(),
//           _pendingTab(),
//         ],
//       ),
//     );
//   }

//   // --------------------------------------------------
//   // 🔹 DISCOVER TAB (RANDOM USERS)
//   // --------------------------------------------------
//   Widget _discoverTab() {
//     return Consumer<RandomUserProvider>(
//       builder: (_, prov, __) {
//         if (prov.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (prov.users.isEmpty) {
//           return const Center(child: Text('No users found'));
//         }

//         return ListView.builder(
//           itemCount: prov.users.length,
//           itemBuilder: (_, i) {
//             final user = prov.users[i];

//             return ListTile(
//               leading: CircleAvatar(
//                 backgroundImage: NetworkImage(user.profileImage),
//               ),
//               title: Text(user.name),
//               subtitle: Text(user.nickname),
//               trailing: user.isFollow
//                   ? const Text('Following')
//                   : const Text('Follow'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => ChangeNotifierProvider(
//                       create: (_) => ChatMessageProvider(),
//                       child: Chatwithpeople(
//                         currentUserId: currentUserId!,
//                         otherUserId: user.id,
//                         otherUserName: user.name,
//                         otherUserImage: user.profileImage,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         );
//       },
//     );
//   }

//   // --------------------------------------------------
//   // 🔹 CHAT TAB (MY CHATS)
//   // --------------------------------------------------
//   Widget _chatTab() {
//     return Consumer<ChatProvider>(
//       builder: (_, prov, __) {
//         final chats =
//             prov.chats.where((c) => c.isBlocked == false).toList();

//         if (prov.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (chats.isEmpty) {
//           return const Center(child: Text('No conversations yet'));
//         }

//         return ListView.builder(
//           itemCount: chats.length,
//           itemBuilder: (_, i) {
//             final chat = chats[i];

//             return Card(
//               margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               child: ListTile(
//                 leading: CircleAvatar(
//                   backgroundImage: NetworkImage(chat.profileImage),
//                 ),
//                 title: Text(chat.name),
//                 subtitle: Text(
//                   chat.isChatApproved
//                       ? chat.lastMessage
//                       : 'Chat request pending approval',
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 trailing: chat.isChatApproved
//                     ? Text(
//                         "${chat.lastMessageTime.hour}:${chat.lastMessageTime.minute.toString().padLeft(2, '0')}",
//                         style: const TextStyle(fontSize: 12),
//                       )
//                     : ElevatedButton(
//                         onPressed: () {
//                           _tabController.animateTo(2);
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xffFE0A62),
//                         ),
//                         child: const Text(
//                           'Go to Pending',
//                           style: TextStyle(fontSize: 12),
//                         ),
//                       ),
//                 onTap: chat.isChatApproved
//                     ? () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => ChangeNotifierProvider(
//                               create: (_) => ChatMessageProvider(),
//                               child: Chatwithpeople(
//                                 currentUserId: currentUserId!,
//                                 otherUserId: chat.userId,
//                                 otherUserName: chat.name,
//                                 otherUserImage: chat.profileImage,
//                               ),
//                             ),
//                           ),
//                         );
//                       }
//                     : null,
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   // --------------------------------------------------
//   // 🔹 PENDING REQUEST TAB
//   // --------------------------------------------------
//   Widget _pendingTab() {
//     return Consumer<PendingRequestProvider>(
//       builder: (_, prov, __) {
//         if (prov.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (prov.requests.isEmpty) {
//           return const Center(child: Text('No pending requests'));
//         }

//         return ListView.builder(
//           itemCount: prov.requests.length,
//           itemBuilder: (_, i) {
//             final r = prov.requests[i];

//             return Card(
//               margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               child: ListTile(
//                 leading: CircleAvatar(
//                   backgroundImage: NetworkImage(r.profileImage),
//                 ),
//                 title: Text(r.name),
//                 subtitle: const Text('Wants to chat with you'),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon:
//                           const Icon(Icons.close, color: Colors.red),
//                       onPressed: () async {
//                         await prov.handle(
//                           r.requestId,
//                           'reject',
//                           currentUserId!,
//                         );
//                         await _refreshAll();
//                       },
//                     ),
//                     IconButton(
//                       icon:
//                           const Icon(Icons.check, color: Colors.green),
//                       onPressed: () async {
//                         await prov.handle(
//                           r.requestId,
//                           'approve',
//                           currentUserId!,
//                         );
//                         await _refreshAll();
//                         _tabController.animateTo(1);
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

























// import 'package:dating_app/providers/ChatMessage/chat_message_provider.dart';
// import 'package:dating_app/providers/MyChat/chat_provider.dart';
// import 'package:dating_app/views/chat/chat_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MessagesScreen extends StatefulWidget {
//   const MessagesScreen({super.key});

//   @override
//   State<MessagesScreen> createState() => _MessagesScreenState();
// }

// class _MessagesScreenState extends State<MessagesScreen>
//     with SingleTickerProviderStateMixin {
//   String? currentUserId;
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//     _loadInitial();
//   }

//   Future<void> _loadInitial() async {
//     final prefs = await SharedPreferences.getInstance();
//     currentUserId = prefs.getString('userId');

//     if (currentUserId != null) {
//       await _refreshAll();
//     }
//   }

//   Future<void> _refreshAll() async {
//     await context.read<ChatProvider>().loadChats(currentUserId!);
//     await context.read<RandomUserProvider>().loadRandomUsers(currentUserId!);
//     await context.read<PendingRequestProvider>().load(currentUserId!);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffFFF3F8),
//       appBar: AppBar(
//         backgroundColor: const Color(0xffFFF3F8),
//         elevation: 0,
//         title: const Text(
//           'Messages',
//           style: TextStyle(color: Colors.black),
//         ),
//         bottom: TabBar(
//           controller: _tabController,
//           indicatorColor: const Color(0xffFE0A62),
//           labelColor: const Color(0xffFE0A62),
//           unselectedLabelColor: Colors.black54,
//           tabs: const [
//             Tab(text: 'Discover'),
//             Tab(text: 'Chats'),
//             Tab(text: 'Pending'),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           _discoverTab(),
//           _chatTab(),
//           _pendingTab(),
//         ],
//       ),
//     );
//   }

//   // --------------------------------------------------
//   // 🔹 DISCOVER TAB
//   // --------------------------------------------------
//   Widget _discoverTab() {
//     return Consumer<RandomUserProvider>(
//       builder: (_, prov, __) {
//         if (prov.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (prov.users.isEmpty) {
//           return const Center(child: Text('No users found'));
//         }

//         return ListView.builder(
//           itemCount: prov.users.length,
//           itemBuilder: (_, i) {
//             final user = prov.users[i];

//             return ListTile(
//               leading: CircleAvatar(
//                 backgroundImage: NetworkImage(user.profileImage),
//               ),
//               title: Text(user.name),
//               subtitle: Text(user.nickname),
//               trailing: user.isFollow
//                   ? const Text('Following')
//                   : const Text('Follow'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => ChangeNotifierProvider(
//                       create: (_) => ChatMessageProvider(),
//                       child: Chatwithpeople(
//                         currentUserId: currentUserId!,
//                         otherUserId: user.id,
//                         otherUserName: user.name,
//                         otherUserImage: user.profileImage,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         );
//       },
//     );
//   }

//   // --------------------------------------------------
//   // 🔹 CHAT TAB (UPDATED LOGIC)
//   // --------------------------------------------------
//   Widget _chatTab() {
//     return Consumer<ChatProvider>(
//       builder: (_, prov, __) {
//         final chats =
//             prov.chats.where((c) => c.isBlocked == false).toList();

//         if (prov.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (chats.isEmpty) {
//           return const Center(child: Text('No conversations yet'));
//         }

//         return ListView.builder(
//           itemCount: chats.length,
//           itemBuilder: (_, i) {
//             final chat = chats[i];

//             /// 🔑 IMPORTANT LOGIC
//             final bool isSender =
//                 chat.senderId == currentUserId;

//                 print("kkkkkkkkkkkkkkkkkkkkhhhhhhhhhhhhhhhhhhhhhh$isSender");
//                                 print("kkkkkkkkkkkkkkkkkkkkhhhhhhhhhhhhhhhhhhhhhh${chat.userId}");

//                 print("kkkkkkkkkkkkkkkkkkkkhhhhhhhhhhhhhhhhhhhhhh$currentUserId");


//             final bool canOpenChat =
//                 chat.isChatApproved || isSender;

//             final bool showPendingButton =
//                 !chat.isChatApproved && !isSender;

//             return Card(
//               margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               child: ListTile(
//                 leading: CircleAvatar(
//                   backgroundImage: NetworkImage(chat.profileImage),
//                 ),
//                 title: Text(chat.name),

//                 /// 🔹 MESSAGE TEXT LOGIC
//                 subtitle: Text(
//                   canOpenChat
//                       ? chat.lastMessage
//                       : 'Chat request pending approval',
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),

//                 /// 🔹 RIGHT SIDE
//                 trailing: showPendingButton
//                     ? ElevatedButton(
//                         onPressed: () {
//                           _tabController.animateTo(2);
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xffFE0A62),
//                         ),
//                         child: const Text(
//                           'Go to Pending',
//                           style: TextStyle(fontSize: 12),
//                         ),
//                       )
//                     : Text(
//                         "${chat.lastMessageTime.hour}:${chat.lastMessageTime.minute.toString().padLeft(2, '0')}",
//                         style: const TextStyle(fontSize: 12),
//                       ),

//                 /// 🔹 TAP LOGIC
//                 onTap: canOpenChat
//                     ? () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => ChangeNotifierProvider(
//                               create: (_) => ChatMessageProvider(),
//                               child: Chatwithpeople(
//                                 currentUserId: currentUserId!,
//                                 otherUserId: chat.userId,
//                                 otherUserName: chat.name,
//                                 otherUserImage: chat.profileImage,
//                               ),
//                             ),
//                           ),
//                         );
//                       }
//                     : null,
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   // --------------------------------------------------
//   // 🔹 PENDING REQUEST TAB
//   // --------------------------------------------------
//   Widget _pendingTab() {
//     return Consumer<PendingRequestProvider>(
//       builder: (_, prov, __) {
//         if (prov.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (prov.requests.isEmpty) {
//           return const Center(child: Text('No pending requests'));
//         }

//         return ListView.builder(
//           itemCount: prov.requests.length,
//           itemBuilder: (_, i) {
//             final r = prov.requests[i];

//             return Card(
//               margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               child: ListTile(
//                 leading: CircleAvatar(
//                   backgroundImage: NetworkImage(r.profileImage),
//                 ),
//                 title: Text(r.name),
//                 subtitle: const Text('Wants to chat with you'),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.close, color: Colors.red),
//                       onPressed: () async {
//                         await prov.handle(
//                           r.requestId,
//                           'reject',
//                           currentUserId!,
//                         );
//                         await _refreshAll();
//                       },
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.check, color: Colors.green),
//                       onPressed: () async {
//                         await prov.handle(
//                           r.requestId,
//                           'approve',
//                           currentUserId!,
//                         );
//                         await _refreshAll();
//                         _tabController.animateTo(1);
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }














// latest..................................................




// import 'package:dating_app/providers/ChatMessage/chat_message_provider.dart';
// import 'package:dating_app/providers/Follow/follow_provider.dart';
// import 'package:dating_app/providers/MyChat/chat_provider.dart';
// import 'package:dating_app/providers/MyChat/pending_request_provider.dart';
// import 'package:dating_app/providers/MyChat/random_user_provider.dart';
// import 'package:dating_app/providers/moderation/moderation_provider.dart';
// import 'package:dating_app/utils/report_helper.dart';
// import 'package:dating_app/views/chat/chat_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MessagesScreen extends StatefulWidget {
//   const MessagesScreen({super.key});

//   @override
//   State<MessagesScreen> createState() => _MessagesScreenState();
// }

// class _MessagesScreenState extends State<MessagesScreen>
//     with SingleTickerProviderStateMixin {
//   String? currentUserId;
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//     _loadInitial();
//   }

//   Future<void> _loadInitial() async {
//     final prefs = await SharedPreferences.getInstance();
//     currentUserId = prefs.getString('userId');
//     if (currentUserId != null) {
//       await _refreshAll();
//     }
//   }

//   Future<void> _refreshAll() async {
//     await context.read<ChatProvider>().loadChats(currentUserId!);
//     await context.read<RandomUserProvider>().loadRandomUsers(currentUserId!);
//     await context.read<PendingRequestProvider>().load(currentUserId!);
//   }

//   // =====================================================
//   // UI
//   // =====================================================

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffFFF3F8),
//       appBar: AppBar(
//         backgroundColor: const Color(0xffFFF3F8),
//         elevation: 0,
//         title: const Text('Messages', style: TextStyle(color: Colors.black)),
//         bottom: TabBar(
//           controller: _tabController,
//           indicatorColor: const Color(0xffFE0A62),
//           labelColor: const Color(0xffFE0A62),
//           unselectedLabelColor: Colors.black54,
//           tabs: const [
//             Tab(text: 'Discover'),
//             Tab(text: 'Chats'),
//             Tab(text: 'Pending'),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           _discoverTab(),
//           _chatTab(),
//           _pendingTab(),
//         ],
//       ),
//     );
//   }

//   // =====================================================
//   // DISCOVER TAB
//   // =====================================================

//   Widget _discoverTab() {
//     return Consumer<RandomUserProvider>(
//       builder: (_, prov, __) {
//         if (prov.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (prov.users.isEmpty) {
//           return const Center(child: Text('No users found'));
//         }

//         return ListView.builder(
//           itemCount: prov.users.length,
//           itemBuilder: (_, i) {
//             final user = prov.users[i];
//             return ListTile(
//               leading: CircleAvatar(
//                 backgroundImage: NetworkImage(user.profileImage),
//               ),
//               title: Text(user.name),
//               subtitle: Text(user.nickname),
//               trailing:
//                   user.isFollow ? const Text('Following') : const Text('Follow'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => ChangeNotifierProvider(
//                       create: (_) => ChatMessageProvider(),
//                       child: ChatWithPeople(
//                         currentUserId: currentUserId!,
//                         otherUserId: user.id,
//                         otherUserName: user.name,
//                         otherUserImage: user.profileImage,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         );
//       },
//     );
//   }

//   // =====================================================
//   // CHAT TAB (WITH 3 DOT MENU)
//   // =====================================================

//   Widget _chatTab() {
//     return Consumer<ChatProvider>(
//       builder: (_, prov, __) {
//         final chats =
//             prov.chats.where((c) => c.isBlocked != true).toList();

//         if (prov.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (chats.isEmpty) {
//           return const Center(child: Text('No conversations yet'));
//         }

//         return ListView.builder(
//           itemCount: chats.length,
//           itemBuilder: (_, i) {
//             final chat = chats[i];

//             final bool isSender = chat.senderId == currentUserId;
//             final bool canOpenChat = chat.isChatApproved || isSender;
//             final bool showPendingButton =
//                 !chat.isChatApproved && !isSender;

//             return Card(
//               margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               child: ListTile(
//                 leading: CircleAvatar(
//                   backgroundImage: NetworkImage(chat.profileImage),
//                 ),
//                 title: Text(chat.name),
//                 subtitle: Text(
//                   canOpenChat
//                       ? chat.lastMessage
//                       : 'Chat request pending approval',
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),

//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     showPendingButton
//                         ? ElevatedButton(
//                             onPressed: () {
//                               _tabController.animateTo(2);
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xffFE0A62),
//                             ),
//                             child: const Text(
//                               'Go to Pending',
//                               style: TextStyle(fontSize: 12),
//                             ),
//                           )
//                         : Text(
//                             "${chat.lastMessageTime.hour}:${chat.lastMessageTime.minute.toString().padLeft(2, '0')}",
//                             style: const TextStyle(fontSize: 12),
//                           ),

//                     PopupMenuButton<String>(
//                       icon: const Icon(Icons.more_vert, size: 18),
//                       onSelected: (value) {
//                         if (value == 'block') {
//                           _confirmBlock(chat.userId);
//                         } else if (value == 'report') {
//                           ReportHelper.show(
//                             context: context,
//                             reportedBy: currentUserId!,
//                             reportedUser: chat.userId,
//                             reportType: "Message",
//                           );
//                         }
//                       },
//                       itemBuilder: (_) => const [
//                         PopupMenuItem(
//                           value: 'block',
//                           child: Text('Block'),
//                         ),
//                         PopupMenuItem(
//                           value: 'report',
//                           child: Text('Report'),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),

//                 onTap: canOpenChat
//                     ? () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => ChangeNotifierProvider(
//                               create: (_) => ChatMessageProvider(),
//                               child: ChatWithPeople(
//                                 currentUserId: currentUserId!,
//                                 otherUserId: chat.userId,
//                                 otherUserName: chat.name,
//                                 otherUserImage: chat.profileImage,
//                               ),
//                             ),
//                           ),
//                         );
//                       }
//                     : null,
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   // =====================================================
//   // PENDING TAB (WITH 3 DOT MENU)
//   // =====================================================

//   Widget _pendingTab() {
//     return Consumer<PendingRequestProvider>(
//       builder: (_, prov, __) {
//         if (prov.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (prov.requests.isEmpty) {
//           return const Center(child: Text('No pending requests'));
//         }

//         return ListView.builder(
//           itemCount: prov.requests.length,
//           itemBuilder: (_, i) {
//             final r = prov.requests[i];

//             return Card(
//               margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               child: ListTile(
//                 leading: CircleAvatar(
//                   backgroundImage: NetworkImage(r.profileImage),
//                 ),
//                 title: Text(r.name),
//                 subtitle: const Text('Wants to chat with you'),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.close, color: Colors.red),
//                       onPressed: () async {
//                         await prov.handle(
//                           r.requestId,
//                           'reject',
//                           currentUserId!,
//                         );
//                         await _refreshAll();
//                       },
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.check, color: Colors.green),
//                       onPressed: () async {
//                         await prov.handle(
//                           r.requestId,
//                           'approve',
//                           currentUserId!,
//                         );
//                         await _refreshAll();
//                         _tabController.animateTo(1);
//                       },
//                     ),
//                     PopupMenuButton<String>(
//                       icon: const Icon(Icons.more_vert, size: 18),
//                       onSelected: (value) {
//                         if (value == 'block') {
//                           _confirmBlock(r.userId);
//                         } else if (value == 'report') {
//                           ReportHelper.show(
//                             context: context,
//                             reportedBy: currentUserId!,
//                             reportedUser: r.userId,
//                             reportType: "Message",
//                           );
//                         }
//                       },
//                       itemBuilder: (_) => const [
//                         PopupMenuItem(
//                           value: 'block',
//                           child: Text('Block'),
//                         ),
//                         PopupMenuItem(
//                           value: 'report',
//                           child: Text('Report'),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   // =====================================================
//   // BLOCK CONFIRMATION
//   // =====================================================

//   void _confirmBlock(String otherUserId) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Block user?'),
//         content:
//             const Text('You will no longer receive messages from this user.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           Consumer<ModerationProvider>(
//             builder: (_, modProv, __) {
//               return TextButton(
//                 onPressed: modProv.isLoading
//                     ? null
//                     : () async {
//                         final success = await modProv.block(
//                           fromUser: currentUserId!,
//                           toUser: otherUserId,
//                         );
//                         if (success) {
//                           Navigator.pop(context);
//                           await _refreshAll();
//                         }
//                       },
//                 child: modProv.isLoading
//                     ? const CircularProgressIndicator(strokeWidth: 2)
//                     : const Text('Block',
//                         style: TextStyle(color: Colors.red)),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }


















// import 'package:dating_app/providers/ChatMessage/chat_message_provider.dart';
// import 'package:dating_app/providers/Follow/follow_provider.dart';
// import 'package:dating_app/providers/MyChat/chat_provider.dart';
// import 'package:dating_app/providers/MyChat/pending_request_provider.dart';
// import 'package:dating_app/providers/MyChat/random_user_provider.dart';
// import 'package:dating_app/providers/moderation/moderation_provider.dart';
// import 'package:dating_app/utils/report_helper.dart';
// import 'package:dating_app/views/chat/chat_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MessagesScreen extends StatefulWidget {
//   const MessagesScreen({super.key});

//   @override
//   State<MessagesScreen> createState() => _MessagesScreenState();
// }

// class _MessagesScreenState extends State<MessagesScreen>
//     with SingleTickerProviderStateMixin {
//   String? currentUserId;
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//     _loadInitial();
//   }

//   Future<void> _loadInitial() async {
//     final prefs = await SharedPreferences.getInstance();
//     currentUserId = prefs.getString('userId');
//     if (currentUserId != null) {
//       await _refreshAll();
//     }
//   }

//   Future<void> _refreshAll() async {
//     await context.read<ChatProvider>().loadChats(currentUserId!);
//     await context.read<RandomUserProvider>().loadRandomUsers(currentUserId!);
//     await context.read<PendingRequestProvider>().load(currentUserId!);
//   }

//   // =====================================================
//   // UI
//   // =====================================================

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffFFF3F8),
//       appBar: AppBar(
//         backgroundColor: const Color(0xffFFF3F8),
//         elevation: 0,
//         title: const Text('Messages', style: TextStyle(color: Colors.black)),
//         bottom: TabBar(
//           controller: _tabController,
//           indicatorColor: const Color(0xffFE0A62),
//           labelColor: const Color(0xffFE0A62),
//           unselectedLabelColor: Colors.black54,
//           tabs: const [
//             Tab(text: 'Discover'),
//             Tab(text: 'Chats'),
//             Tab(text: 'Pending'),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           _discoverTab(),
//           _chatTab(),
//           _pendingTab(),
//         ],
//       ),
//     );
//   }

//   // =====================================================
//   // DISCOVER TAB
//   // =====================================================

//   Widget _discoverTab() {
//     return Consumer<RandomUserProvider>(
//       builder: (_, prov, __) {
//         if (prov.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (prov.users.isEmpty) {
//           return const Center(child: Text('No users found'));
//         }

//         return ListView.builder(
//           itemCount: prov.users.length,
//           itemBuilder: (_, i) {
//             final user = prov.users[i];

//             return ListTile(
//               leading: CircleAvatar(
//                 backgroundImage: NetworkImage(user.profileImage),
//               ),
//               title: Text(user.name),
//               subtitle: Text(user.nickname),
//               trailing: _followButton(
//                 isFollowing: user.isFollow,
//                 followId: user.id,
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => ChangeNotifierProvider(
//                       create: (_) => ChatMessageProvider(),
//                       child: ChatWithPeople(
//                         currentUserId: currentUserId!,
//                         otherUserId: user.id,
//                         otherUserName: user.name,
//                         otherUserImage: user.profileImage,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         );
//       },
//     );
//   }

//   // =====================================================
//   // CHAT TAB (WITH FOLLOW BUTTON)
//   // =====================================================

//   Widget _chatTab() {
//     return Consumer<ChatProvider>(
//       builder: (_, prov, __) {
//         final chats =
//             prov.chats.where((c) => c.isBlocked != true).toList();

//         if (prov.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (chats.isEmpty) {
//           return const Center(child: Text('No conversations yet'));
//         }

//         return ListView.builder(
//           itemCount: chats.length,
//           itemBuilder: (_, i) {
//             final chat = chats[i];

//             final bool isSender = chat.senderId == currentUserId;
//             final bool canOpenChat = chat.isChatApproved || isSender;
//             final bool showPendingButton =
//                 !chat.isChatApproved && !isSender;

//             return Card(
//   margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//   child: Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//     child: Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         /// AVATAR
//         CircleAvatar(
//           radius: 22,
//           backgroundImage: NetworkImage(chat.profileImage),
//         ),

//         const SizedBox(width: 12),

//         /// NAME + MESSAGE
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 chat.name,
//                 style: const TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 canOpenChat
//                     ? chat.lastMessage
//                     : 'Chat request pending approval',
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(fontSize: 13, color: Colors.grey),
//               ),
//             ],
//           ),
//         ),

//         const SizedBox(width: 8),

//         /// RIGHT SIDE (SAFE)
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Text(
//               "${chat.lastMessageTime.hour}:${chat.lastMessageTime.minute.toString().padLeft(2, '0')}",
//               style: const TextStyle(fontSize: 11, color: Colors.grey),
//             ),

//             const SizedBox(height: 6),

//             Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 _followButton(
//                   isFollowing: chat.isFollowing,
//                   followId: chat.userId,
//                   compact: true,
//                 ),
//                 PopupMenuButton<String>(
//                   icon: const Icon(Icons.more_vert, size: 18),
//                   onSelected: (value) {
//                     if (value == 'block') {
//                       _confirmBlock(chat.userId);
//                     } else if (value == 'report') {
//                       ReportHelper.show(
//                         context: context,
//                         reportedBy: currentUserId!,
//                         reportedUser: chat.userId,
//                         reportType: "Message",
//                       );
//                     }
//                   },
//                   itemBuilder: (_) => const [
//                     PopupMenuItem(value: 'block', child: Text('Block')),
//                     PopupMenuItem(value: 'report', child: Text('Report')),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ],
//     ),
//   ),
// );

//           },
//         );
//       },
//     );
//   }

//   // =====================================================
//   // PENDING TAB
//   // =====================================================

//   Widget _pendingTab() {
//     return Consumer<PendingRequestProvider>(
//       builder: (_, prov, __) {
//         if (prov.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (prov.requests.isEmpty) {
//           return const Center(child: Text('No pending requests'));
//         }

//         return ListView.builder(
//           itemCount: prov.requests.length,
//           itemBuilder: (_, i) {
//             final r = prov.requests[i];

//             return Card(
//               margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               child: ListTile(
//                 leading: CircleAvatar(
//                   backgroundImage: NetworkImage(r.profileImage),
//                 ),
//                 title: Text(r.name),
//                 subtitle: const Text('Wants to chat with you'),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.close, color: Colors.red),
//                       onPressed: () async {
//                         await prov.handle(
//                           r.requestId,
//                           'reject',
//                           currentUserId!,
//                         );
//                         await _refreshAll();
//                       },
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.check, color: Colors.green),
//                       onPressed: () async {
//                         await prov.handle(
//                           r.requestId,
//                           'approve',
//                           currentUserId!,
//                         );
//                         await _refreshAll();
//                         _tabController.animateTo(1);
//                       },
//                     ),
//                     PopupMenuButton<String>(
//                       icon: const Icon(Icons.more_vert, size: 18),
//                       onSelected: (value) {
//                         if (value == 'block') {
//                           _confirmBlock(r.userId);
//                         } else if (value == 'report') {
//                           ReportHelper.show(
//                             context: context,
//                             reportedBy: currentUserId!,
//                             reportedUser: r.userId,
//                             reportType: "Message",
//                           );
//                         }
//                       },
//                       itemBuilder: (_) => const [
//                         PopupMenuItem(
//                           value: 'block',
//                           child: Text('Block'),
//                         ),
//                         PopupMenuItem(
//                           value: 'report',
//                           child: Text('Report'),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   // =====================================================
//   // FOLLOW BUTTON (REUSABLE)
//   // =====================================================

//   Widget _followButton({
//     required bool isFollowing,
//     required String followId,
//     bool compact = false,
//   }) {
//     return Consumer<FollowProvider>(
//       builder: (_, followProv, __) {
//         return GestureDetector(
//           onTap: isFollowing || followProv.isLoading
//               ? null
//               : () async {
//                   final success = await followProv.follow(
//                     userId: currentUserId!,
//                     followId: followId,
//                   );
//                   if (success) {
//                     await _refreshAll();
//                   }
//                 },
//           child: Container(
//             padding: EdgeInsets.symmetric(
//               horizontal: compact ? 8 : 12,
//               vertical: compact ? 4 : 6,
//             ),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               color: isFollowing
//                   ? Colors.grey.shade300
//                   : Colors.transparent,
//               border: Border.all(
//                 color: isFollowing
//                     ? Colors.transparent
//                     : const Color(0xffFE0A62),
//               ),
//             ),
//             child: followProv.isLoading
//                 ? const SizedBox(
//                     height: 12,
//                     width: 12,
//                     child: CircularProgressIndicator(strokeWidth: 2),
//                   )
//                 : Text(
//                     isFollowing ? 'Following' : 'Follow',
//                     style: TextStyle(
//                       fontSize: compact ? 11 : 12,
//                       color: isFollowing
//                           ? Colors.black
//                           : const Color(0xffFE0A62),
//                     ),
//                   ),
//           ),
//         );
//       },
//     );
//   }

//   // =====================================================
//   // BLOCK
//   // =====================================================

//   void _confirmBlock(String otherUserId) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Block user?'),
//         content:
//             const Text('You will no longer receive messages from this user.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           Consumer<ModerationProvider>(
//             builder: (_, modProv, __) {
//               return TextButton(
//                 onPressed: modProv.isLoading
//                     ? null
//                     : () async {
//                         final success = await modProv.block(
//                           fromUser: currentUserId!,
//                           toUser: otherUserId,
//                         );
//                         if (success) {
//                           Navigator.pop(context);
//                           await _refreshAll();
//                         }
//                       },
//                 child: modProv.isLoading
//                     ? const CircularProgressIndicator(strokeWidth: 2)
//                     : const Text('Block',
//                         style: TextStyle(color: Colors.red)),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }









// import 'package:dating_app/providers/ChatMessage/chat_message_provider.dart';
// import 'package:dating_app/providers/Follow/follow_provider.dart';
// import 'package:dating_app/providers/MyChat/chat_provider.dart';
// import 'package:dating_app/providers/MyChat/pending_request_provider.dart';
// import 'package:dating_app/providers/MyChat/random_user_provider.dart';
// import 'package:dating_app/providers/moderation/moderation_provider.dart';
// import 'package:dating_app/utils/report_helper.dart';
// import 'package:dating_app/views/chat/chat_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MessagesScreen extends StatefulWidget {
//   const MessagesScreen({super.key});

//   @override
//   State<MessagesScreen> createState() => _MessagesScreenState();
// }

// class _MessagesScreenState extends State<MessagesScreen>
//     with SingleTickerProviderStateMixin {
//   String? currentUserId;
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//     _loadInitial();
//   }

//   Future<void> _loadInitial() async {
//     final prefs = await SharedPreferences.getInstance();
//     currentUserId = prefs.getString('userId');
//     if (currentUserId != null) {
//       await _refreshAll();
//     }
//   }

//   Future<void> _refreshAll() async {
//     await context.read<ChatProvider>().loadChats(currentUserId!);
//     await context.read<RandomUserProvider>().loadRandomUsers(currentUserId!);
//     await context.read<PendingRequestProvider>().load(currentUserId!);
//   }

//   // =====================================================
//   // UI
//   // =====================================================

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffFFF3F8),
//       appBar: AppBar(
//         backgroundColor: const Color(0xffFFF3F8),
//         elevation: 0,
//         title: const Text('Messages', style: TextStyle(color: Colors.black)),
//         bottom: TabBar(
//           controller: _tabController,
//           indicatorColor: const Color(0xffFE0A62),
//           labelColor: const Color(0xffFE0A62),
//           unselectedLabelColor: Colors.black54,
//           tabs: const [
//             Tab(text: 'Discover'),
//             Tab(text: 'Chats'),
//             Tab(text: 'Pending'),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           _discoverTab(),
//           _chatTab(),
//           _pendingTab(),
//         ],
//       ),
//     );
//   }

//   // =====================================================
//   // CHAT TAB (FIXED FOLLOW + NAVIGATION)
//   // =====================================================

//   Widget _chatTab() {
//     return Consumer<ChatProvider>(
//       builder: (_, prov, __) {
//         final chats =
//             prov.chats.where((c) => c.isBlocked != true).toList();

//         if (prov.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (chats.isEmpty) {
//           return const Center(child: Text('No conversations yet'));
//         }

//         return ListView.builder(
//           itemCount: chats.length,
//           itemBuilder: (_, i) {
//             final chat = chats[i];
//             final bool canOpenChat = chat.isChatApproved == true;

//             return GestureDetector(
//               onTap: canOpenChat
//                   ? () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => ChangeNotifierProvider(
//                             create: (_) => ChatMessageProvider(),
//                             child: ChatWithPeople(
//                               currentUserId: currentUserId!,
//                               otherUserId: chat.userId,
//                               otherUserName: chat.name,
//                               otherUserImage: chat.profileImage,
//                             ),
//                           ),
//                         ),
//                       );
//                     }
//                   : null,
//               child: Card(
//                 margin:
//                     const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                   child: Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 22,
//                         backgroundImage: NetworkImage(chat.profileImage),
//                       ),
//                       const SizedBox(width: 12),

//                       /// NAME + MESSAGE
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               chat.name,
//                               style: const TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               canOpenChat
//                                   ? chat.lastMessage
//                                   : 'Chat request pending approval',
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: const TextStyle(
//                                 fontSize: 13,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       const SizedBox(width: 8),

//                       /// RIGHT SIDE
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text(
//                             "${chat.lastMessageTime.hour}:${chat.lastMessageTime.minute.toString().padLeft(2, '0')}",
//                             style: const TextStyle(
//                               fontSize: 11,
//                               color: Colors.grey,
//                             ),
//                           ),
//                           const SizedBox(height: 6),
//                           Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               _followButton(
//                                 isFollowing: chat.isFollow,
//                                 followId: chat.userId,
//                               ),
//                               PopupMenuButton<String>(
//                                 icon:
//                                     const Icon(Icons.more_vert, size: 18),
//                                 onSelected: (value) {
//                                   if (value == 'block') {
//                                     _confirmBlock(chat.userId);
//                                   } else if (value == 'report') {
//                                     ReportHelper.show(
//                                       context: context,
//                                       reportedBy: currentUserId!,
//                                       reportedUser: chat.userId,
//                                       reportType: "Message",
//                                     );
//                                   }
//                                 },
//                                 itemBuilder: (_) => const [
//                                   PopupMenuItem(
//                                       value: 'block', child: Text('Block')),
//                                   PopupMenuItem(
//                                       value: 'report', child: Text('Report')),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }


  
//   Widget _discoverTab() {
//     return Consumer<RandomUserProvider>(
//       builder: (_, prov, __) {
//         if (prov.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (prov.users.isEmpty) {
//           return const Center(child: Text('No users found'));
//         }

//         return ListView.builder(
//           itemCount: prov.users.length,
//           itemBuilder: (_, i) {
//             final user = prov.users[i];

//             return ListTile(
//               leading: CircleAvatar(
//                 backgroundImage: NetworkImage(user.profileImage),
//               ),
//               title: Text(user.name),
//               subtitle: Text(user.nickname),
//               trailing: _followButton(
//                 isFollowing: user.isFollow,
//                 followId: user.id,
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => ChangeNotifierProvider(
//                       create: (_) => ChatMessageProvider(),
//                       child: ChatWithPeople(
//                         currentUserId: currentUserId!,
//                         otherUserId: user.id,
//                         otherUserName: user.name,
//                         otherUserImage: user.profileImage,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         );
//       },
//     );
//   }

//   // =====================================================
//   // FOLLOW / UNFOLLOW BUTTON (FIXED)
//   // =====================================================

//   Widget _followButton({
//     required bool isFollowing,
//     required String followId,
//   }) {
//     return Consumer<FollowProvider>(
//       builder: (_, followProv, __) {
//         return GestureDetector(
//           onTap: followProv.isLoading
//               ? null
//               : () async {
//                   bool success;
//                   if (isFollowing) {
//                     success = await followProv.unfollow(
//                       userId: currentUserId!,
//                       unfollowId: followId,
//                     );
//                   } else {
//                     success = await followProv.follow(
//                       userId: currentUserId!,
//                       followId: followId,
//                     );
//                   }

//                   if (success) {
//                     await _refreshAll();
//                   }
//                 },
//           child: Container(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               color:
//                   isFollowing ? Colors.grey.shade300 : Colors.transparent,
//               border: Border.all(
//                 color: isFollowing
//                     ? Colors.transparent
//                     : const Color(0xffFE0A62),
//               ),
//             ),
//             child: followProv.isLoading
//                 ? const SizedBox(
//                     height: 12,
//                     width: 12,
//                     child: CircularProgressIndicator(strokeWidth: 2),
//                   )
//                 : Text(
//                     isFollowing ? 'Following' : 'Follow',
//                     style: TextStyle(
//                       fontSize: 11,
//                       color: isFollowing
//                           ? Colors.black
//                           : const Color(0xffFE0A62),
//                     ),
//                   ),
//           ),
//         );
//       },
//     );
//   }

//   // =====================================================
//   // PENDING TAB (UNCHANGED)
//   // =====================================================

//   Widget _pendingTab() {
//     return Consumer<PendingRequestProvider>(
//       builder: (_, prov, __) {
//         if (prov.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (prov.requests.isEmpty) {
//           return const Center(child: Text('No pending requests'));
//         }

//         return ListView.builder(
//           itemCount: prov.requests.length,
//           itemBuilder: (_, i) {
//             final r = prov.requests[i];

//             return Card(
//               margin:
//                   const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               child: ListTile(
//                 leading: CircleAvatar(
//                   backgroundImage: NetworkImage(r.profileImage),
//                 ),
//                 title: Text(r.name),
//                 subtitle: const Text('Wants to chat with you'),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon:
//                           const Icon(Icons.close, color: Colors.red),
//                       onPressed: () async {
//                         await prov.handle(
//                           r.requestId,
//                           'reject',
//                           currentUserId!,
//                         );
//                         await _refreshAll();
//                       },
//                     ),
//                     IconButton(
//                       icon:
//                           const Icon(Icons.check, color: Colors.green),
//                       onPressed: () async {
//                         await prov.handle(
//                           r.requestId,
//                           'approve',
//                           currentUserId!,
//                         );
//                         await _refreshAll();
//                         _tabController.animateTo(1);
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   // =====================================================
//   // BLOCK
//   // =====================================================

//   void _confirmBlock(String otherUserId) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Block user?'),
//         content:
//             const Text('You will no longer receive messages from this user.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           Consumer<ModerationProvider>(
//             builder: (_, modProv, __) {
//               return TextButton(
//                 onPressed: modProv.isLoading
//                     ? null
//                     : () async {
//                         final success = await modProv.block(
//                           fromUser: currentUserId!,
//                           toUser: otherUserId,
//                         );
//                         if (success) {
//                           Navigator.pop(context);
//                           await _refreshAll();
//                         }
//                       },
//                 child: modProv.isLoading
//                     ? const CircularProgressIndicator(strokeWidth: 2)
//                     : const Text('Block',
//                         style: TextStyle(color: Colors.red)),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }







// import 'package:dating_app/providers/ChatMessage/chat_message_provider.dart';
// import 'package:dating_app/providers/Follow/follow_provider.dart';
// import 'package:dating_app/providers/MyChat/chat_provider.dart';
// import 'package:dating_app/providers/MyChat/pending_request_provider.dart';
// import 'package:dating_app/providers/MyChat/random_user_provider.dart';
// import 'package:dating_app/providers/moderation/moderation_provider.dart';
// import 'package:dating_app/utils/report_helper.dart';
// import 'package:dating_app/views/chat/chat_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MessagesScreen extends StatefulWidget {
//   const MessagesScreen({super.key});

//   @override
//   State<MessagesScreen> createState() => _MessagesScreenState();
// }

// class _MessagesScreenState extends State<MessagesScreen>
//     with SingleTickerProviderStateMixin {
//   String? currentUserId;
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//     _loadInitial();
//   }

//   Future<void> _loadInitial() async {
//     final prefs = await SharedPreferences.getInstance();
//     currentUserId = prefs.getString('userId');
//     if (currentUserId != null) {
//       await _refreshAll();
//     }
//   }

//   Future<void> _refreshAll() async {
//     await context.read<ChatProvider>().loadChats(currentUserId!);
//     await context.read<RandomUserProvider>().loadRandomUsers(currentUserId!);
//     await context.read<PendingRequestProvider>().load(currentUserId!);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffFFF3F8),
//       appBar: AppBar(
//         backgroundColor: const Color(0xffFFF3F8),
//         elevation: 0,
//         title: const Text('Messages', style: TextStyle(color: Colors.black)),
//         bottom: TabBar(
//           controller: _tabController,
//           indicatorColor: const Color(0xffFE0A62),
//           labelColor: const Color(0xffFE0A62),
//           unselectedLabelColor: Colors.black54,
//           tabs: const [
//             Tab(text: 'Discover'),
//             Tab(text: 'Chats'),
//             Tab(text: 'Pending'),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           _discoverTab(),
//           _chatTab(),
//           _pendingTab(),
//         ],
//       ),
//     );
//   }

//   // =====================================================
//   // CHAT TAB (UPDATED 3 DOTS MENU)
//   // =====================================================

//   Widget _chatTab() {
//     return Consumer<ChatProvider>(
//       builder: (_, prov, __) {
//         final chats =
//             prov.chats.where((c) => c.isBlocked != true).toList();

//         if (prov.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (chats.isEmpty) {
//           return const Center(child: Text('No conversations yet'));
//         }

//         return ListView.builder(
//           itemCount: chats.length,
//           itemBuilder: (_, i) {
//             final chat = chats[i];
//             final bool canOpenChat = chat.isChatApproved == true;

//             return GestureDetector(
//               onTap: canOpenChat
//                   ? () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => ChangeNotifierProvider(
//                             create: (_) => ChatMessageProvider(),
//                             child: ChatWithPeople(
//                               currentUserId: currentUserId!,
//                               otherUserId: chat.userId,
//                               otherUserName: chat.name,
//                               otherUserImage: chat.profileImage,
//                             ),
//                           ),
//                         ),
//                       );
//                     }
//                   : null,
//               child: Card(
//                 margin:
//                     const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                   child: Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 22,
//                         backgroundImage: NetworkImage(chat.profileImage),
//                       ),
//                       const SizedBox(width: 12),

//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               chat.name,
//                               style: const TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               canOpenChat
//                                   ? chat.lastMessage
//                                   : 'Chat request pending approval',
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: const TextStyle(
//                                 fontSize: 13,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       const SizedBox(width: 8),

//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text(
//                             "${chat.lastMessageTime.hour}:${chat.lastMessageTime.minute.toString().padLeft(2, '0')}",
//                             style: const TextStyle(
//                               fontSize: 11,
//                               color: Colors.grey,
//                             ),
//                           ),
//                           const SizedBox(height: 6),

//                           Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               _followButton(
//                                 isFollowing: chat.isFollow,
//                                 followId: chat.userId,
//                               ),

//                               PopupMenuButton<String>(
//                                 icon:
//                                     const Icon(Icons.more_vert, size: 18),
//                                 onSelected: (value) async {
//                                   if (value == 'unfollow') {
//                                     final success = await context
//                                         .read<FollowProvider>()
//                                         .unfollow(
//                                           userId: currentUserId!,
//                                           unfollowId: chat.userId,
//                                         );
//                                     if (success) {
//                                       await _refreshAll();
//                                     }
//                                   } else if (value == 'block') {
//                                     _confirmBlock(chat.userId);
//                                   } else if (value == 'report') {
//                                     ReportHelper.show(
//                                       context: context,
//                                       reportedBy: currentUserId!,
//                                       reportedUser: chat.userId,
//                                       reportType: "Message",
//                                     );
//                                   }
//                                 },
//                                 itemBuilder: (_) => [
//                                   if (chat.isFollow)
//                                     const PopupMenuItem(
//                                       value: 'unfollow',
//                                       child: Text('Unfollow'),
//                                     ),
//                                   const PopupMenuItem(
//                                     value: 'block',
//                                     child: Text('Block'),
//                                   ),
//                                   const PopupMenuItem(
//                                     value: 'report',
//                                     child: Text('Report'),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   // =====================================================
//   // DISCOVER TAB
//   // =====================================================

//   Widget _discoverTab() {
//     return Consumer<RandomUserProvider>(
//       builder: (_, prov, __) {
//         if (prov.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (prov.users.isEmpty) {
//           return const Center(child: Text('No users found'));
//         }

//         return ListView.builder(
//           itemCount: prov.users.length,
//           itemBuilder: (_, i) {
//             final user = prov.users[i];

//             return ListTile(
//               leading: CircleAvatar(
//                 backgroundImage: NetworkImage(user.profileImage),
//               ),
//               title: Text(user.name),
//               subtitle: Text(user.nickname),
//               trailing: _followButton(
//                 isFollowing: user.isFollow,
//                 followId: user.id,
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   // =====================================================
//   // FOLLOW BUTTON
//   // =====================================================

//   Widget _followButton({
//     required bool isFollowing,
//     required String followId,
//   }) {
//     return Consumer<FollowProvider>(
//       builder: (_, followProv, __) {
//         return GestureDetector(
//           onTap: followProv.isLoading
//               ? null
//               : () async {
//                   final success = isFollowing
//                       ? await followProv.unfollow(
//                           userId: currentUserId!,
//                           unfollowId: followId,
//                         )
//                       : await followProv.follow(
//                           userId: currentUserId!,
//                           followId: followId,
//                         );

//                   if (success) {
//                     await _refreshAll();
//                   }
//                 },
//           child: Container(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               color:
//                   isFollowing ? Colors.grey.shade300 : Colors.transparent,
//               border: Border.all(
//                 color: isFollowing
//                     ? Colors.transparent
//                     : const Color(0xffFE0A62),
//               ),
//             ),
//             child: followProv.isLoading
//                 ? const SizedBox(
//                     height: 12,
//                     width: 12,
//                     child: CircularProgressIndicator(strokeWidth: 2),
//                   )
//                 : Text(
//                     isFollowing ? 'Following' : 'Follow',
//                     style: TextStyle(
//                       fontSize: 11,
//                       color: isFollowing
//                           ? Colors.black
//                           : const Color(0xffFE0A62),
//                     ),
//                   ),
//           ),
//         );
//       },
//     );
//   }

//   // =====================================================
//   // PENDING TAB
//   // =====================================================

//   Widget _pendingTab() {
//     return Consumer<PendingRequestProvider>(
//       builder: (_, prov, __) {
//         if (prov.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (prov.requests.isEmpty) {
//           return const Center(child: Text('No pending requests'));
//         }

//         return ListView.builder(
//           itemCount: prov.requests.length,
//           itemBuilder: (_, i) {
//             final r = prov.requests[i];

//             return Card(
//               margin:
//                   const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               child: ListTile(
//                 leading: CircleAvatar(
//                   backgroundImage: NetworkImage(r.profileImage),
//                 ),
//                 title: Text(r.name),
//                 subtitle: const Text('Wants to chat with you'),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon:
//                           const Icon(Icons.close, color: Colors.red),
//                       onPressed: () async {
//                         await prov.handle(
//                           r.requestId,
//                           'reject',
//                           currentUserId!,
//                         );
//                         await _refreshAll();
//                       },
//                     ),
//                     IconButton(
//                       icon:
//                           const Icon(Icons.check, color: Colors.green),
//                       onPressed: () async {
//                         await prov.handle(
//                           r.requestId,
//                           'approve',
//                           currentUserId!,
//                         );
//                         await _refreshAll();
//                         _tabController.animateTo(1);
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   // =====================================================
//   // BLOCK USER
//   // =====================================================

//   void _confirmBlock(String otherUserId) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Block user?'),
//         content:
//             const Text('You will no longer receive messages from this user.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           Consumer<ModerationProvider>(
//             builder: (_, modProv, __) {
//               return TextButton(
//                 onPressed: modProv.isLoading
//                     ? null
//                     : () async {
//                         final success = await modProv.block(
//                           fromUser: currentUserId!,
//                           toUser: otherUserId,
//                         );
//                         if (success) {
//                           Navigator.pop(context);
//                           await _refreshAll();
//                         }
//                       },
//                 child: modProv.isLoading
//                     ? const CircularProgressIndicator(strokeWidth: 2)
//                     : const Text('Block',
//                         style: TextStyle(color: Colors.red)),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }


















import 'package:dating_app/providers/ChatMessage/chat_message_provider.dart';
import 'package:dating_app/providers/Follow/follow_provider.dart';
import 'package:dating_app/providers/MyChat/chat_provider.dart';
import 'package:dating_app/providers/MyChat/pending_request_provider.dart';
import 'package:dating_app/providers/MyChat/random_user_provider.dart';
import 'package:dating_app/providers/moderation/moderation_provider.dart';
import 'package:dating_app/utils/report_helper.dart';
import 'package:dating_app/views/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen>
    with SingleTickerProviderStateMixin {
  String? currentUserId;
  late TabController _tabController;
  bool _showLoader = true;
bool _loadingDone = false;
String? currentUserImage;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadInitial();
  }

Future<void> _loadInitial() async {
  final prefs = await SharedPreferences.getInstance();
  currentUserId = prefs.getString('userId');
  currentUserImage = prefs.getString('userImage');

  if (currentUserId != null && currentUserId!.isNotEmpty) {
    await _refreshAll();
  }

  if (mounted) {
    setState(() {
      _showLoader = false;
      _loadingDone = true;
    });
  }
}


  Future<void> _refreshAll() async {
    await context.read<ChatProvider>().loadChats(currentUserId!);
    await context.read<RandomUserProvider>().loadRandomUsers(currentUserId!);
    await context.read<PendingRequestProvider>().load(currentUserId!);
  }

  @override
  Widget build(BuildContext context) {
      if (_showLoader) {
    return MatchingLoader(
      topImageUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=Match',
      bottomImageUrl: currentUserImage ??
          'https://api.dicebear.com/7.x/avataaars/svg?seed=You',
      loadingText: 'Finding\nConversations & Friends',
      apiCall: _refreshAll,
      onComplete: (_) {
        if (mounted) {
          setState(() {
            _showLoader = false;
          });
        }
      },
      minDisplayDuration: const Duration(seconds: 4),
    );
  }
    return Scaffold(
      // backgroundColor: Colors.black,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
SliverAppBar(
  floating: true,
  pinned: true,
  elevation: 0,
  expandedHeight: 150, // ⬅️ increased height for spacing
  flexibleSpace: FlexibleSpaceBar(
    titlePadding: const EdgeInsets.only(
      left: 60,
      bottom: 100, // ⬅️ spacing between title & tabbar
    ),
    title: const Text(
      'Connections',
      style: TextStyle(
        color: Colors.black,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  bottom: PreferredSize(
    preferredSize: const Size.fromHeight(50),
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TabBar(
        controller: _tabController,

        // remove underline
        indicator: const BoxDecoration(),
        dividerColor: Colors.transparent,

        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey.shade600,
        labelStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        tabs: const [
          Tab(text: 'Discover'),
          Tab(text: 'Chats'),
          Tab(text: 'Pending'),
        ],
      ),
    ),
  ),
),

        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            _discoverTab(),
            _chatTab(),
            _pendingTab(),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // CHAT TAB (MODERN SNAPCHAT-LIKE DESIGN)
  // =====================================================
// =====================================================
// CHAT TAB (LOGIC-CORRECT, UI UNCHANGED)
// =====================================================

Widget _chatTab() {
  return Consumer<ChatProvider>(
    builder: (_, prov, __) {
      final chats = prov.chats.where((c) => c.isBlocked != true).toList();

      if (prov.isLoading) {
        return const Center(
          child: CircularProgressIndicator(
            color: Color(0xffFE0A62),
          ),
        );
      }

      if (chats.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.chat_bubble_outline,
                size: 80,
                color: Colors.grey.shade800,
              ),
              const SizedBox(height: 16),
              Text(
                'No conversations yet',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.only(top: 8),
        itemCount: chats.length,
        itemBuilder: (_, i) {
          final chat = chats[i];

          // ✅ FINAL CORRECT LOGIC
          final bool canOpenChat = chat.isChatApproved == true
              ? true
              : chat.senderId == currentUserId;
print("llllllllllllllllllllllllllllllllllllllllllllllllllllllllll$currentUserId");
print("llllllllllllllllllllllllllllllllllllllllllllllllllllllllll${chat.senderId}");
print("llllllllllllllllllllllllllllllllllllllllllllllllllllllllll${chat.isChatApproved}");
print("llllllllllllllllllllllllllllllllllllllllllllllllllllllllll$canOpenChat");



          return _buildChatItem(chat, canOpenChat);
        },
      );
    },
  );
}

Widget _buildChatItem(dynamic chat, bool canOpenChat) {
  
  return GestureDetector(
  onTap: () {
    if (canOpenChat) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => ChatMessageProvider(),
            child: ChatWithPeople(
              currentUserId: currentUserId!,
              otherUserId: chat.userId,
              otherUserName: chat.name,
              otherUserImage: chat.profileImage,
            ),
          ),
        ),
      );
    } else {
      // ✅ Go to Pending tab
      _tabController.animateTo(2);

      // (optional UX feedback)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Accept the request to start chatting'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xff1C1C1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          /// Avatar
Stack(
  children: [
    Container(
      padding: const EdgeInsets.all(2.5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: canOpenChat
            ? const LinearGradient(
                colors: [Color(0xffFE0A62), Color(0xffFF6B9D)],
              )
            : null,
        border: !canOpenChat
            ? Border.all(color: Colors.grey.shade700, width: 2)
            : null,
      ),
      child: CircleAvatar(
        radius: 28,
        backgroundImage: NetworkImage(chat.profileImage),
      ),
    ),

    // 🟢🔴 ONLINE / OFFLINE DOT
    Positioned(
      bottom: 4,
      right: 4,
      child: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: chat.isOnline == true
              ? Colors.green
              : Colors.grey,
          border: Border.all(
            color: const Color(0xff1C1C1E),
            width: 2,
          ),
        ),
      ),
    ),
  ],
),


          const SizedBox(width: 12),

          /// Name + Message
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chat.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  canOpenChat ? chat.lastMessage : 'Pending approval',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: canOpenChat
                        ? Colors.grey.shade400
                        : Colors.redAccent,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          /// Time + Bell + Actions
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!canOpenChat) ...[
                    const AnimatedBell(),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    "${chat.lastMessageTime.hour}:${chat.lastMessageTime.minute.toString().padLeft(2, '0')}",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _followButton(
                    isFollowing: chat.isFollow,
                    followId: chat.userId,
                  ),
                  const SizedBox(width: 4),
                  _buildChatMenu(chat),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}



  Widget _buildChatMenu(dynamic chat) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_horiz, size: 20, color: Colors.grey.shade600),
      color: const Color(0xff2C2C2E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (value) async {
        if (value == 'unfollow') {
          final success = await context.read<FollowProvider>().unfollow(
                userId: currentUserId!,
                unfollowId: chat.userId,
              );
          if (success) {
            await _refreshAll();
          }
        } else if (value == 'block') {
          _confirmBlock(chat.userId);
        } else if (value == 'report') {
          ReportHelper.show(
            context: context,
            reportedBy: currentUserId!,
            reportedUser: chat.userId,
            reportType: "Message",
          );
        }
      },
      itemBuilder: (_) => [
        if (chat.isFollow)
          const PopupMenuItem(
            value: 'unfollow',
            child: Row(
              children: [
                Icon(Icons.person_remove_outlined, size: 18, color: Colors.white),
                SizedBox(width: 12),
                Text('Unfollow', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        const PopupMenuItem(
          value: 'block',
          child: Row(
            children: [
              Icon(Icons.block_outlined, size: 18, color: Colors.red),
              SizedBox(width: 12),
              Text('Block', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'report',
          child: Row(
            children: [
              Icon(Icons.flag_outlined, size: 18, color: Colors.orange),
              SizedBox(width: 12),
              Text('Report', style: TextStyle(color: Colors.orange)),
            ],
          ),
        ),
      ],
    );
  }

  // =====================================================
  // DISCOVER TAB (SNAPCHAT-LIKE DESIGN)
  // =====================================================

  Widget _discoverTab() {
    return Consumer<RandomUserProvider>(
      builder: (_, prov, __) {
        if (prov.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xffFE0A62)),
          );
        }
        if (prov.users.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.explore_outlined,
                  size: 80,
                  color: Colors.grey.shade800,
                ),
                const SizedBox(height: 16),
                Text(
                  'No users found',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.only(top: 8),
          itemCount: prov.users.length,
          itemBuilder: (_, i) {
            final user = prov.users[i];
            return _buildDiscoverItem(user);
          },
        );
      },
    );
  }

Widget _buildDiscoverItem(dynamic user) {
  return GestureDetector(
    onTap: () {
      // ✅ ALWAYS ALLOW CHAT FROM DISCOVER
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => ChatMessageProvider(),
            child: ChatWithPeople(
              currentUserId: currentUserId!,
              otherUserId: user.id, // ✅ FIXED HERE
              otherUserName: user.name,
              otherUserImage: user.profileImage,
            ),
          ),
        ),
      );
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xff1C1C1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // avatar
Stack(
  children: [
    CircleAvatar(
      radius: 28,
      backgroundImage: NetworkImage(user.profileImage),
    ),

    // 🔴🟢 ONLINE / OFFLINE DOT
    Positioned(
      bottom: 2,
      right: 2,
      child: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: user.isOnline == true
              ? Colors.green
              : Colors.grey,
          border: Border.all(
            color: const Color(0xff1C1C1E),
            width: 2,
          ),
        ),
      ),
    ),
  ],
),

          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user.nickname,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade400,
                  ),
                ),

                const SizedBox(height: 2),
Text(
  user.isOnline == true ? 'Online' : 'Offline',
  style: TextStyle(
    fontSize: 12,
    color: user.isOnline == true
        ? Colors.greenAccent
        : Colors.grey.shade500,
  ),
),

              ],
            ),
          ),
          _followButton(
            isFollowing: user.isFollow,
            followId: user.id,
          ),
        ],
      ),
    ),
  );
}

  // =====================================================
  // FOLLOW BUTTON (MODERN DESIGN)
  // =====================================================

  Widget _followButton({
    required bool isFollowing,
    required String followId,
  }) {
    return Consumer<FollowProvider>(
      builder: (_, followProv, __) {
        return GestureDetector(
          onTap: followProv.isLoading
              ? null
              : () async {
                  final success = isFollowing
                      ? await followProv.unfollow(
                          userId: currentUserId!,
                          unfollowId: followId,
                        )
                      : await followProv.follow(
                          userId: currentUserId!,
                          followId: followId,
                        );

                  if (success) {
                    await _refreshAll();
                  }
                },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: isFollowing
                  ? null
                  : const LinearGradient(
                      colors: [
                        Color(0xffFE0A62),
                        Color(0xffFF6B9D),
                      ],
                    ),
              color: isFollowing ? const Color(0xff2C2C2E) : null,
            ),
            child: followProv.isLoading
                ? const SizedBox(
                    height: 12,
                    width: 12,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    isFollowing ? 'Following' : 'Follow',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isFollowing ? Colors.grey.shade400 : Colors.white,
                    ),
                  ),
          ),
        );
      },
    );
  }

  // =====================================================
  // PENDING TAB (MODERN DESIGN)
  // =====================================================

  Widget _pendingTab() {
    return Consumer<PendingRequestProvider>(
      builder: (_, prov, __) {
        if (prov.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xffFE0A62)),
          );
        }
        if (prov.requests.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.pending_outlined,
                  size: 80,
                  color: Colors.grey.shade800,
                ),
                const SizedBox(height: 16),
                Text(
                  'No pending requests',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.only(top: 8),
          itemCount: prov.requests.length,
          itemBuilder: (_, i) {
            final r = prov.requests[i];
            return _buildPendingItem(r, prov);
          },
        );
      },
    );
  }

  Widget _buildPendingItem(dynamic r, PendingRequestProvider prov) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xff1C1C1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Profile Picture with Pending Ring
          Container(
            padding: const EdgeInsets.all(2.5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xffFE0A62),
                width: 2,
              ),
            ),
            child: CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(r.profileImage),
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  r.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Wants to chat with you',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),

          // Action Buttons
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () async {
                  await prov.handle(
                    r.requestId,
                    'reject',
                    currentUserId!,
                  );
                  await _refreshAll();
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xff2C2C2E),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () async {
                  await prov.handle(
                    r.requestId,
                    'approve',
                    currentUserId!,
                  );
                  await _refreshAll();
                  _tabController.animateTo(1);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xffFE0A62),
                        Color(0xffFF6B9D),
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =====================================================
  // BLOCK USER DIALOG (MODERN DESIGN)
  // =====================================================

  void _confirmBlock(String otherUserId) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xff1C1C1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Block user?',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        content: Text(
          'You will no longer receive messages from this user.',
          style: TextStyle(color: Colors.grey.shade400),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey.shade400),
            ),
          ),
          Consumer<ModerationProvider>(
            builder: (_, modProv, __) {
              return TextButton(
                onPressed: modProv.isLoading
                    ? null
                    : () async {
                        final success = await modProv.block(
                          fromUser: currentUserId!,
                          toUser: otherUserId,
                        );
                        if (success) {
                          Navigator.pop(context);
                          await _refreshAll();
                        }
                      },
                child: modProv.isLoading
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.red,
                        ),
                      )
                    : const Text(
                        'Block',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}