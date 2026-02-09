import 'dart:convert';
import 'package:dating_app/core/api_constants.dart';
import 'package:http/http.dart' as http;

class CallApiService {
  static const baseUrl = '${ApiConstants.baseUrl}/api/users';

static Future<http.Response> sendCallingRequest({
  required String senderId,
  required String receiverId,
  required String callType,
}) async {

  final response = await http.post(
    Uri.parse('$baseUrl/sendcallingrequest'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      "senderId": senderId,
      "receiverId": receiverId,
      "callType": callType,
    }),
  );

  print("📞 Call API Status: ${response.statusCode}");
  print("📞 Call API Body: ${response.body}");

  return response;
}



  static Future<void> updateCallStatus(
    String callId,
    String status,
  ) async {
    await http.put(
      Uri.parse('$baseUrl/updatecallingstatus/$callId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"status": status}),
    );
  }
}
