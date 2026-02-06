import 'dart:convert';
import 'package:dating_app/core/api_constants.dart';
import 'package:dating_app/models/MyChat/random_user_model.dart';
import 'package:http/http.dart' as http;

class RandomUserService {
  final String baseUrl = ApiConstants.baseUrl;

  Future<List<RandomUserModel>> fetchRandomUsers(String userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/randomusers/$userId'),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List users = body['users'];
      return users.map((e) => RandomUserModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load random users');
    }
  }
}
