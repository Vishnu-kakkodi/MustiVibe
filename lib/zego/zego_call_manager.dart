// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
// import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
// import '../config/zego_config.dart';
// import 'global_call_navigator.dart';

// class ZegoCallManager {
//   static bool _initialized = false;

//   static void init({
//     required String userId,
//     required String userName,
//   }) {
//     if (_initialized) return;

//     ZegoUIKitPrebuiltCallInvitationService()
//       ..setNavigatorKey(GlobalCallNavigator.navigatorKey)
//       ..init(
//         appID: ZegoConfig.appID,
//         appSign: ZegoConfig.appSign,
//         userID: userId,
//         userName: userName,
//         plugins: [ZegoUIKitSignalingPlugin()],
//       );

//     _initialized = true;
//   }

//   static void uninit() {
//     ZegoUIKitPrebuiltCallInvitationService().uninit();
//     _initialized = false;
//   }
// }












import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import '../config/zego_config.dart';
import 'global_call_navigator.dart';

// class ZegoCallManager {
//   static bool _initialized = false;

//   /// ✅ Public flag to check before calling
//   static bool get isReady => _initialized;

//   /// ✅ Init must be called ONLY after:
//   /// - user login
//   /// - first frame rendered
//   static void init({
//     required String userId,
//     required String userName,
//   }) {
//     if (_initialized) return;

//     final service = ZegoUIKitPrebuiltCallInvitationService();

//     service
//       ..setNavigatorKey(GlobalCallNavigator.navigatorKey)
//       ..init(
//         appID: ZegoConfig.appID,
//         appSign: ZegoConfig.appSign,
//         userID: userId,
//         userName: userName,
//         plugins:  [
//           ZegoUIKitSignalingPlugin(),
//         ],
//       );

//     _initialized = true;
//   }

//   /// ✅ Call this on logout
//   static void uninit() {
//     if (!_initialized) return;

//     ZegoUIKitPrebuiltCallInvitationService().uninit();
//     _initialized = false;
//   }
// }












class ZegoCallManager {
  static bool _initialized = false;

  static bool get isReady => _initialized;

  static void init({
    required String userId,
    required String userName,
  }) {
    if (_initialized) return;

    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: ZegoConfig.appID,
      appSign: ZegoConfig.appSign,
      userID: userId,
      userName: userName,
      plugins: [ZegoUIKitSignalingPlugin()],
    );

    _initialized = true;
    debugPrint('✅ Zego Call Invitation initialized');
  }

  static void uninit() {
    if (!_initialized) return;
    ZegoUIKitPrebuiltCallInvitationService().uninit();
    _initialized = false;
  }
}
