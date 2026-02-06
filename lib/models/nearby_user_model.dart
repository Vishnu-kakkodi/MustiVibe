// class NearbyUser {
//   final String id;
//   final String name;
//   final String nickname;
//   final String profileImage;
//   final String language;
//   final String gender;
//   final double latitude;
//   final double longitude;

//   NearbyUser({
//     required this.id,
//     required this.name,
//     required this.nickname,
//     required this.profileImage,
//     required this.language,
//     required this.gender,
//     required this.latitude,
//     required this.longitude,
//   });

//   factory NearbyUser.fromJson(Map<String, dynamic> json) {
//     final location = json['location'] as Map<String, dynamic>?;
//     final coords = (location?['coordinates'] as List?) ?? [0.0, 0.0];

//     // API sends: [longitude, latitude]
//     final double lng = (coords[0] as num).toDouble();
//     final double lat = (coords[1] as num).toDouble();

//     return NearbyUser(
//       id: json['_id']?.toString() ?? '',
//       name: json['name']?.toString() ?? '',
//       nickname: json['nickname']?.toString() ?? '',
//       profileImage: json['profileImage']?.toString() ?? '',
//       language: json['language']?.toString() ?? '',
//       gender: json['gender']?.toString() ?? '',
//       latitude: lat,
//       longitude: lng,
//     );
//   }
// }












class NearbyUser {
  final String id;
  final String name;
  final String nickname;
  final String profileImage;
  final String language;
  final String gender;
  final double latitude;
  final double longitude;

  /// 🔔 ADD THIS
  final String fcmToken;
    final bool isOnline;


  NearbyUser({
    required this.id,
    required this.name,
    required this.nickname,
    required this.profileImage,
    required this.language,
    required this.gender,
    required this.latitude,
    required this.longitude,
    required this.fcmToken,
        required this.isOnline,

  });

  factory NearbyUser.fromJson(Map<String, dynamic> json) {
    final location = json['location'] as Map<String, dynamic>?;
    final coords = (location?['coordinates'] as List?) ?? [0.0, 0.0];

    // API sends: [longitude, latitude]
    final double lng = (coords[0] as num).toDouble();
    final double lat = (coords[1] as num).toDouble();

    return NearbyUser(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      nickname: json['nickname']?.toString() ?? '',
      profileImage: json['profileImage']?.toString() ?? '',
      language: json['language']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      latitude: lat,
      longitude: lng,

      /// 🔔 MAP FCM TOKEN FROM API
      fcmToken: json['fcmToken']?.toString() ?? '',
            isOnline: json['isOnline'] == true,

    );
  }
}
