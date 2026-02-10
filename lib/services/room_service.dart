import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/room_model.dart';

class RoomService {
  static const String _baseUrl = 'http://31.97.206.144:4055';

  /// GET /api/users/all
  Future<List<Room>> fetchRooms() async {
    final uri = Uri.parse('$_baseUrl/api/users/all');

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load rooms (${response.statusCode})');
    }

    final data = json.decode(response.body) as Map<String, dynamic>;
    final List<dynamic> roomsJson = data['rooms'] as List<dynamic>? ?? [];

    return roomsJson
        .map((roomJson) => Room.fromJson(roomJson as Map<String, dynamic>))
        .toList();
  }

  /// POST /api/users/create
Future<bool> createRoom({
  required String userId,
  required String type,
  required String tag,
  required String startDateTime,
  required String duration,
}) async {

  final uri = Uri.parse('$_baseUrl/api/users/create');

  // ✅ Build payload map
  final payload = {
    'userId': userId,
    'type': type.toLowerCase(),
    'tag': tag,
    'startDateTime': startDateTime,
    'duration': int.parse(duration),
  };

  // ✅ PRINT PAYLOAD (Postman-friendly)
  print("🚀 API URL: $uri");
  print("📦 PAYLOAD MAP:");
  print(payload);

  print("📦 PAYLOAD JSON:");
  print(jsonEncode(payload));

  final response = await http.post(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(payload),
  );

  print("📥 RESPONSE STATUS: ${response.statusCode}");
  print("📥 RESPONSE BODY: ${response.body}");

  return response.statusCode == 200 || response.statusCode == 201;
}


}
