import 'package:flutter/foundation.dart';

import '../models/room_model.dart';
import '../services/room_service.dart';

class RoomProvider extends ChangeNotifier {
  final RoomService _service = RoomService();

  List<Room> _rooms = [];
  bool _isLoading = false;
  String? _error;

  List<Room> get rooms => _rooms;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchRooms() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _rooms = await _service.fetchRooms();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

Future<bool> createRoom({
  required String userId,
  required String type,
  required String tag,
  required String startDateTime,
  required String duration
}) async {
  try {
    final success = await _service.createRoom(
      userId: userId,
      type: type,
      tag: tag,
      startDateTime: startDateTime,
      duration: duration
    );

    if (success) {
      // ✅ re-fetch full list from API
      await fetchRooms();
      return true;
    } else {
      _error = 'Failed to create room';
      notifyListeners();
      return false;
    }
  } catch (e) {
    _error = e.toString();
    notifyListeners();
    return false;
  }
}

}
