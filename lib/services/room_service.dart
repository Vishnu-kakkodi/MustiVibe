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
  required String type, // "Voice", "chat", etc.
  required String tag,
  required String startDateTime,
  required String duration
}) async {
  final uri = Uri.parse('$_baseUrl/api/users/create');
print("llllllllllllllllllll$uri");

  final response = await http.post(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'userId': userId,
      'type': type,
      'tag': tag,
      'startDateTime': startDateTime,
      'duration': int.parse(duration)
    }),
  );
print("llllllllllllllllllll${response.body}");
  // just check status
  if (response.statusCode == 200 || response.statusCode == 201) {
    return true;
  } else {
    return false;
  }
}

}
