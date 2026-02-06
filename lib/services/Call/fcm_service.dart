// import 'dart:async';
// import 'package:dating_app/services/Call/call_api_service.dart';
// import 'package:dating_app/services/Call/call_status.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';

// class FCMService {
//   static final FirebaseMessaging _fcm = FirebaseMessaging.instance;

//   // ================= INITIALIZE =================
//   static Future<void> init() async {
//     // 1️⃣ Permission
//     await _fcm.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );

//     // 2️⃣ Background handler
//     FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);

//     // 3️⃣ Foreground message
//     FirebaseMessaging.onMessage.listen(_handleMessage);

//     // 4️⃣ Opened from notification
//     FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

//     // 5️⃣ Killed state
//     _checkInitialMessage();

//     // 6️⃣ Token refresh listener (VERY IMPORTANT)
//     _fcm.onTokenRefresh.listen(_onTokenRefresh);
//   }

//   // ================= BACKGROUND =================
//   @pragma('vm:entry-point')
//   static Future<void> _firebaseBackgroundHandler(
//     RemoteMessage message,
//   ) async {
//     await Firebase.initializeApp();
//     _handleMessage(message);
//   }

//   // ================= COMMON HANDLER =================
//   static Future<void> _handleMessage(RemoteMessage message) async {
//     final data = message.data;
//     if (data['type'] != 'incoming_call') return;

//     debugPrint('📞 Incoming call FCM: $data');

//     // 🔥 Only backend sync — UI handled by ZEGO
//     await CallApiService.updateCallStatus(
//       data['callId'],
//       CallStatus.ringing,
//     );
//   }

//   // ================= KILLED STATE =================
//   static Future<void> _checkInitialMessage() async {
//     final message = await _fcm.getInitialMessage();
//     if (message != null) {
//       await _handleMessage(message);
//     }
//   }

//   // ================= GET TOKEN =================
//   static Future<String?> getToken() async {
//     final token = await _fcm.getToken();
//     debugPrint('📱 FCM Token: $token');
//     return token;
//   }

//   // ================= TOKEN REFRESH =================
//   static Future<void> _onTokenRefresh(String token) async {
//     debugPrint('🔄 FCM Token refreshed: $token');

//     // 🔥 Send updated token to backend
//     // await UserApiService.updateFcmToken(token);
//   }
// }














import 'dart:async';
import 'package:dating_app/services/Call/call_api_service.dart';
import 'package:dating_app/services/Call/call_status.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FCMService {
  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  // ================= INITIALIZE =================
  static Future<void> init() async {
    debugPrint('🔥 Initializing FCM');

    // 1️⃣ Request permission (iOS + Android 13+)
    await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // 2️⃣ Background handler
    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);

    // 3️⃣ Foreground messages
    FirebaseMessaging.onMessage.listen((message) {
      debugPrint('📲 FCM FOREGROUND');
      _handleMessage(message);
    });

    // 4️⃣ Opened from background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      debugPrint('📲 FCM OPENED FROM BACKGROUND');
      _handleMessage(message);
    });

    // 5️⃣ Killed state
    _checkInitialMessage();

    // 6️⃣ Token refresh
    _fcm.onTokenRefresh.listen(_onTokenRefresh);
  }

  // ================= BACKGROUND =================
  @pragma('vm:entry-point')
  static Future<void> _firebaseBackgroundHandler(
    RemoteMessage message,
  ) async {
    await Firebase.initializeApp();
    debugPrint('📲 FCM BACKGROUND');
    await _handleMessage(message);
  }

  // ================= MAIN HANDLER =================
  static Future<void> _handleMessage(RemoteMessage message) async {
    debugPrint('================= FCM TRIGGERED =================');

    debugPrint('🆔 Message ID: ${message.messageId}');
    debugPrint('📦 Data: ${message.data}');
    debugPrint('🔔 Title: ${message.notification?.title}');
    debugPrint('🔔 Body: ${message.notification?.body}');
    debugPrint('📱 From: ${message.from}');
    debugPrint('📅 Sent time: ${message.sentTime}');

    final data = message.data;
    final type = data['type'];

    if (type == 'incoming_call') {
      await _handleIncomingCall(data);
    } else {
      _handleNormalNotification(type, data);
    }

    debugPrint('=================================================');
  }

  // ================= CALL HANDLER =================
  static Future<void> _handleIncomingCall(
    Map<String, dynamic> data,
  ) async {
    debugPrint('📞 Incoming Call Notification');

    if (data['callId'] == null) {
      debugPrint('❌ callId missing');
      return;
    }

    // 🔥 Backend sync only (UI handled by ZEGO)
    await CallApiService.updateCallStatus(
      data['callId'],
      CallStatus.ringing,
    );
  }

  // ================= NORMAL NOTIFICATIONS =================
  static void _handleNormalNotification(
    String? type,
    Map<String, dynamic> data,
  ) {
    debugPrint('🔔 Normal Notification Type: $type');

    switch (type) {
      case 'communication_request_update':
        debugPrint(
          '📩 Request ID: ${data['requestId']} | Status: ${data['status']}',
        );
        break;

      case 'follow':
        debugPrint('👤 New follower: ${data['userId']}');
        break;

      case 'unfollow':
        debugPrint('👋 Unfollowed by: ${data['userId']}');
        break;

      case 'message':
        debugPrint('💬 New message in chat: ${data['chatId']}');
        break;

      default:
        debugPrint('⚠️ Unknown notification type');
    }
  }

  // ================= KILLED STATE =================
  static Future<void> _checkInitialMessage() async {
    final message = await _fcm.getInitialMessage();
    if (message != null) {
      debugPrint('📲 FCM OPENED FROM KILLED STATE');
      await _handleMessage(message);
    }
  }

  // ================= GET TOKEN =================
  static Future<String?> getToken() async {
    final token = await _fcm.getToken();
    debugPrint('📱 FCM TOKEN: $token');
    return token;
  }

  // ================= TOKEN REFRESH =================
  static Future<void> _onTokenRefresh(String token) async {
    debugPrint('🔄 FCM TOKEN REFRESHED: $token');

    // Send updated token to backend if needed
    // await UserApiService.updateFcmToken(token);
  }
}
