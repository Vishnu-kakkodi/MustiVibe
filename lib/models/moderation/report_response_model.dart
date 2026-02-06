class ReportResponseModel {
  final bool success;
  final String message;

  ReportResponseModel({
    required this.success,
    required this.message,
  });

  factory ReportResponseModel.fromJson(Map<String, dynamic> json) {
    return ReportResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
