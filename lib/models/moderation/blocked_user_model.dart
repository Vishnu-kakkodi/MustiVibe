class BlockedUserModel {
  final String requestId;
  final String userId;
  final String name;
  final String profileImage;
  final bool blockedByMe;
  final String status;
  final DateTime blockedAt;

  BlockedUserModel({
    required this.requestId,
    required this.userId,
    required this.name,
    required this.profileImage,
    required this.blockedByMe,
    required this.status,
    required this.blockedAt,
  });

  factory BlockedUserModel.fromJson(Map<String, dynamic> json) {
    final user = json['blockedUser'] ?? {};

    return BlockedUserModel(
      requestId: json['requestId'] ?? '',
      userId: user['_id'] ?? '',
      name: user['name'] ?? '',
      profileImage: user['profileImage'] ?? '',
      blockedByMe: json['blockedByMe'] ?? false,
      status: json['status'] ?? '',
      blockedAt: DateTime.parse(json['blockedAt']),
    );
  }
}
