import 'package:dating_app/models/Coin/user_coins_model.dart';
import 'package:dating_app/services/Coin/coins_service.dart';
import 'package:flutter/material.dart';

class CoinsProvider with ChangeNotifier {
  int _coins = 0;
  bool _isLoading = false;
  String? _error;

  int get coins => _coins;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchUserCoins(String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final UserCoinsModel result =
          await CoinsService.getUserCoins(userId);

      if (result.success) {
        _coins = result.totalCoins;
      } else {
        _error = 'Failed to load coins';
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Optional helper (after purchase)
  void addCoins(int value) {
    _coins += value;
    notifyListeners();
  }

  void resetCoins() {
    _coins = 0;
    notifyListeners();
  }
}
