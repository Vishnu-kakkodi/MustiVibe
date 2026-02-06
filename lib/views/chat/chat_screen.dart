// import 'package:flutter/material.dart';

// class Chatwithpeople extends StatelessWidget {
//   const Chatwithpeople({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Image.asset(
//               'assets/7c4a78dbdc1142c15d075beeedd6e088924587c8.jpg',
//               fit: BoxFit.cover,
//             ),
//           ),
          
//           Positioned.fill(
//             child: Container(
//               color: Colors.black.withOpacity(0.3),
//             ),
//           ),

//           SafeArea(
//             child: Column(
//               children: [
//                 _topBar(context),
                
//                 // Chat messages
//                 Expanded(
//                   child: ListView(
//                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//                     children: [
//                       const SizedBox(height: 200), 
//                       _userMessage("Hi, How are yor?", "09:25 AM"),
//                       const SizedBox(height: 16),
//                       _friendMessage(
//                         "I'm fine how are you?",
//                         "09:26 AM",
//                         "Alex Linderson",
//                       ),
//                     ],
//                   ),
//                 ),

//                 _bottomMessageBox(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _topBar(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       child: Row(
//         children: [
//           // User avatar
//           Container(
//             width: 44,
//             height: 44,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               border: Border.all(color: Colors.white, width: 2),
//             ),
//             child: ClipOval(
//               child: Image.asset(
//                 'assets/girlimage4.png',
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           const Spacer(),

//           _topBadge(Icons.add, "510", context),
//           const SizedBox(width: 8),
//           _topBadge(Icons.dangerous_outlined, null, context, isCall: true),
//           const SizedBox(width: 8),
//           _topBadge(Icons.exit_to_app, null, context, isMenu: true),
//         ],
//       ),
//     );
//   }

//   Widget _topBadge(IconData icon, String? text, BuildContext context, 
//       {bool isCall = false, bool isMenu = false}) {
//     return GestureDetector(
//       onTap: () {
//         if (isMenu) {
//           _showExitDialog(context);
//         }
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               icon,
//               size: 18,
//               color: isCall ? const Color(0xFFE91E63) : const Color(0xFFE91E63),
//             ),
//             if (text != null) ...[
//               const SizedBox(width: 4),
//               Text(
//                 text,
//                 style: const TextStyle(
//                   color: Color(0xFF2196F3),
//                   fontWeight: FontWeight.w600,
//                   fontSize: 13,
//                 ),
//               )
//             ]
//           ],
//         ),
//       ),
//     );
//   }

//   void _showExitDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierColor: Colors.black.withOpacity(0.5),
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Container(
//             padding: const EdgeInsets.all(24),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   "Do you want to End Conversation?",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.of(context).pop(); // Close dialog
//                           Navigator.of(context).pop(); // Exit chat screen
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFFFF1744),
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(vertical: 14),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           elevation: 0,
//                         ),
//                         child: const Text(
//                           "Yes",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: OutlinedButton(
//                         onPressed: () {
//                           Navigator.of(context).pop(); // Close dialog only
//                         },
//                         style: OutlinedButton.styleFrom(
//                           foregroundColor: Colors.black87,
//                           padding: const EdgeInsets.symmetric(vertical: 14),
//                           side: const BorderSide(color: Colors.grey, width: 1.5),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: const Text(
//                           "No",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _userMessage(String message, String time) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 const Text(
//                   "You",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Container(
//                   constraints: const BoxConstraints(maxWidth: 250),
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         message,
//                         style: const TextStyle(
//                           fontSize: 14,
//                           color: Colors.black87,
//                         ),
//                       ),
//                       const SizedBox(height: 2),
//                       Text(
//                         time,
//                         style: const TextStyle(
//                           color: Colors.grey,
//                           fontSize: 10,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(width: 8),
//             Container(
//               width: 36,
//               height: 36,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.white,
//                 border: Border.all(color: Colors.white, width: 2),
//               ),
//               child: ClipOval(
//                 child: Image.asset(
//                   'assets/girlimage4.png',
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _friendMessage(String message, String time, String name) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: 36,
//               height: 36,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.white,
//                 border: Border.all(color: Colors.white, width: 2),
//               ),
//               child: ClipOval(
//                 child: Image.asset(
//                   'assets/girlimage4.png',
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 8),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   name,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Container(
//                   constraints: const BoxConstraints(maxWidth: 250),
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.95),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         message,
//                         style: const TextStyle(
//                           fontSize: 14,
//                           color: Colors.black87,
//                         ),
//                       ),
//                       const SizedBox(height: 2),
//                       Text(
//                         time,
//                         style: const TextStyle(
//                           color: Colors.grey,
//                           fontSize: 10,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _bottomMessageBox() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       color: Colors.transparent,
//       child: Row(
//         children: [
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(25),
//               ),
//               child: const TextField(
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   hintText: "Write your message",
//                   hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//           Container(
//             width: 48,
//             height: 48,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xFFFF1744), Color(0xFFE91E63)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(Icons.send, color: Colors.white, size: 22),
//           )
//         ],
//       ),
//     );
//   }
// }















// import 'package:dating_app/models/ChatMessage/chat_message_model.dart';
// import 'package:dating_app/providers/ChatMessage/chat_message_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';


// class ChatScreen extends StatefulWidget {
//   final String currentUserId;
//   final String otherUserId;
//   final String otherUserName;
//   final String? otherUserImage;

//   const ChatScreen({
//     Key? key,
//     required this.currentUserId,
//     required this.otherUserId,
//     required this.otherUserName,
//     this.otherUserImage,
//   }) : super(key: key);

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _controller = TextEditingController();
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();

//     Future.microtask(() {
//       context.read<ChatMessageProvider>().loadConversation(
//             widget.currentUserId,
//             widget.otherUserId,
//           );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildAppBar(),
//       body: Column(
//         children: [
//           Expanded(child: _buildMessages()),
//           _buildInputBar(),
//         ],
//       ),
//     );
//   }

//   // ---------------- APP BAR ----------------

//   AppBar _buildAppBar() {
//     return AppBar(
//       titleSpacing: 0,
//       title: Row(
//         children: [
//           CircleAvatar(
//             backgroundImage: widget.otherUserImage != null
//                 ? NetworkImage(widget.otherUserImage!)
//                 : null,
//             child: widget.otherUserImage == null
//                 ? const Icon(Icons.person)
//                 : null,
//           ),
//           const SizedBox(width: 10),
//           Text(
//             widget.otherUserName,
//             style: const TextStyle(fontSize: 16),
//           ),
//         ],
//       ),
//     );
//   }

//   // ---------------- MESSAGE LIST ----------------

//   Widget _buildMessages() {
//     return Consumer<ChatMessageProvider>(
//       builder: (context, provider, _) {
//         if (provider.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (provider.messages.isEmpty) {
//           return const Center(child: Text('No messages yet'));
//         }

//         return ListView.builder(
//           controller: _scrollController,
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//           reverse: true,
//           itemCount: provider.messages.length,
//           itemBuilder: (context, index) {
//             final ChatMessage message =
//                 provider.messages[provider.messages.length - 1 - index];

//             final bool isMe =
//                 message.senderId == widget.currentUserId;

//             return _buildMessageBubble(message, isMe);
//           },
//         );
//       },
//     );
//   }

//   Widget _buildMessageBubble(ChatMessage message, bool isMe) {
//     return Align(
//       alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 4),
//         padding: const EdgeInsets.all(12),
//         constraints: const BoxConstraints(maxWidth: 280),
//         decoration: BoxDecoration(
//           color: isMe ? Colors.blue : Colors.grey.shade200,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           crossAxisAlignment:
//               isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//           children: [
//             Text(
//               message.text ?? '',
//               style: TextStyle(
//                 color: isMe ? Colors.white : Colors.black,
//                 fontSize: 15,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   _formatTime(message.createdAt),
//                   style: TextStyle(
//                     fontSize: 10,
//                     color: isMe ? Colors.white70 : Colors.grey,
//                   ),
//                 ),
//                 if (isMe) ...[
//                   const SizedBox(width: 4),
//                   Icon(
//                     message.status == 'read'
//                         ? Icons.done_all
//                         : Icons.done,
//                     size: 14,
//                     color: message.status == 'read'
//                         ? Colors.white
//                         : Colors.white70,
//                   ),
//                 ],
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ---------------- INPUT BAR ----------------

//   Widget _buildInputBar() {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.all(8),
//         child: Row(
//           children: [
//             Expanded(
//               child: TextField(
//                 controller: _controller,
//                 textInputAction: TextInputAction.send,
//                 decoration: InputDecoration(
//                   hintText: 'Type a message',
//                   filled: true,
//                   fillColor: Colors.grey.shade100,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     borderSide: BorderSide.none,
//                   ),
//                   contentPadding:
//                       const EdgeInsets.symmetric(horizontal: 16),
//                 ),
//                 onSubmitted: (_) => _sendMessage(),
//               ),
//             ),
//             const SizedBox(width: 8),
//             CircleAvatar(
//               radius: 24,
//               backgroundColor: Colors.blue,
//               child: IconButton(
//                 icon: const Icon(Icons.send, color: Colors.white),
//                 onPressed: _sendMessage,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _sendMessage() {
//     final text = _controller.text.trim();
//     if (text.isEmpty) return;

//     context.read<ChatMessageProvider>().sendTextMessage(
//           senderId: widget.currentUserId,
//           receiverId: widget.otherUserId,
//           text: text,
//         );

//     _controller.clear();

//     Future.delayed(const Duration(milliseconds: 100), () {
//       _scrollController.animateTo(
//         0,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     });
//   }

//   String _formatTime(DateTime time) {
//     final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
//     final minute = time.minute.toString().padLeft(2, '0');
//     final period = time.hour >= 12 ? 'PM' : 'AM';
//     return '$hour:$minute $period';
//   }
// }




















// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:dating_app/models/ChatMessage/chat_message_model.dart';
// import 'package:dating_app/providers/ChatMessage/chat_message_provider.dart';

// class Chatwithpeople extends StatefulWidget {
//   final String currentUserId;
//   final String otherUserId;
//   final String otherUserName;
//   final String? otherUserImage;

//   const Chatwithpeople({
//     super.key,
//     required this.currentUserId,
//     required this.otherUserId,
//     required this.otherUserName,
//     this.otherUserImage,
//   });

//   @override
//   State<Chatwithpeople> createState() => _ChatwithpeopleState();
// }

// class _ChatwithpeopleState extends State<Chatwithpeople> {
//   final TextEditingController _controller = TextEditingController();
//   final ScrollController _scrollController = ScrollController();

// @override
// void initState() {
//   super.initState();

//   WidgetsBinding.instance.addPostFrameCallback((_) {
//     final provider = context.read<ChatMessageProvider>();

//     provider.loadConversation(
//       widget.currentUserId,
//       widget.otherUserId,
//     );

//     provider.initSocket(
//       currentUserId: widget.currentUserId,
//       otherUserId: widget.otherUserId,
//     );
//   });
// }


//   @override
//   void dispose() {
//     context.read<ChatMessageProvider>().disposeSocket();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Image.asset(
//               'assets/7c4a78dbdc1142c15d075beeedd6e088924587c8.jpg',
//               fit: BoxFit.cover,
//             ),
//           ),
//           Positioned.fill(
//             child: Container(color: Colors.black.withOpacity(0.3)),
//           ),
//           SafeArea(
//             child: Column(
//               children: [
//                 _topBar(context),
//                 Expanded(child: _chatMessages()),
//                 _bottomMessageBox(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ---------------- TOP BAR ----------------

//   Widget _topBar(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       child: Row(
//         children: [
//           _avatar(widget.otherUserImage, 44),
//           const Spacer(),
//           _badge(Icons.add, "510"),
//           const SizedBox(width: 8),
//           _badge(Icons.dangerous_outlined, null),
//           const SizedBox(width: 8),
//           _badge(Icons.exit_to_app, null, exit: true),
//         ],
//       ),
//     );
//   }

//   Widget _badge(IconData icon, String? text, {bool exit = false}) {
//     return GestureDetector(
//       onTap: () {
//         if (exit) Navigator.pop(context);
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Row(
//           children: [
//             Icon(icon, size: 18, color: const Color(0xFFE91E63)),
//             if (text != null) ...[
//               const SizedBox(width: 4),
//               Text(text,
//                   style: const TextStyle(
//                       color: Color(0xFF2196F3),
//                       fontWeight: FontWeight.w600,
//                       fontSize: 13)),
//             ]
//           ],
//         ),
//       ),
//     );
//   }

//   // ---------------- CHAT LIST ----------------

//   Widget _chatMessages() {
//     return Consumer<ChatMessageProvider>(
//       builder: (context, provider, _) {
//         return ListView.builder(
//           controller: _scrollController,
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//           reverse: true,
//           itemCount: provider.messages.length,
//           itemBuilder: (context, index) {
//             final msg =
//                 provider.messages[provider.messages.length - 1 - index];
//             return msg.senderId == widget.currentUserId
//                 ? _userMessage(msg)
//                 : _friendMessage(msg);
//           },
//         );
//       },
//     );
//   }

//   Widget _userMessage(ChatMessage msg) {
//     return _bubble(
//       msg.text ?? '',
//       _formatTime(msg.createdAt),
//       isMe: true,
//     );
//   }

//   Widget _friendMessage(ChatMessage msg) {
//     return _bubble(
//       msg.text ?? '',
//       _formatTime(msg.createdAt),
//       isMe: false,
//     );
//   }

//   Widget _bubble(String text, String time, {required bool isMe}) {
//     return Column(
//       crossAxisAlignment:
//           isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//       children: [
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment:
//               isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//           children: [
//             if (!isMe) _avatar(widget.otherUserImage, 36),
//             if (!isMe) const SizedBox(width: 8),
//             Container(
//               constraints: const BoxConstraints(maxWidth: 250),
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(text,
//                       style: const TextStyle(
//                           fontSize: 14, color: Colors.black87)),
//                   const SizedBox(height: 2),
//                   Text(time,
//                       style:
//                           const TextStyle(fontSize: 10, color: Colors.grey)),
//                 ],
//               ),
//             ),
//             if (isMe) const SizedBox(width: 8),
//             if (isMe) _avatar(widget.otherUserImage, 36),
//           ],
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }

//   Widget _avatar(String? image, double size) {
//     return Container(
//       width: size,
//       height: size,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.all(color: Colors.white, width: 2),
//       ),
//       child: ClipOval(
//         child: image != null
//             ? Image.network(image, fit: BoxFit.cover)
//             : Image.asset('assets/girlimage4.png'),
//       ),
//     );
//   }

//   // ---------------- INPUT ----------------

//   Widget _bottomMessageBox() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       child: Row(
//         children: [
//           Expanded(
//             child: Container(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(25),
//               ),
//               child: TextField(
//                 controller: _controller,
//                 onChanged: (_) =>
//                     context.read<ChatMessageProvider>().typing(),
//                 decoration: const InputDecoration(
//                   border: InputBorder.none,
//                   hintText: "Write your message",
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//           GestureDetector(
//             onTap: _send,
//             child: Container(
//               width: 48,
//               height: 48,
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Color(0xFFFF1744), Color(0xFFE91E63)],
//                 ),
//                 shape: BoxShape.circle,
//               ),
//               child:
//                   const Icon(Icons.send, color: Colors.white, size: 22),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   void _send() {
//     final text = _controller.text.trim();
//     if (text.isEmpty) return;

//     context.read<ChatMessageProvider>().sendTextMessage(
//           senderId: widget.currentUserId,
//           receiverId: widget.otherUserId,
//           text: text,
//         );

//     context.read<ChatMessageProvider>().stopTyping();
//     _controller.clear();
//   }

//   String _formatTime(DateTime t) {
//     final h = t.hour % 12 == 0 ? 12 : t.hour % 12;
//     final m = t.minute.toString().padLeft(2, '0');
//     return '$h:$m ${t.hour >= 12 ? 'PM' : 'AM'}';
//   }
// }















import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dating_app/models/ChatMessage/chat_message_model.dart';
import 'package:dating_app/providers/ChatMessage/chat_message_provider.dart';

class ChatWithPeople extends StatefulWidget {
  final String currentUserId;
  final String otherUserId;
  final String otherUserName;
  final String? otherUserImage;

  const ChatWithPeople({
    super.key,
    required this.currentUserId,
    required this.otherUserId,
    required this.otherUserName,
    this.otherUserImage,
  });

  @override
  State<ChatWithPeople> createState() => _ChatWithPeopleState();
}

class _ChatWithPeopleState extends State<ChatWithPeople> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<ChatMessageProvider>();

      provider.loadConversation(
        widget.currentUserId,
        widget.otherUserId,
      );

      provider.initSocket(
        currentUserId: widget.currentUserId,
        otherUserId: widget.otherUserId,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    context.read<ChatMessageProvider>().disposeSocket();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Background
          Positioned.fill(
            child: Image.asset(
              'assets/7c4a78dbdc1142c15d075beeedd6e088924587c8.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.35)),
          ),

          SafeArea(
            child: Column(
              children: [
                _topBar(),
                Expanded(child: _chatMessages()),
                _bottomInput(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= TOP BAR =================

  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          _avatar(widget.otherUserImage, 42),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              widget.otherUserName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          _iconBadge(Icons.exit_to_app, onTap: () => Navigator.pop(context)),
        ],
      ),
    );
  }

  Widget _iconBadge(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: Colors.pink),
      ),
    );
  }

  // ================= CHAT LIST =================

  Widget _chatMessages() {
    return Consumer<ChatMessageProvider>(
      builder: (_, provider, __) {
        final messages = provider.messages;

        return ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          itemCount: messages.length,
          itemBuilder: (_, index) {
            final msg = messages[index];
            final isMe = msg.senderId == widget.currentUserId;

            return _messageBubble(msg, isMe);
          },
        );
      },
    );
  }

  Widget _messageBubble(ChatMessage msg, bool isMe) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) _avatar(widget.otherUserImage, 34),
          if (!isMe) const SizedBox(width: 8),

          Container(
            constraints: const BoxConstraints(maxWidth: 260),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isMe ? Colors.white : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  msg.text ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatTime(msg.createdAt),
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          if (isMe) const SizedBox(width: 8),
          if (isMe) _avatar(null, 34),
        ],
      ),
    );
  }

  // ================= INPUT =================

  Widget _bottomInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
              ),
              child: TextField(
                controller: _controller,
                onChanged: (_) =>
                    context.read<ChatMessageProvider>().typing(),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Write your message...",
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFFFF1744), Color(0xFFE91E63)],
                ),
              ),
              child: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    context.read<ChatMessageProvider>().sendTextMessage(
          senderId: widget.currentUserId,
          receiverId: widget.otherUserId,
          text: text,
        );

    _controller.clear();
  }

  // ================= HELPERS =================

  Widget _avatar(String? image, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: ClipOval(
        child: image != null
            ? Image.network(image, fit: BoxFit.cover)
            : Image.asset('assets/girlimage4.png'),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}
