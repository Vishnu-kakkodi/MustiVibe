import 'dart:convert';
import 'package:dating_app/core/api_constants.dart';
import 'package:dating_app/models/follow/follow_response_model.dart';
import 'package:http/http.dart' as http;

class FollowService {
  final String baseUrl = ApiConstants.baseUrl;

  // FOLLOW
  Future<FollowResponseModel> followUser({
    required String userId,
    required String followId,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/users/follow'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "userId": userId,
        "followId": followId,
      }),
    );

    print("uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu${response.body}");

    if (response.statusCode == 200) {
      return FollowResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to follow user');
    }
  }

  // UNFOLLOW
  Future<FollowResponseModel> unfollowUser({
    required String userId,
    required String unfollowId,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/users/unfollow'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "userId": userId,
        "followId": unfollowId,
      }),
    );

    if (response.statusCode == 200) {
      return FollowResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to unfollow user');
    }
  }
}
