import 'package:dating_app/models/MyChat/random_user_model.dart';
import 'package:dating_app/services/MyChat/random_user_service.dart';
import 'package:flutter/material.dart';

class RandomUserProvider extends ChangeNotifier {
  final RandomUserService _service = RandomUserService();

  bool isLoading = false;
  List<RandomUserModel> users = [];

  Future<void> loadRandomUsers(String userId) async {
    isLoading = true;
    notifyListeners();

    try {
      users = await _service.fetchRandomUsers(userId);
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    notifyListeners();
  }
}
