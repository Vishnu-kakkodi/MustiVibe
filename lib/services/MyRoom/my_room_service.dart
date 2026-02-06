import 'dart:convert';
import 'package:dating_app/models/MyRoom/my_room_model.dart';
import 'package:http/http.dart' as http;

class MyRoomService {
  static const baseUrl = 'http://31.97.206.144:4055/api/users';

  static Future<List<MyRoom>> getMyRooms(String userId) async {
    final res = await http.get(Uri.parse('$baseUrl/myrooms/$userId'));
    final data = jsonDecode(res.body);
    return (data['rooms'] as List)
        .map((e) => MyRoom.fromJson(e))
        .toList();
  }

  static Future<bool> updateRoom({
    required String userId,
    required String roomId,
    required String type,
    required String tag,
    required String startDateTime,
  }) async {
    final res = await http.put(
      Uri.parse('$baseUrl/updatemyroom/$userId/$roomId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "type": type,
        "tag": tag,
        "startDateTime": startDateTime,
      }),
    );
    return jsonDecode(res.body)['success'] == true;
  }

  static Future<bool> deleteRoom({
    required String userId,
    required String roomId,
  }) async {
    final res = await http.delete(
      Uri.parse('$baseUrl/deletemyroom/$userId/$roomId'),
    );
    return jsonDecode(res.body)['success'] == true;
  }
}
