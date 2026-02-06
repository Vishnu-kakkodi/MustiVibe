class FollowResponseModel {
  final bool success;
  final String message;

  FollowResponseModel({
    required this.success,
    required this.message,
  });

  factory FollowResponseModel.fromJson(Map<String, dynamic> json) {
    return FollowResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
