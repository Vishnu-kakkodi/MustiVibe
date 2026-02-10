
// import 'dart:math';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
// import 'package:dating_app/services/Call/call_api_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';


// class ZegoCallHelper {

//   static String _generateCallId() {
//     return DateTime.now().millisecondsSinceEpoch.toString() +
//         Random().nextInt(999).toString();
//   }

//   /// AUDIO CALL
//   static Future<void> startAudioCall({
//     required String targetUserId,
//     required String targetUserName,
//   }) async {
//     // 🛡 Safety guard
//     if (!ZegoUIKitPrebuiltCallInvitationService().isInit) {
//       print('❌ Zego Call Invitation Service not initialized yet');
//       return;
//     }

//     final String callId = _generateCallId();
//        final prefs = await SharedPreferences.getInstance();
//     final String senderId = prefs.getString('userId').toString();
//       print('RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR$senderId');
//             print('RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR$targetUserId');

//       print('RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR$callId');


//     /// 🔥 CALL API (before starting Zego call)
//     await CallApiService.sendCallingRequest(
//       senderId: senderId,
//       receiverId: targetUserId,
//       callId: callId,
//       callType: 'audio',
//     );


//     /// 🔥 START ZEGO AUDIO CALL
//     ZegoUIKitPrebuiltCallInvitationService().send(
//       callID: callId,
//       isVideoCall: false,
//       invitees: [
//         ZegoCallUser(
//           targetUserId,
//           targetUserName,
//         ),
//       ],
//     );
//   }

//   /// VIDEO CALL
//   static Future<void> startVideoCall({
//     required String targetUserId,
//     required String targetUserName,
//   }) async {
//     if (!ZegoUIKitPrebuiltCallInvitationService().isInit) {
//       print('❌ Zego Call Invitation Service not initialized yet');
//       return;
//     }

//     final String callId = _generateCallId();
//           final prefs = await SharedPreferences.getInstance();
//     final String senderId = prefs.getString('userId').toString();

//     /// 🔥 CALL API
//     await CallApiService.sendCallingRequest(
//       senderId: senderId,
//       receiverId: targetUserId,
//       callId: callId,
//       callType: 'video',
//     );

//     /// 🔥 START ZEGO VIDEO CALL
//     ZegoUIKitPrebuiltCallInvitationService().send(
//       callID: callId,
//       isVideoCall: true,
//       invitees: [
//         ZegoCallUser(
//           targetUserId,
//           targetUserName,
//         ),
//       ],
//     );
//   }
// }











import 'dart:math';
import 'dart:async';

import 'package:dating_app/main.dart';
import 'package:dating_app/views/navbar/navbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:dating_app/services/Call/call_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ZegoCallHelper {
  static Timer? _autoEndTimer;

  static String _generateCallId() {
    return DateTime.now().millisecondsSinceEpoch.toString() +
        Random().nextInt(999).toString();
  }

  /// ================= AUDIO CALL =================
  static Future<void> startAudioCall({
      required BuildContext context, // 👈 ADD THIS

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

    print("📞 AUDIO CALL");
    print("Sender: $senderId");
    print("Receiver: $targetUserId");
    print("CallID: $callId");

    /// 🔥 Notify backend
    await CallApiService.sendCallingRequest(
      senderId: senderId,
      receiverId: targetUserId,
      callId: callId,
      callType: 'audio',
    );

    /// 🔥 Send Zego invitation
    ZegoUIKitPrebuiltCallInvitationService().send(
      callID: callId,
      isVideoCall: false,
      invitees: [
        ZegoCallUser(targetUserId, targetUserName),
      ],
    );

    /// ✅ AUTO END AFTER 15 SEC (TESTING)
_startAutoEndTimer(context);
  }

  /// ================= VIDEO CALL =================
  static Future<void> startVideoCall({
      required BuildContext context, // 👈 ADD THIS

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

    print("📹 VIDEO CALL");
    print("Sender: $senderId");
    print("Receiver: $targetUserId");
    print("CallID: $callId");

    /// 🔥 Notify backend
    await CallApiService.sendCallingRequest(
      senderId: senderId,
      receiverId: targetUserId,
      callId: callId,
      callType: 'video',
    );

    /// 🔥 Send Zego invitation
    ZegoUIKitPrebuiltCallInvitationService().send(
      callID: callId,
      isVideoCall: true,
      invitees: [
        ZegoCallUser(targetUserId, targetUserName),
      ],
    );

    /// ✅ AUTO END AFTER 15 SEC (TESTING)
_startAutoEndTimer(context);
  }

  /// ================= TIMER =================
static void _startAutoEndTimer(BuildContext context) {
  _autoEndTimer?.cancel();

  _autoEndTimer = Timer(const Duration(seconds: 15), () {
    print("⏱ Auto ending call after 15 seconds");
    // endCall(context);
  });
}


  /// ================= END CALL =================
static Future<void> endCall(BuildContext context) async {
  print("📴 Ending Zego call properly...");
  _autoEndTimer?.cancel();

  bool result = await ZegoUIKitPrebuiltCallController().hangUp(
    context,
    showConfirmation: false,
  );

  print("📞 HangUp result: $result");

  /// 👇 SAFE NAVIGATION
  await Future.delayed(const Duration(milliseconds: 300));

  navigatorKey.currentState?.pushAndRemoveUntil(
    MaterialPageRoute(builder: (_) => MainNavigationScreen()),
    (route) => false,
  );
}




}
