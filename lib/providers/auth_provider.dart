

// lib/providers/auth_provider.dart
import 'dart:io';

import 'package:dating_app/services/Online/online.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dating_app/models/user_model.dart';
import 'package:dating_app/services/auth_service.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _service = AuthService();

  bool isLoading = false;

  String? _mobile;
  String? _otpToken; // token returned from send-otp
  String? _authToken; // token returned from verify-otp (JWT)
  String? _userId;

  UserModel? currentUser;

  // ----- temp profile data -----
  String? profileName;
  String? profileNickname;
  String? profileGender; // 'male' / 'female'
  DateTime? profileDob;
  String? profileReferralCode;
  String? profileLanguage;

  File? profileImageFile;   // manual upload (gallery/camera)
  String? profileAvatarKey; // optional string key if ever needed
  File? profileAvatarFile;  // avatar asset converted to File

  String? get mobile => _mobile;

  // ============================================================
  // 🔥 ADDED SAFE GETTERS (NOTHING ELSE CHANGED)
  // ============================================================

  String? get userId => _userId;

  String? get userName => currentUser?.name;

  // ============================================================

  // ---------------- SEND OTP ----------------
  Future<bool> sendOtp(BuildContext context, String mobile) async {
    try {
      isLoading = true;
      notifyListeners();

      final res = await _service.sendOtp(mobile);
      _mobile = mobile;
      _otpToken = res.token;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(res.message)),
      );

      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // --------------- VERIFY OTP ----------------
  Future<VerifyResult?> verifyOtp(BuildContext context, String otp) async {
    if (_otpToken == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP session expired. Please try again.')),
      );
      return null;
    }

    try {
      isLoading = true;
      notifyListeners();

      final res = await _service.verifyOtp(
        otp: otp,
        token: _otpToken!,
      );

      _authToken = res.token;

      if (res.isNewUser) {
        _userId = res.userId;
        return VerifyResult.newUser;
      } else {
        _userId = res.user?.id;
        currentUser = res.user;
          if (_userId != null) {
    SocketPresenceService().connect(_userId!);
  }
        await _saveUserToPrefs(currentUser!, _authToken!);
        return VerifyResult.existingUser;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ------- set profile draft info from UI ------
  void setBasicProfileInfo({
    required String name,
    required String nickname,
    required String genderInternal,
    required DateTime dob,
    required String referralCode,
  }) {
    profileName = name;
    profileNickname = nickname;
    profileGender =
        genderInternal == 'Boy' ? 'male' : 'female';
    profileDob = dob;
    profileReferralCode = referralCode;
  }

  void setLanguage(String language) {
    profileLanguage = language;
  }

  void setProfileImageFile(File? file) {
    profileImageFile = file;
  }

  Future<void> setAvatarFromAsset(String assetPath) async {
    profileAvatarFile = await _assetToFile(assetPath);
    profileAvatarKey = assetPath;
    notifyListeners();
  }

  // ------------- COMPLETE PROFILE --------------
  Future<bool> completeProfile(BuildContext context) async {
    if (_userId == null ||
        profileName == null ||
        profileNickname == null ||
        profileGender == null ||
        profileDob == null ||
        profileLanguage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile data incomplete')),
      );
      return false;
    }

    try {
      isLoading = true;
      notifyListeners();

      final user = await _service.createProfile(
        userId: _userId!,
        name: profileName!,
        nickname: profileNickname!,
        gender: profileGender!,
        dob: profileDob!,
        referralCode: profileReferralCode ?? '',
        language: profileLanguage!,
        userType: 'normal',
        profileImage: profileImageFile ?? profileAvatarFile,
      );

      currentUser = user;

      if (_authToken != null) {
        await _saveUserToPrefs(user, _authToken!);
      }

      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ------------- SharedPrefs helpers --------------
  Future<void> _saveUserToPrefs(UserModel user, String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', user.id);
    await prefs.setString('name', user.name ?? '');
    await prefs.setString('profileImage', user.profileImage ?? '');
    await prefs.setString('token', token);
  }

  // ------------- Asset -> File helper --------------
  Future<File> _assetToFile(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);

    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/${assetPath.split('/').last}');

    await file.writeAsBytes(
      byteData.buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      ),
    );

    return file;
  }
}

enum VerifyResult { newUser, existingUser }
