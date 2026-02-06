import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/nearby_user_model.dart';

class NearbyUserService {
  static const String _baseUrl = 'http://31.97.206.144:4055';

  /// GET /api/users/nearby-users/{userId}
  Future<List<NearbyUser>> fetchNearbyUsers(String userId) async {
    final uri = Uri.parse('$_baseUrl/api/users/nearby-users/$userId');

    final response = await http.get(uri);

    print("kkkkkkkkkkkkkkkkkk${response.body}");

    if (response.statusCode != 200) {
      throw Exception('Failed to load nearby users (${response.statusCode})');
    }

    final data = json.decode(response.body) as Map<String, dynamic>;
    final List<dynamic> usersJson = data['users'] as List<dynamic>? ?? [];

    return usersJson
        .map((u) => NearbyUser.fromJson(u as Map<String, dynamic>))
        .toList();
  }
}
