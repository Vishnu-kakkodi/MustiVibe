import 'dart:convert';
import 'package:dating_app/core/api_constants.dart';
import 'package:http/http.dart' as http;

class CallApiService {
  static const baseUrl = '${ApiConstants.baseUrl}/api/users';

  static Future<void> sendCallingRequest({
    required String senderId,
    required String receiverId,
    required String callId,
    required String callType,
  }) async {
    print("pppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp$callType");
    final res = await http.post(
      Uri.parse('$baseUrl/sendcallingrequest'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "senderId": senderId,
        "receiverId": receiverId,
        "callerId": callId,
        "callType": callType,
      }),
    );

    print("rrrrrrrrrrrrrrrrrrrrrrrrrrrr${res.body}");
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