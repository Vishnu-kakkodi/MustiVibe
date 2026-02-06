// class ChatModel {
//   final String userId;
//   final String name;
//   final String profileImage;
//   final bool isOnline;
//   final String lastMessage;
//   final DateTime lastMessageTime;
//   final bool isFollowing;

//   ChatModel({
//     required this.userId,
//     required this.name,
//     required this.profileImage,
//     required this.isOnline,
//     required this.lastMessage,
//     required this.lastMessageTime,
//     required this.isFollowing,
//   });

//   factory ChatModel.fromJson(Map<String, dynamic> json) {
//     return ChatModel(
//       userId: json['user']['_id'],
//       name: json['user']['name'],
//       profileImage: json['user']['profileImage'],
//       isOnline: json['user']['isOnline'] ?? false,
//       lastMessage: json['lastMessage']['text'] ?? '',
//       lastMessageTime:
//           DateTime.parse(json['lastMessage']['createdAt']),
//       isFollowing: json['relationship']['isFollowing'] ?? false,
//     );
//   }
// }




















// class ChatModel {
//   final String userId;
//   final String name;
//   final String profileImage;
//   final bool isOnline;

//   final String lastMessage;
//   final DateTime lastMessageTime;

//   final bool isFollowing;
//   final bool isFollower;
//   final bool isMutual;
//   final String relationshipStatus;

//   final bool isBlocked;
//   final int unreadCount;
//   final String chatStatus;
//   final bool isChatApproved;
//     final String senderId;



//   ChatModel({
//     required this.userId,
//     required this.name,
//     required this.profileImage,
//     required this.isOnline,
//     required this.lastMessage,
//     required this.lastMessageTime,
//     required this.isFollowing,
//     required this.isFollower,
//     required this.isMutual,
//     required this.relationshipStatus,
//     required this.isBlocked,
//     required this.unreadCount,
//     required this.chatStatus,
//     required this.isChatApproved,
//     required this.senderId

//   });

//   factory ChatModel.fromJson(Map<String, dynamic> json) {
//     final user = json['user'] ?? {};
//     final lastMsg = json['lastMessage'];
//     final relationship = json['relationship'] ?? {};

//     return ChatModel(
//       // USER
//       userId: user['_id'] ?? '',
//       name: user['name'] ?? '',
//       profileImage: user['profileImage'] ?? '',
//       isOnline: user['isOnline'] ?? false,
//             senderId: user['sender'] ?? '',


//       // LAST MESSAGE (SAFE)
//       lastMessage: lastMsg != null ? lastMsg['text'] ?? '' : '',
//       lastMessageTime: lastMsg != null
//           ? DateTime.parse(lastMsg['createdAt'])
//           : DateTime.parse(json['updatedAt']),

//       // RELATIONSHIP
//       isFollowing: relationship['isFollowing'] ?? false,
//       isFollower: relationship['isFollower'] ?? false,
//       isMutual: relationship['isMutual'] ?? false,
//       relationshipStatus: relationship['status'] ?? 'none',
//       isChatApproved: user['isChatApproved'] ?? false,


//       // CHAT STATE
//       isBlocked: json['isBlocked'] ?? false,
//       unreadCount: json['unreadCount'] ?? 0,
//       chatStatus: json['chatStatus'] ?? '',
//     );
//   }
// }




















class ChatModel {
  final String userId;
  final String name;
  final String profileImage;
  final bool isOnline;
  final DateTime? lastSeen;

  final String lastMessage;
  final DateTime lastMessageTime;
  final String messageType;
  final String chatStatus;
  final String senderId;

  final bool isFollow;
  final bool isFollowed;
  final bool isMutual;

  final bool isBlocked;
  final bool isChatApproved;
  final int unreadCount;

  ChatModel({
    required this.userId,
    required this.name,
    required this.profileImage,
    required this.isOnline,
    required this.lastSeen,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.messageType,
    required this.chatStatus,
    required this.senderId,
    required this.isFollow,
    required this.isFollowed,
    required this.isMutual,
    required this.isBlocked,
    required this.isChatApproved,
    required this.unreadCount,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>? ?? {};
    final lastMsg = json['lastMessage'] as Map<String, dynamic>?;

    final bool isFollow = user['isFollow'] == true;
    final bool isFollowed = user['isFollowed'] == true;

    return ChatModel(
      // USER INFO
      userId: user['_id']?.toString() ?? '',
      name: user['name']?.toString() ?? '',
      profileImage: user['profileImage']?.toString() ?? '',
      isOnline: user['isOnline'] == true,
      lastSeen: user['lastSeen'] != null
          ? DateTime.tryParse(user['lastSeen'])
          : null,

      // LAST MESSAGE
      lastMessage: lastMsg?['text']?.toString() ?? '',
      lastMessageTime: lastMsg?['createdAt'] != null
          ? DateTime.parse(lastMsg!['createdAt'])
          : DateTime.parse(json['updatedAt']),
      messageType: lastMsg?['messageType']?.toString() ?? '',
      chatStatus: lastMsg?['status']?.toString() ?? '',
      senderId: lastMsg?['sender']?.toString() ?? '',

      // RELATIONSHIP
      isFollow: isFollow,
      isFollowed: isFollowed,
      isMutual: isFollow && isFollowed,

      // CHAT STATE
      isBlocked: user['isBlocked'] == true,
      isChatApproved: user['isChatApproved'] == true,
      unreadCount: json['unreadCount'] is int ? json['unreadCount'] : 0,
    );
  }
}
