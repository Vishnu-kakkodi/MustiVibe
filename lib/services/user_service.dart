// lib/services/user_service.dart
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../models/app_user.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  ApiException(this.message, {this.statusCode});

  @override
  String toString() => 'ApiException($statusCode): $message';
}

class UserService {
  final String baseUrl;
  final http.Client _client;
  final String? authToken;

  UserService({
    this.baseUrl = 'http://31.97.206.144:4055',
    http.Client? client,
    this.authToken,
  }) : _client = client ?? http.Client();

  Map<String, String> _defaultHeaders({bool json = true}) {
    return {
      if (json) 'Content-Type': 'application/json',
      if (authToken != null) 'Authorization': 'Bearer $authToken',
    };
  }

  /// GET user profile
  Future<AppUser> getUserProfile(String userId) async {
    final uri = Uri.parse('$baseUrl/api/users/profile/$userId');

    final response = await _client.get(
      uri,
      headers: _defaultHeaders(),
    );

    print("jjjjjjjjjjjjjjjjjjjjjjjjjjjjjj${response.body}");

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiException(
        'Failed to fetch profile',
        statusCode: response.statusCode,
      );
    }

    dynamic decoded;
    try {
      decoded = jsonDecode(response.body);
    } catch (_) {
      throw ApiException('Invalid JSON from server');
    }

    if (decoded is! Map<String, dynamic>) {
      throw ApiException('Unexpected response format');
    }

    final success = decoded['success'] == true;
    if (!success) {
      final msg = decoded['message']?.toString() ?? 'Unknown error';
      throw ApiException(msg);
    }

    final userJson =
        decoded['user'] is Map<String, dynamic> ? decoded['user'] : null;

    if (userJson == null) {
      // handle null user object safely
      throw ApiException('User data is missing in response');
    }

    return AppUser.fromJson(userJson as Map<String, dynamic>);
  }

  /// PUT update full profile with form data (name, nickname, gender, dob, language, userType, profileImage)
  ///
  /// dobString: "2002-10-27" etc.
  /// imageFile: optional local image file for profileImage
  Future<AppUser> updateUserProfile({
    required String userId,
    required String name,
    required String nickname,
    required String gender,
    required String dobString,
    required String language,
    required String userType,
    File? imageFile,
  }) async {
    final uri = Uri.parse('$baseUrl/api/users/createprofile/$userId');

    final request = http.MultipartRequest('PUT', uri);

    // Optional auth header
    if (authToken != null) {
      request.headers['Authorization'] = 'Bearer $authToken';
    }

    // Text fields
    request.fields['name'] = name;
    request.fields['nickname'] = nickname;
    request.fields['gender'] = gender;
    request.fields['dob'] = dobString; // "2002-10-27"
    request.fields['language'] = language;
    request.fields['userType'] = userType;

    // Optional image
    if (imageFile != null && await imageFile.exists()) {
      request.files.add(
        await http.MultipartFile.fromPath('profileImage', imageFile.path),
      );
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    print("jjjjjjjjjjjjjjjjjjjjjjjjjjjjjj${response.body}");

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiException(
        'Failed to update profile',
        statusCode: response.statusCode,
      );
    }

    dynamic decoded;
    try {
      decoded = jsonDecode(response.body);
    } catch (_) {
      throw ApiException('Invalid JSON from server');
    }

    if (decoded is! Map<String, dynamic>) {
      throw ApiException('Unexpected response format');
    }

    final success = decoded['success'] == true;
    if (!success) {
      final msg = decoded['message']?.toString() ?? 'Unknown error';
      throw ApiException(msg);
    }

    final userJson =
        decoded['user'] is Map<String, dynamic> ? decoded['user'] : null;

    if (userJson == null) {
      throw ApiException('User data is missing in response');
    }

    return AppUser.fromJson(userJson as Map<String, dynamic>);
  }

  /// PUT profile image only: /api/users/profileimage/:id
  Future<AppUser> updateProfileImage({
    required String userId,
    required File imageFile,
  }) async {
    if (!await imageFile.exists()) {
      throw ApiException('Image file does not exist');
    }

    final uri = Uri.parse('$baseUrl/api/users/profileimage/$userId');
    final request = http.MultipartRequest('PUT', uri);

    if (authToken != null) {
      request.headers['Authorization'] = 'Bearer $authToken';
    }

    request.files.add(
      await http.MultipartFile.fromPath('profileImage', imageFile.path),
    );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    print("jjjjjjjjjjjjjjjjjjjjjjjjjjjjjj${response.body}");

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiException(
        'Failed to update profile image',
        statusCode: response.statusCode,
      );
    }

    dynamic decoded;
    try {
      decoded = jsonDecode(response.body);
    } catch (_) {
      throw ApiException('Invalid JSON from server');
    }

    if (decoded is! Map<String, dynamic>) {
      throw ApiException('Unexpected response format');
    }

    final success = decoded['success'] == true;
    if (!success) {
      final msg = decoded['message']?.toString() ?? 'Unknown error';
      throw ApiException(msg);
    }

    final userJson =
        decoded['user'] is Map<String, dynamic> ? decoded['user'] : null;

    if (userJson == null) {
      throw ApiException('User data is missing in response');
    }

    return AppUser.fromJson(userJson as Map<String, dynamic>);
  }

  void dispose() {
    _client.close();
  }
}
