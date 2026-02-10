// import 'package:flutter/material.dart';
// import 'package:zego_uikit/zego_uikit.dart';
// import 'custom_call_page.dart';
// import '../services/call_api_service.dart';

// class GlobalCallNavigator {
//   static final navigatorKey = GlobalKey<NavigatorState>();
//   static bool _dialogShowing = false;

//   static void showIncomingCallDialog({
//     required String callId,
//     required String callerName,
//     required bool isVideo,
//   }) {
//     if (_dialogShowing) return;
//     _dialogShowing = true;

//     final context = navigatorKey.currentContext;
//     if (context == null) return;

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) => AlertDialog(
//         title: const Text('Incoming Call'),
//         content: Text('$callerName is calling you'),
//         actions: [
//           TextButton(
//             onPressed: () async {
//               await CallApiService.updateCallStatus(callId, 'rejected');
//               _dialogShowing = false;
//               Navigator.pop(context);
//             },
//             child: const Text('Reject'),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               await CallApiService.updateCallStatus(callId, 'accepted');

//               _dialogShowing = false;
//               Navigator.pop(context);

//               final localUser = ZegoUIKit().getLocalUser();

//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => CustomCallPage(
//                     userID: localUser.id,
//                     userName: localUser.name,
//                     callID: callId,
//                     isVideoCall: isVideo,
//                   ),
//                 ),
//               );
//             },
//             child: const Text('Accept'),
//           ),
//         ],
//       ),
//     );
//   }
// }

















// import 'package:flutter/material.dart';
// import 'package:zego_uikit/zego_uikit.dart';

// import 'custom_call_page.dart';
// import 'global_call_listner.dart';

// class GlobalCallNavigator {
//   static final GlobalKey<NavigatorState> navigatorKey =
//       GlobalKey<NavigatorState>();

//   static bool _callScreenOpen = false;

//   /// 🔥 Open call screen (after native ACCEPT)
//   static void openCallScreen(String? callId) {
//     print("Starting   1111");
//     // if (_callScreenOpen) return;
//         print("Starting   222");


//     final context = navigatorKey.currentContext;
//         print("Starting   333");

//     if (context == null) return;
//     print("Starting   444");

//     if (callId == null){
//       print("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy$callId");
//       return;
//     }
//     print("Starting   555");

//     _callScreenOpen = true;
//     print("Starting   666");

//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => CustomCallPage(
//           userID: ZegoUIKit().getLocalUser().id,
//           userName: ZegoUIKit().getLocalUser().name,
//           callID: callId,
//           isVideoCall: CallSignal.isVideo,
//         ),
//       ),
//     );
//   }



//   static void closeCallScreen() {
//   final context = navigatorKey.currentContext;
//   if (context == null) return;

//   if (Navigator.canPop(context)) {
//     Navigator.pop(context);
//   }

//   _callScreenOpen = false;
//   CallSignal.clear();
// }

// }














import 'package:flutter/material.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:dating_app/services/Call/call_api_service.dart'; // Add this import

import 'custom_call_page.dart';
import 'global_call_listner.dart';

class GlobalCallNavigator {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static bool _callScreenOpen = false;

  /// 🔥 Open call screen (after accepting call)
  static Future<void> openCallScreen(String callId, {bool isIncoming = false}) async {
    debugPrint('🔄 Opening call screen with callId: $callId');
    
    // Prevent opening multiple call screens
    if (_callScreenOpen) {
      debugPrint('⚠️ Call screen already open, ignoring duplicate request');
      return;
    }

    final context = navigatorKey.currentContext;
    if (context == null) {
      debugPrint('❌ No context available for navigation');
      return;
    }

    if (callId.isEmpty) {
      debugPrint('❌ Invalid callId: $callId');
      return;
    }

    try {
      _callScreenOpen = true;
      debugPrint('🚀 Navigating to call screen...');

      // If this is for an incoming call that was accepted, update call status
      if (isIncoming && CallSignal.incomingCallId != null) {
        await CallApiService.updateCallStatus(
          CallSignal.incomingCallId!,
          'accepted',
        );
      }

      // Get user info safely
      final localUser = ZegoUIKit().getLocalUser();
      final userID = localUser?.id ?? 'unknown_user';
      final userName = localUser?.name ?? 'User';

      // Navigate to call screen
      // await Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (_) => CustomCallPage(
      //       userID: userID,
      //       userName: userName,
      //       callID: callId,
      //       isVideoCall: CallSignal.isVideo,
      //     ),
      //   ),
      // );

      debugPrint('✅ Call screen opened successfully');
      
    } catch (e) {
      debugPrint('❌ Error opening call screen: $e');
      _callScreenOpen = false;
      rethrow;
    }
  }

  /// 🔥 Close call screen and clean up
  static Future<void> closeCallScreen({bool isCallEnded = false}) async {
    debugPrint('🔄 Closing call screen...');
    
    final context = navigatorKey.currentContext;
    if (context == null) {
      debugPrint('❌ No context available for closing');
      return;
    }

    try {
      // Close the call screen if it's open
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }

      // Update call status if call was ended
      if (isCallEnded && CallSignal.incomingCallId != null) {
        await CallApiService.updateCallStatus(
          CallSignal.incomingCallId!,
          'completed',
        );
      }

      _callScreenOpen = false;
      CallSignal.clear();
      debugPrint('✅ Call screen closed successfully');
      
    } catch (e) {
      debugPrint('❌ Error closing call screen: $e');
      _callScreenOpen = false;
    }
  }

  /// Check if call screen is currently open
  static bool get isCallScreenOpen => _callScreenOpen;
}