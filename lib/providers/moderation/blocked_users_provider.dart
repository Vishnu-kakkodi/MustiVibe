import 'package:flutter/material.dart';
import 'package:dating_app/models/moderation/blocked_user_model.dart';
import 'package:dating_app/services/moderation/moderation_service.dart';

class BlockedUsersProvider extends ChangeNotifier {
  final ModerationService _service = ModerationService();

  bool isLoading = false;
  List<BlockedUserModel> users = [];

  Future<void> loadBlockedUsers(String userId) async {
    isLoading = true;
    notifyListeners();

    try {
      users = await _service.fetchBlockedUsers(userId);
    } catch (_) {}

    isLoading = false;
    notifyListeners();
  }

  Future<bool> unblock({
    required String fromUser,
    required String toUser,
  }) async {
    final success =
        await _service.unblockUser(fromUser: fromUser, toUser: toUser);

    if (success) {
      users.removeWhere((u) => u.userId == toUser);
      notifyListeners();
    }

    return success;
  }
}
