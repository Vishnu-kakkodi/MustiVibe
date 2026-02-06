
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

// class ZegoCallHelper {
//   static void startAudioCall({
//     required String targetUserId,
//     required String targetUserName,
//   }) {
//     // 🛡 Safety guard
//     if (!ZegoUIKitPrebuiltCallInvitationService().isInit) {
//       print('❌ Zego Call Invitation Service not initialized yet');
//       return;
//     }

//     ZegoUIKitPrebuiltCallInvitationService().send(
//       isVideoCall: false,
//       invitees: [
//         ZegoCallUser(
//           targetUserId,     // 👈 positional
//           targetUserName,   // 👈 positional
//         ),
//       ],
//     );
//   }

//   static void startVideoCall({
//     required String targetUserId,
//     required String targetUserName,
//   }) {
//     if (!ZegoUIKitPrebuiltCallInvitationService().isInit) {
//       print('❌ Zego Call Invitation Service not initialized yet');
//       return;
//     }

//     ZegoUIKitPrebuiltCallInvitationService().send(
//       isVideoCall: true,
//       invitees: [
//         ZegoCallUser(
//           targetUserId,     // 👈 positional
//           targetUserName,   // 👈 positional
//         ),
//       ],
//     );
//   }
// }









import 'dart:math';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:dating_app/services/Call/call_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ZegoCallHelper {

  static String _generateCallId() {
    return DateTime.now().millisecondsSinceEpoch.toString() +
        Random().nextInt(999).toString();
  }

  /// AUDIO CALL
  static Future<void> startAudioCall({
    required String targetUserId,
    required String targetUserName,
  }) async {
    // 🛡 Safety guard
    if (!ZegoUIKitPrebuiltCallInvitationService().isInit) {
      print('❌ Zego Call Invitation Service not initialized yet');
      return;
    }

    final String callId = _generateCallId();
       final prefs = await SharedPreferences.getInstance();
    final String senderId = prefs.getString('userId').toString();

    /// 🔥 CALL API (before starting Zego call)
    await CallApiService.sendCallingRequest(
      senderId: senderId,
      receiverId: targetUserId,
      callId: callId,
      callType: 'audio',
    );

    /// 🔥 START ZEGO AUDIO CALL
    ZegoUIKitPrebuiltCallInvitationService().send(
      callID: callId,
      isVideoCall: false,
      invitees: [
        ZegoCallUser(
          targetUserId,
          targetUserName,
        ),
      ],
    );
  }

  /// VIDEO CALL
  static Future<void> startVideoCall({
    required String targetUserId,
    required String targetUserName,
  }) async {
    if (!ZegoUIKitPrebuiltCallInvitationService().isInit) {
      print('❌ Zego Call Invitation Service not initialized yet');
      return;
    }

    final String callId = _generateCallId();
          final prefs = await SharedPreferences.getInstance();
    final String senderId = prefs.getString('userId').toString();

    /// 🔥 CALL API
    await CallApiService.sendCallingRequest(
      senderId: senderId,
      receiverId: targetUserId,
      callId: callId,
      callType: 'video',
    );

    /// 🔥 START ZEGO VIDEO CALL
    ZegoUIKitPrebuiltCallInvitationService().send(
      callID: callId,
      isVideoCall: true,
      invitees: [
        ZegoCallUser(
          targetUserId,
          targetUserName,
        ),
      ],
    );
  }
}
