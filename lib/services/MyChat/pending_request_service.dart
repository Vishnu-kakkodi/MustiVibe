import 'dart:convert';
import 'package:dating_app/core/api_constants.dart';
import 'package:dating_app/models/MyChat/pending_request_model.dart';
import 'package:http/http.dart' as http;

class PendingRequestService {
  final String baseUrl = ApiConstants.baseUrl;

  Future<List<PendingRequestModel>> fetchPending(String userId) async {
    final res = await http.get(
      Uri.parse('$baseUrl/api/pending-requests/$userId'),
    );
print("UsertId : $userId");
    print("Response body printing: ${res.body}");

    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      return (body['requests'] as List)
          .map((e) => PendingRequestModel.fromJson(e))
          .toList();
    }
    throw Exception('Failed to load pending requests');
  }

  Future<void> handleRequest(String requestId, String action) async {
    final res = await http.put(
      Uri.parse('$baseUrl/api/users/handle/$requestId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'action': action}),
    );
    print("iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii${res.body}");
  }
}
