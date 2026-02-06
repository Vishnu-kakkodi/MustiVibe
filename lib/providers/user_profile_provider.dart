// lib/providers/user_profile_provider.dart
import 'dart:io';

import 'package:flutter/foundation.dart';
import '../models/app_user.dart';
import '../services/user_service.dart';

class UserProfileProvider with ChangeNotifier {
  final UserService _userService;

  AppUser? _user;
  bool _isLoading = false;
  String? _error;

  UserProfileProvider(this._userService);

  AppUser? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _error = message;
    notifyListeners();
  }

  void _setUser(AppUser user) {
    _user = user;
    notifyListeners();
  }

  /// GET profile
  Future<void> loadUserProfile(String userId) async {
    _setLoading(true);
    _setError(null);

    try {
      final result = await _userService.getUserProfile(userId);
      if (result.id.isEmpty) {
        _setError('Invalid user data received');
      } else {
        _setUser(result);
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// PUT full profile (form)
  Future<bool> saveUserProfile({
    required String userId,
    required String name,
    required String nickname,
    required String gender,
    required String dobString, // "2002-10-27"
    required String language,
    required String userType,
    File? imageFile,
  }) async {
    _setLoading(true);
    _setError(null);

    try {
      final updatedUser = await _userService.updateUserProfile(
        userId: userId,
        name: name,
        nickname: nickname,
        gender: gender,
        dobString: dobString,
        language: language,
        userType: userType,
        imageFile: imageFile,
      );
      _setUser(updatedUser);
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// PUT profile image only
  Future<bool> changeProfileImage({
    required String userId,
    required File imageFile,
  }) async {
    _setLoading(true);
    _setError(null);

    try {
      final updatedUser = await _userService.updateProfileImage(
        userId: userId,
        imageFile: imageFile,
      );
      _setUser(updatedUser);
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }
}
