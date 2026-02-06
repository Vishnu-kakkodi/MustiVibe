// lib/services/auth_service.dart
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:dating_app/core/api_constants.dart';
import 'package:dating_app/models/user_model.dart';
import 'package:dating_app/services/Call/fcm_service.dart';


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
    required String gender, // 'male'/'female'
    required DateTime dob,
    required String referralCode,
    required String language,
    required String userType, // 'normal'
    File? profileImage, // optional for now
  }) async {
    final uri = Uri.parse(ApiConstants.createProfile(userId));

    final request = http.MultipartRequest('PUT', uri);

    request.fields['name'] = name;
    request.fields['nickname'] = nickname;
    request.fields['gender'] = gender;
    request.fields['dob'] = dob.toIso8601String().split('T').first;
    request.fields['referralCode'] = referralCode;
    request.fields['language'] = language;
    request.fields['userType'] = userType;
      print("lsffksjfldsjjfdjffjsfjjfslfjl");

    if (profileImage != null) {
      print("lsffksjfldsjjfdjffjsfjjfslfjl");
      request.files.add(
        await http.MultipartFile.fromPath('profileImage', profileImage.path),
      );
    }


    final streamed = await request.send();
    final response = await http.Response.fromStream(streamed);
    final data = jsonDecode(response.body);
    print("Response: $data");

    if (response.statusCode == 200 && data['success'] == true) {
      final userJson = data['user'];
      return UserModel.fromJson(userJson);
    } else {
      throw Exception(data['message'] ?? 'Failed to create profile');
    }
  }
}
