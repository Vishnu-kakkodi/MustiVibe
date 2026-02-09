import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dating_app/services/Call/call_api_service.dart';
import 'package:dating_app/zego/custom_call_page.dart';

class GlobalCallManager {
  static Future<void> startCall({
    required BuildContext context,
    required String currentUserId,
    required String currentUserName,
    required String targetUserId,
    required String targetUserName,
    required String targetFcmToken,
    required bool isVideo,
  }) async {
    // 1️⃣ Mic permission
    final micStatus = await Permission.microphone.request();
    if (!micStatus.isGranted) {
      _showSnack(context, 'Microphone permission required', Colors.red);
      return;
    }

    // 2️⃣ Check receiver availability
    if (targetFcmToken.isEmpty) {
      _showSnack(context, 'User is not available for calls', Colors.orange);
      return;
    }

    final callId = _buildCallId(currentUserId, targetUserId);

    // 3️⃣ Loader
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      // 4️⃣ Send FCM call request
      // await CallApiService.sendCallingRequest(
      //   senderId: currentUserId,
      //   receiverId: targetUserId,
      //   callId: callId,
      //   callType: isVideo ? 'video' : 'audio',
      // );

      if (!context.mounted) return;
      Navigator.pop(context);

      // 5️⃣ Open call screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CustomCallPage(
            userID: currentUserId,
            userName: currentUserName,
            callID: callId,
            isVideoCall: isVideo,
          ),
        ),
      );
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        _showSnack(context, 'Failed to start call', Colors.red);
      }
    }
  }

  static String _buildCallId(String id1, String id2) {
    final sorted = [id1, id2]..sort();
    return "call_${sorted[0]}_${sorted[1]}";
  }

  static void _showSnack(
      BuildContext context, String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: color),
    );
  }
}
