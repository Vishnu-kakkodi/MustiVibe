// lib/services/auth_service.dart
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:dating_app/core/api_constants.dart';
import 'package:dating_app/models/user_model.dart';
import 'package:dating_app/services/Call/fcm_service.dart';
import 'package:http_parser/http_parser.dart';



class SendOtpResponse {
  final bool success;
  final String message;
  final String token;
  final String otp; // for testing

  SendOtpResponse({
    required this.success,
    required this.message,
    required this.token,
    required this.otp,
  });
}

class VerifyOtpResponse {
  final bool success;
  final String message;
  final bool isNewUser;
  final String goTo;
  final String token;
  final String? userId;
  final UserModel? user;

  VerifyOtpResponse({
    required this.success,
    required this.message,
    required this.isNewUser,
    required this.goTo,
    required this.token,
    this.userId,
    this.user,
  });
}

class AuthService {
  final http.Client _client = http.Client();

  Future<SendOtpResponse> sendOtp(String mobile) async {
    final response = await _client.post(
      Uri.parse(ApiConstants.sendOtp),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'mobile': mobile}),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['success'] == true) {
      return SendOtpResponse(
        success: true,
        message: data['message'] ?? '',
        token: data['token'],
        otp: data['otp'] ?? '',
      );
    } else {
      throw Exception(data['message'] ?? 'Failed to send OTP');
    }
  }

  Future<VerifyOtpResponse> verifyOtp({
    required String otp,
    required String token,
  }) async {
      final fcmToken = await FCMService.getToken();
      print("FCM TOKEN PRINING: $fcmToken");

    final response = await _client.post(
      Uri.parse(ApiConstants.verifyOtp),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': token, 'otp': otp, 'fcmToken': fcmToken,}),
    );

    final data = jsonDecode(response.body);

    print('Response status code for verify otppppppppppp ${response.statusCode}');
        print('Response bodyyyyyyyyyy for verify otppppppppppp ${response.body}');


    if (response.statusCode == 200 && data['success'] == true) {
      UserModel? user;
      if (data['user'] != null) {
        user = UserModel.fromJson(data['user']);
      }

      return VerifyOtpResponse(
        success: true,
        message: data['message'] ?? '',
        isNewUser: data['isNewUser'] ?? false,
        goTo: data['goTo'] ?? '',
        token: data['token'],
        userId: data['userId'],
        user: user,
      );
    } else {
      throw Exception(data['message'] ?? 'Failed to verify OTP');
    }
  }

Future<UserModel> createProfile({
  required String userId,
  required String name,
  required String nickname,
  required String gender,
  required DateTime dob,
  required String referralCode,
  required String language,
  required String userType,
  File? profileImage,
}) async {
  try {
    final uri = Uri.parse(ApiConstants.createProfile(userId));

    print("🚀 API URL: $uri");

    final request = http.MultipartRequest('PUT', uri);

    /// ✅ ADD FIELDS
    request.fields['name'] = name;
    request.fields['nickname'] = nickname;
    request.fields['gender'] = gender;
    request.fields['dob'] = dob.toIso8601String().split('T').first;
    request.fields['referralCode'] = referralCode;
    request.fields['language'] = language;
    request.fields['userType'] = userType;

    /// ✅ ADD IMAGE
 if (profileImage != null) {
  final ext = profileImage.path.split('.').last.toLowerCase();

  MediaType mediaType;

  switch (ext) {
    case 'jpg':
    case 'jpeg':
      mediaType = MediaType('image', 'jpeg');
      break;
    case 'png':
      mediaType = MediaType('image', 'png');
      break;
    case 'gif':
      mediaType = MediaType('image', 'gif');
      break;
    default:
      throw Exception("Unsupported image type");
  }

  request.files.add(
    await http.MultipartFile.fromPath(
      'profileImage',
      profileImage.path,
      contentType: mediaType,
    ),
  );
}

    /// ✅ PRINT FULL PAYLOAD (POSTMAN FRIENDLY)
    print("\n========== MULTIPART PAYLOAD ==========");

    request.fields.forEach((key, value) {
      print("FIELD ➜ $key: $value");
    });

    if (profileImage != null) {
      final fileName = profileImage.path.split('/').last;
      final ext = profileImage.path.split('.').last.toLowerCase();
      final size = await profileImage.length();

      print("FILE ➜ profileImage");
      print("   name: $fileName");
      print("   format: $ext");
      print("   size: ${(size / 1024).toStringAsFixed(2)} KB");
    }

    print("=======================================\n");

    /// ✅ PRINT JSON VIEW
    print("📦 JSON VIEW (fields only):");
    print(jsonEncode(request.fields));

    /// ✅ PRINT HEADERS
    print("📨 HEADERS: ${request.headers}");

    print("📡 Sending request...");

    final streamed = await request.send();

    print("✅ Status Code: ${streamed.statusCode}");

    final response = await http.Response.fromStream(streamed);

    print("📥 RAW RESPONSE:");
    print(response.body);

    final data = jsonDecode(response.body);

    print("📥 DECODED RESPONSE:");
    print(data);

    if (response.statusCode == 200 && data['success'] == true) {
      return UserModel.fromJson(data['user']);
    } else {
      throw Exception(data['message'] ?? 'Failed to create profile');
    }
  } catch (e) {
    print("❌ ERROR OCCURRED:");
    print(e);
    rethrow;
  }
}

}
