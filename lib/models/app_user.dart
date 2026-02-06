// lib/models/app_user.dart
import 'dart:convert';

class UserLocation {
  final String? type;
  final double? longitude;
  final double? latitude;

  UserLocation({
    this.type,
    this.longitude,
    this.latitude,
  });

  factory UserLocation.fromJson(Map<String, dynamic>? json) {
    if (json == null) return UserLocation();
    final coords = _safeList(json['coordinates']);
    double? lon;
    double? lat;

    if (coords.length >= 2) {
      lon = _toDouble(coords[0]);
      lat = _toDouble(coords[1]);
    }

    return UserLocation(
      type: _safeString(json['type']),
      longitude: lon,
      latitude: lat,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': [
        if (longitude != null) longitude,
        if (latitude != null) latitude,
      ],
    };
  }
}

class AppUser {
  final String id;
  final String? mobile;
  final String? name;
  final String? nickname;
  final String? gender;
  final DateTime? dob;
  final String? referralCode;
  final String? language;
  final String? userType;
  final num? wallet;
  final bool hasCompletedProfile;
  final bool hasLoggedIn;
  final String? token;
  final DateTime? expiresAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? profileImage;
  final bool isPermanentlyBlocked;
  final bool isTemporarilyBlocked;
  final int warningsCount;
  final List<String> followers;
  final List<String> following;
  final bool isOnline;
  final DateTime? lastActive;
  final UserLocation? location;

  AppUser({
    required this.id,
    this.mobile,
    this.name,
    this.nickname,
    this.gender,
    this.dob,
    this.referralCode,
    this.language,
    this.userType,
    this.wallet,
    this.hasCompletedProfile = false,
    this.hasLoggedIn = false,
    this.token,
    this.expiresAt,
    this.createdAt,
    this.updatedAt,
    this.profileImage,
    this.isPermanentlyBlocked = false,
    this.isTemporarilyBlocked = false,
    this.warningsCount = 0,
    this.followers = const [],
    this.following = const [],
    this.isOnline = false,
    this.lastActive,
    this.location,
  });

  factory AppUser.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      // Return a minimal safe object (id empty)
      return AppUser(id: '');
    }

    final followersRaw = _safeList(json['followers']);
    final followingRaw = _safeList(json['following']);

    return AppUser(
      id: _safeString(json['_id']) ?? '',
      mobile: _safeString(json['mobile']),
      name: _safeString(json['name']),
      nickname: _safeString(json['nickname']),
      gender: _safeString(json['gender']),
      dob: _safeDate(json['dob']),
      referralCode: _safeString(json['referralCode']),
      language: _safeString(json['language']),
      userType: _safeString(json['userType']),
      wallet: _safeNum(json['wallet']),
      hasCompletedProfile: _safeBool(json['hasCompletedProfile']),
      hasLoggedIn: _safeBool(json['hasLoggedIn']),
      token: _safeString(json['token']),
      expiresAt: _safeDate(json['expiresAt']),
      createdAt: _safeDate(json['createdAt']),
      updatedAt: _safeDate(json['updatedAt']),
      profileImage: _safeString(json['profileImage']),
      isPermanentlyBlocked: _safeBool(json['isPermanentlyBlocked']),
      isTemporarilyBlocked: _safeBool(json['isTemporarilyBlocked']),
      warningsCount: _safeInt(json['warningsCount']),
      followers: followersRaw.map((e) => _safeString(e) ?? '').where((e) => e.isNotEmpty).toList(),
      following: followingRaw.map((e) => _safeString(e) ?? '').where((e) => e.isNotEmpty).toList(),
      isOnline: _safeBool(json['isOnline']),
      lastActive: _safeDate(json['lastActive']),
      location: UserLocation.fromJson(
        json['location'] is Map<String, dynamic>
            ? json['location'] as Map<String, dynamic>
            : null,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'mobile': mobile,
      'name': name,
      'nickname': nickname,
      'gender': gender,
      'dob': dob?.toIso8601String(),
      'referralCode': referralCode,
      'language': language,
      'userType': userType,
      'wallet': wallet,
      'hasCompletedProfile': hasCompletedProfile,
      'hasLoggedIn': hasLoggedIn,
      'token': token,
      'expiresAt': expiresAt?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'profileImage': profileImage,
      'isPermanentlyBlocked': isPermanentlyBlocked,
      'isTemporarilyBlocked': isTemporarilyBlocked,
      'warningsCount': warningsCount,
      'followers': followers,
      'following': following,
      'isOnline': isOnline,
      'lastActive': lastActive?.toIso8601String(),
      'location': location?.toJson(),
    };
  }

  AppUser copyWith({
    String? id,
    String? mobile,
    String? name,
    String? nickname,
    String? gender,
    DateTime? dob,
    String? referralCode,
    String? language,
    String? userType,
    num? wallet,
    bool? hasCompletedProfile,
    bool? hasLoggedIn,
    String? token,
    DateTime? expiresAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? profileImage,
    bool? isPermanentlyBlocked,
    bool? isTemporarilyBlocked,
    int? warningsCount,
    List<String>? followers,
    List<String>? following,
    bool? isOnline,
    DateTime? lastActive,
    UserLocation? location,
  }) {
    return AppUser(
      id: id ?? this.id,
      mobile: mobile ?? this.mobile,
      name: name ?? this.name,
      nickname: nickname ?? this.nickname,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      referralCode: referralCode ?? this.referralCode,
      language: language ?? this.language,
      userType: userType ?? this.userType,
      wallet: wallet ?? this.wallet,
      hasCompletedProfile: hasCompletedProfile ?? this.hasCompletedProfile,
      hasLoggedIn: hasLoggedIn ?? this.hasLoggedIn,
      token: token ?? this.token,
      expiresAt: expiresAt ?? this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      profileImage: profileImage ?? this.profileImage,
      isPermanentlyBlocked:
          isPermanentlyBlocked ?? this.isPermanentlyBlocked,
      isTemporarilyBlocked:
          isTemporarilyBlocked ?? this.isTemporarilyBlocked,
      warningsCount: warningsCount ?? this.warningsCount,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      isOnline: isOnline ?? this.isOnline,
      lastActive: lastActive ?? this.lastActive,
      location: location ?? this.location,
    );
  }
}

/// =======================
/// Safe parse helpers
/// =======================

String? _safeString(dynamic value) {
  if (value == null) return null;
  if (value is String) return value;
  return value.toString();
}

num? _safeNum(dynamic value) {
  if (value == null) return null;
  if (value is num) return value;
  if (value is String) return num.tryParse(value);
  return null;
}

double? _toDouble(dynamic value) {
  if (value == null) return null;
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

bool _safeBool(dynamic value) {
  if (value == null) return false;
  if (value is bool) return value;
  if (value is num) return value != 0;
  if (value is String) {
    final lower = value.toLowerCase();
    return lower == 'true' || lower == '1' || lower == 'yes';
  }
  return false;
}

int _safeInt(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}

DateTime? _safeDate(dynamic value) {
  if (value == null) return null;
  if (value is DateTime) return value;
  if (value is String) {
    try {
      return DateTime.tryParse(value);
    } catch (_) {
      return null;
    }
  }
  return null;
}

List<dynamic> _safeList(dynamic value) {
  if (value is List) return value;
  return [];
}
