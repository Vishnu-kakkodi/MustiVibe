import 'dart:convert';
import 'package:dating_app/core/api_constants.dart';
import 'package:dating_app/models/moderation/block_response_model.dart';
import 'package:dating_app/models/moderation/blocked_user_model.dart';
import 'package:dating_app/models/moderation/report_response_model.dart';
import 'package:http/http.dart' as http;

class ModerationService {
  final String baseUrl = ApiConstants.baseUrl;

  /// BLOCK USER
  Future<BlockResponseModel> blockUser({
    required String fromUser,
    required String toUser,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/users/block'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "fromUser": fromUser,
        "toUser": toUser,
        "type": "chat",
      }),
    );

    print("Resepppppppppppppppppppppppppp${response.body}");

    if (response.statusCode == 200) {
      return BlockResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to block user');
    }
  }

  /// UNBLOCK USER (for future screens)
  Future<bool> unblockUser({
    required String fromUser,
    required String toUser,
  }) async {
    final res = await http.post(
      Uri.parse('$baseUrl/api/users/unblock'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "fromUser": fromUser,
        "toUser": toUser,
      }),
    );

    return res.statusCode == 200;
  }

  /// REPORT USER
  Future<ReportResponseModel> reportUser({
    required String reportedBy,
    required String reportedUser,
    required String reason,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/users/report'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "reportedBy": reportedBy,
        "reportedUser": reportedUser,
        "reason": reason,
      }),
    );

    if (response.statusCode == 200) {
      return ReportResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to report user');
    }
  }


    Future<List<BlockedUserModel>> fetchBlockedUsers(String userId) async {
    final res = await http.get(
      Uri.parse('$baseUrl/api/users/blocked-users/$userId'),
    );

    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      final List list = body['blockedUsers'];
      return list.map((e) => BlockedUserModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load blocked users');
    }
  }

}
