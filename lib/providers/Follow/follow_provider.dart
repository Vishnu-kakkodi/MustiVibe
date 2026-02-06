import 'package:dating_app/models/follow/follow_response_model.dart';
import 'package:dating_app/services/follow/follow_service.dart';
import 'package:flutter/material.dart';

class FollowProvider extends ChangeNotifier {
  final FollowService _service = FollowService();

  bool isLoading = false;

  Future<bool> follow({
    required String userId,
    required String followId,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      FollowResponseModel response =
          await _service.followUser(userId: userId, followId: followId);

      return response.success;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> unfollow({
    required String userId,
    required String unfollowId,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      FollowResponseModel response =
          await _service.unfollowUser(userId: userId, unfollowId: unfollowId);

      return response.success;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
