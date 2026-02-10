// class RoomUser {
//   final String id;
//   final String name;
//   final String nickName;
//   final String profileImage;
//   final String language;
//   final String gender;

//   RoomUser({
//     required this.id,
//     required this.name,
//     required this.nickName,
//     required this.profileImage,
//     required this.language,
//     required this.gender,
//   });

//   /// ✅ Parse real user
//   factory RoomUser.fromJson(Map<String, dynamic> json) {
//     return RoomUser(
//       id: json['_id']?.toString() ?? '',
//       name: json['name']?.toString() ?? '',
//       nickName: json['nickname']?.toString() ?? '',
//       profileImage: json['profileImage']?.toString() ?? '',
//       language: json['language']?.toString() ?? '',
//       gender: json['gender']?.toString() ?? '',
//     );
//   }

//   /// ✅ Static admin user
//   factory RoomUser.admin({String tag = ''}) {
//     return RoomUser(
//       id: 'admin',
//       name: tag.isNotEmpty ? "$tag Host" : "Admin",
//       nickName: "Host",
//       profileImage:
//           "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
//       language: "English",
//       gender: "male",
//     );
//   }

//   /// ✅ Empty fallback
//   factory RoomUser.empty() {
//     return RoomUser(
//       id: '',
//       name: '',
//       nickName: '',
//       profileImage: '',
//       language: '',
//       gender: '',
//     );
//   }
// }

// class Room {
//   final String id;
//   final RoomUser user;
//   final String type;
//   final String tag;
//   final DateTime? createdAt;
//   final String startDateTime;
// final int duration;

//   Room({
//     required this.id,
//     required this.user,
//     required this.type,
//     required this.tag,
//     this.createdAt,
//     required this.startDateTime,
//     required this.duration,
//   });

//   factory Room.fromJson(Map<String, dynamic> json) {
//     final dynamic userRaw = json['userId'];
//     final dynamic adminRaw = json['adminId'];

//     RoomUser parsedUser;

//     /// ✅ Case 1: userId is populated object
//     if (userRaw is Map<String, dynamic>) {
//       parsedUser = RoomUser.fromJson(userRaw);
//     }
//     /// ✅ Case 2: adminId exists → use static admin
//     else if (adminRaw != null) {
//       parsedUser = RoomUser.admin(tag: json['tag'] ?? '');
//     }
//     /// ✅ Case 3: fallback
//     else {
//       parsedUser = RoomUser.empty();
//     }

//     return Room(
//       id: json['_id']?.toString() ?? '',
//       user: parsedUser,
//       type: json['type']?.toString() ?? '',
//       tag: json['tag']?.toString() ?? '',
//       createdAt: json['createdAt'] != null
//           ? DateTime.tryParse(json['createdAt'].toString())
//           : null,
//       startDateTime: json['startDateTime']?.toString() ?? '',
// duration: int.tryParse(json['duration'].toString()) ?? 0,

//     );
//   }
// }













class RoomUser {
  final String id;
  final String name;
  final String nickName;
  final String profileImage;
  final String language;
  final String gender;

  RoomUser({
    required this.id,
    required this.name,
    required this.nickName,
    required this.profileImage,
    required this.language,
    required this.gender,
  });

  /// ✅ Parse real user
  factory RoomUser.fromJson(Map<String, dynamic> json) {
    return RoomUser(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      nickName: json['nickname']?.toString() ?? '',
      profileImage: json['profileImage']?.toString() ?? '',
      language: json['language']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
    );
  }

  /// ✅ Static admin user
  factory RoomUser.admin({String tag = ''}) {
    return RoomUser(
      id: 'admin',
      name: tag.isNotEmpty ? "$tag Host" : "Admin",
      nickName: "Host",
      profileImage:
          "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
      language: "English",
      gender: "male",
    );
  }

  /// ✅ Empty fallback
  factory RoomUser.empty() {
    return RoomUser(
      id: '',
      name: '',
      nickName: '',
      profileImage: '',
      language: '',
      gender: '',
    );
  }
}

class JoinedUser {
  final String id;      // join record id
  final String userId;  // actual user id
  final String name;
  final String nickName;
  final String gender;
  final String mobile;

  JoinedUser({
    required this.id,
    required this.userId,
    required this.name,
    required this.nickName,
    required this.gender,
    required this.mobile,
  });

  factory JoinedUser.fromJson(Map<String, dynamic> json) {
    return JoinedUser(
      id: json['_id']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      nickName: json['nickname']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      mobile: json['mobile']?.toString() ?? '',
    );
  }
}

class Room {
  final String id;
  final RoomUser user;
  final String type;
  final String tag;
  final DateTime? createdAt;
  final String startDateTime;
  final int duration;
  final List<JoinedUser> joinedUsers;

  Room({
    required this.id,
    required this.user,
    required this.type,
    required this.tag,
    this.createdAt,
    required this.startDateTime,
    required this.duration,
    required this.joinedUsers,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    final dynamic userRaw = json['userId'];
    final dynamic adminRaw = json['adminId'];

    RoomUser parsedUser;

    /// ✅ Case 1: userId is populated object
    if (userRaw is Map<String, dynamic>) {
      parsedUser = RoomUser.fromJson(userRaw);
    }
    /// ✅ Case 2: adminId exists → use static admin
    else if (adminRaw != null) {
      parsedUser = RoomUser.admin(tag: json['tag'] ?? '');
    }
    /// ✅ Case 3: fallback
    else {
      parsedUser = RoomUser.empty();
    }

    /// ✅ Parse joined users
    final joinedUsersList = (json['joinedUsers'] as List?)
            ?.map((e) => JoinedUser.fromJson(e))
            .toList() ??
        [];

    return Room(
      id: json['_id']?.toString() ?? '',
      user: parsedUser,
      type: json['type']?.toString() ?? '',
      tag: json['tag']?.toString() ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
      startDateTime: json['startDateTime']?.toString() ?? '',
      duration: int.tryParse(json['duration'].toString()) ?? 0,
      joinedUsers: joinedUsersList,
    );
  }
}
