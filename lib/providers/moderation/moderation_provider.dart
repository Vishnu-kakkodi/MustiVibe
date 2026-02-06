import 'package:flutter/material.dart';
import 'package:dating_app/services/moderation/moderation_service.dart';

class ModerationProvider extends ChangeNotifier {
  final ModerationService _service = ModerationService();

  bool isLoading = false;

  Future<bool> block({
    required String fromUser,
    required String toUser,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final res = await _service.blockUser(
        fromUser: fromUser,
        toUser: toUser,
      );

      return res.success;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> report({
    required String reportedBy,
    required String reportedUser,
    required String reason,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final res = await _service.reportUser(
        reportedBy: reportedBy,
        reportedUser: reportedUser,
        reason: reason,
      );

      return res.success;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
