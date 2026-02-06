// lib/models/user_model.dart
class UserModel {
  final String id;
  final String mobile;
  final String? name;
  final String? nickname;
  final String? gender;
  final String? profileImage;
  final String? language;
  final String? referralCode;
  final String? userType;

  UserModel({
    required this.id,
    required this.mobile,
    this.name,
    this.nickname,
    this.gender,
    this.profileImage,
    this.language,
    this.referralCode,
    this.userType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? json['id'],
      mobile: json['mobile'] ?? '',
      name: json['name'],
      nickname: json['nickname'],
      gender: json['gender'],
      profileImage: json['profileImage'],
      language: json['language'],
      referralCode: json['referralCode'],
      userType: json['userType'],
    );
  }
}
