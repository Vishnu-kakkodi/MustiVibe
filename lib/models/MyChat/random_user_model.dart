class RandomUserModel {
  final String id;
  final String name;
  final String nickname;
  final String profileImage;
  final bool isOnline;
  final bool isFollow;
  final bool isFollowed;
  final bool isBlocked;
  final bool isChatApproved;

  RandomUserModel({
    required this.id,
    required this.name,
    required this.nickname,
    required this.profileImage,
    required this.isOnline,
    required this.isFollow,
    required this.isFollowed,
    required this.isBlocked,
    required this.isChatApproved,
  });

  factory RandomUserModel.fromJson(Map<String, dynamic> json) {
    return RandomUserModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      nickname: json['nickname'] ?? '',
      profileImage: json['profileImage'] ?? '',
      isOnline: json['isOnline'] ?? false,
      isFollow: json['isFollow'] ?? false,
      isFollowed: json['isFollowed'] ?? false,
      isBlocked: json['isBlocked'] ?? false,
      isChatApproved: json['isChatApproved'] ?? false,
    );
  }
}
