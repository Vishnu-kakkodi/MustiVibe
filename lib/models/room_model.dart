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

  /// 🔥 SAFE EMPTY USER
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



class Room {
  final String id;
  final RoomUser user;
  final String type;
  final String tag;
  final DateTime? createdAt;
  final String startDateTime;

  Room({
    required this.id,
    required this.user,
    required this.type,
    required this.tag,
    this.createdAt,
    required this.startDateTime,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    final dynamic userRaw = json['userId'];

    return Room(
      id: json['_id']?.toString() ?? '',
      user: userRaw is Map<String, dynamic>
          ? RoomUser.fromJson(userRaw)
          : RoomUser.empty(), // ✅ NO CRASH
      type: json['type']?.toString() ?? '',
      tag: json['tag']?.toString() ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
          startDateTime: json['startDateTime']?.toString() ?? ''
    );
  }
}
