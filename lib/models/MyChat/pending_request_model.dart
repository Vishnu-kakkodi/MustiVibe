class PendingRequestModel {
  final String requestId;
  final String userId;
  final String name;
  final String profileImage;
  final DateTime createdAt;

  PendingRequestModel({
    required this.requestId,
    required this.userId,
    required this.name,
    required this.profileImage,
    required this.createdAt,
  });

  factory PendingRequestModel.fromJson(Map<String, dynamic> json) {
    final fromUser = json['fromUser'];

    return PendingRequestModel(
      requestId: json['_id'],
      userId: fromUser['_id'],
      name: fromUser['name'] ?? '',
      profileImage: fromUser['profileImage'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
