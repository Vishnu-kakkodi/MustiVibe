class BlockResponseModel {
  final bool success;
  final String message;

  BlockResponseModel({
    required this.success,
    required this.message,
  });

  factory BlockResponseModel.fromJson(Map<String, dynamic> json) {
    return BlockResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
