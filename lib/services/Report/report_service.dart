import 'dart:convert';
import 'package:http/http.dart' as http;

class ReportService {
  static const String _baseUrl =
      "http://31.97.206.144:4055/api/users/report";

  static Future<bool> submitReport({
    required String reportedBy,
    required String reportedUser,
    required String reason,
  }) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json', // ✅ REQUIRED
      },
      body: jsonEncode({
        "reportedBy": reportedBy,
        "reportedUser": reportedUser,
        "reason": reason,
      }),
    );

    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");

    return response.statusCode == 200 || response.statusCode == 201;
  }
}
