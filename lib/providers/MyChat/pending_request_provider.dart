import 'package:dating_app/models/MyChat/pending_request_model.dart';
import 'package:dating_app/services/MyChat/pending_request_service.dart';
import 'package:flutter/material.dart';

class PendingRequestProvider extends ChangeNotifier {
  final PendingRequestService _service = PendingRequestService();

  bool isLoading = false;
  List<PendingRequestModel> requests = [];

  Future<void> load(String userId) async {
    isLoading = true;
    notifyListeners();

    requests = await _service.fetchPending(userId);

    isLoading = false;
    notifyListeners();
  }

  Future<void> handle(
    String requestId,
    String action,
    String userId,
  ) async {
    await _service.handleRequest(requestId, action);
    await load(userId);
  }
}
