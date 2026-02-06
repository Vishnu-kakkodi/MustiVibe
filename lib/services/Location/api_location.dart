import 'dart:convert';
import 'package:dating_app/core/api_constants.dart';
import 'package:http/http.dart' as http;

class ApiLocationService {
  /// Adds user location (latitude & longitude) to the backend
  Future<bool> addLocation({
    required String userId,
    required String latitude,
    required String longitude,
  }) async {
    try {
      final uri = Uri.parse(ApiConstants.location(userId));

      final response = await http.put(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId':userId.toString(),
          'latitude': double.parse(latitude),
          'longitude': double.parse(longitude),
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('❌ Failed to add location - Status: ${response.statusCode}');
        print('🧾 Response: ${response.body}');
        return false;
      }
    } catch (e) {
      print('🚨 Exception while adding location: $e');
      return false;
    }
  }
}
