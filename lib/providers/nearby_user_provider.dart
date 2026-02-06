import 'package:flutter/foundation.dart';

import '../models/nearby_user_model.dart';
import '../services/nearby_user_service.dart';

class NearbyUserProvider extends ChangeNotifier {
  final NearbyUserService _service = NearbyUserService();

  List<NearbyUser> _users = [];
  bool _isLoading = false;
  String? _error;

  List<NearbyUser> get users => _users;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchNearbyUsers(String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _users = await _service.fetchNearbyUsers(userId);
    } catch (e) {
      _error = e.toString();
      _users = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
