
// import 'dart:async';
// import 'package:dating_app/services/Call/call_api_service.dart';
// import 'package:dating_app/services/Call/call_status.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class FCMService {
//   static final FirebaseMessaging _fcm = FirebaseMessaging.instance;

//   // ================= LOCAL NOTIFICATION =================
//   static final FlutterLocalNotificationsPlugin _localNotifications =
//       FlutterLocalNotificationsPlugin();

//   static const AndroidNotificationChannel _channel =
//       AndroidNotificationChannel(
//     'high_importance_channel',
//     'High Importance Notifications',
//     importance: Importance.max,
//   );

//   // ================= INITIALIZE =================
//   static Future<void> init() async {
//     debugPrint('🔥 Initializing FCM');

//     await _initLocalNotifications();

//     await _fcm.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );

//     FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);

//     FirebaseMessaging.onMessage.listen((message) {
//       debugPrint('📲 FCM FOREGROUND');
//       _showLocalNotification(message);
//       _handleMessage(message);
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       debugPrint('📲 FCM OPENED FROM BACKGROUND');
//       _handleMessage(message);
//     });

//     _checkInitialMessage();

//     _fcm.onTokenRefresh.listen(_onTokenRefresh);
//   }

//   // ================= LOCAL NOTIFICATION INIT =================
// static Future<void> _initLocalNotifications() async {
//   const androidSettings =
//       AndroidInitializationSettings('@mipmap/ic_launcher');

//   const iosSettings = DarwinInitializationSettings();

//   const settings = InitializationSettings(
//     android: androidSettings,
//     iOS: iosSettings,
//   );

//   // ✅ ANDROID 13+ PERMISSION (IMPORTANT)
//   await _localNotifications
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.requestNotificationsPermission();

//   // ✅ Initialize plugin
//   await _localNotifications.initialize(
//     settings: settings,
//   );

//   // ✅ Create channel
//   await _localNotifications
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(_channel);
// }


//   // ================= SHOW LOCAL NOTIFICATION =================
//   static Future<void> _showLocalNotification(RemoteMessage message) async {
//     final notification = message.notification;

//     if (notification == null) return;

//     await _localNotifications.show(
//       id: notification.hashCode,
//       title: notification.title ?? "Notification",
//       body: notification.body ?? "",
//       notificationDetails: NotificationDetails(
//         android: AndroidNotificationDetails(
//           _channel.id,
//           _channel.name,
//           importance: Importance.max,
//           priority: Priority.high,
//         ),
//         iOS: const DarwinNotificationDetails(),
//       ),
//     );
//   }

//   // ================= BACKGROUND =================
//   @pragma('vm:entry-point')
//   static Future<void> _firebaseBackgroundHandler(
//       RemoteMessage message) async {
//     await Firebase.initializeApp();

//     debugPrint('📲 FCM BACKGROUND');

//     await _showLocalNotification(message);
//     await _handleMessage(message);
//   }

//   // ================= MAIN HANDLER =================
//   static Future<void> _handleMessage(RemoteMessage message) async {
//     final data = message.data;
//     final type = data['type'];

//     if (type == 'incoming_call') {
//       await _handleIncomingCall(data);
//     } else {
//       _handleNormalNotification(type, data);
//     }
//   }

//   // ================= CALL HANDLER =================
//   static Future<void> _handleIncomingCall(
//       Map<String, dynamic> data) async {
//     debugPrint('📞 Incoming Call Notification');

//     if (data['callId'] == null) return;

//     await CallApiService.updateCallStatus(
//       data['callId'],
//       CallStatus.ringing,
//     );
//   }

//   // ================= NORMAL NOTIFICATIONS =================
//   static void _handleNormalNotification(
//       String? type, Map<String, dynamic> data) {
//     debugPrint('🔔 Type: $type');

//     switch (type) {
//       case 'communication_request_update':
//         debugPrint(
//             'Request: ${data['requestId']} | Status: ${data['status']}');
//         break;

//       case 'follow':
//         debugPrint('New follower: ${data['userId']}');
//         break;

//       case 'unfollow':
//         debugPrint('Unfollowed by: ${data['userId']}');
//         break;

//       case 'message':
//         debugPrint('New message chat: ${data['chatId']}');
//         break;
//     }
//   }

//   // ================= KILLED STATE =================
//   static Future<void> _checkInitialMessage() async {
//     final message = await _fcm.getInitialMessage();
//     if (message != null) {
//       await _handleMessage(message);
//     }
//   }

//   // ================= TOKEN =================
//   static Future<String?> getToken() async {
//     return await _fcm.getToken();
//   }

//   // ================= TOKEN REFRESH =================
//   static Future<void> _onTokenRefresh(String token) async {
//     debugPrint('🔄 TOKEN REFRESHED: $token');
//   }
// }



















import 'dart:async';
import 'package:dating_app/main.dart';
import 'package:dating_app/services/Call/call_api_service.dart';
import 'package:dating_app/services/Call/call_status.dart';
import 'package:dating_app/views/notification/notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FCMService {
  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  // ================= LOCAL NOTIFICATION =================
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel =
      AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.max,
  );

  // ================= INITIALIZE =================
  static Future<void> init() async {
    debugPrint('🔥 Initializing FCM');

    await _initLocalNotifications();

    await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);

FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  debugPrint("========== FCM FOREGROUND ==========");
  debugPrint("Message ID: ${message.messageId}");
  debugPrint("Title: ${message.notification?.title}");
  debugPrint("Body: ${message.notification?.body}");
  debugPrint("Data: ${message.data}");
  debugPrint("Raw message: ${message.toMap()}");
  debugPrint("=====================================");

  _showLocalNotification(message);
});


FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  debugPrint("====== FCM CLICKED (BACKGROUND) ======");
  debugPrint("Full payload: ${message.toMap()}");
  debugPrint("======================================");

  _handleMessage(message);
});


    _checkInitialMessage();

    _fcm.onTokenRefresh.listen(_onTokenRefresh);
  }

  // ================= LOCAL NOTIFICATION INIT =================
static Future<void> _initLocalNotifications() async {
  const androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const iosSettings = DarwinInitializationSettings();

  const settings = InitializationSettings(
    android: androidSettings,
    iOS: iosSettings,
  );

  // ✅ ANDROID 13+ PERMISSION (IMPORTANT)
  await _localNotifications
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

  // ✅ Initialize plugin
  await _localNotifications.initialize(
    settings: settings,
    onDidReceiveNotificationResponse: (response) {
    _navigateFromPayload(response.payload);
  },

  );

  // ✅ Create channel
  await _localNotifications
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(_channel);
}


  // ================= SHOW LOCAL NOTIFICATION =================
  static Future<void> _showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;

    if (notification == null) return;

    await _localNotifications.show(
      id: notification.hashCode,
      title: notification.title ?? "Notification",
      body: notification.body ?? "",
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      payload: message.data['type'] ?? "notification",
    );
  }

  static void _navigateFromPayload(String? payload) {
  if (payload == null) return;

  navigatorKey.currentState?.push(
    MaterialPageRoute(
      builder: (_) => const NotificationScreen(),
    ),
  );
}


  // ================= BACKGROUND =================
  @pragma('vm:entry-point')
  static Future<void> _firebaseBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();

    debugPrint('📲 FCM BACKGROUND');

    await _showLocalNotification(message);
    // await _handleMessage(message);
  }

  // ================= MAIN HANDLER =================
  static Future<void> _handleMessage(RemoteMessage message) async {
    final data = message.data;
    final type = data['type'];

    if (type == 'incoming_call') {
      await _handleIncomingCall(data);
    } else {
      _handleNormalNotification(type, data);
    }
  }

  // ================= CALL HANDLER =================
  static Future<void> _handleIncomingCall(
      Map<String, dynamic> data) async {
    debugPrint('📞 Incoming Call Notification');

    if (data['callId'] == null) return;

    await CallApiService.updateCallStatus(
      data['callId'],
      CallStatus.ringing,
    );
  }

  // ================= NORMAL NOTIFICATIONS =================
  static void _handleNormalNotification(
    String? type, Map<String, dynamic> data) {

  debugPrint('🔔 Type: $type');

  // 👉 Navigate to notification screen
  navigatorKey.currentState?.push(
    MaterialPageRoute(
      builder: (_) => const NotificationScreen(),
    ),
  );

  // 👉 Optional logic per type
  switch (type) {
    case 'communication_request_update':
      debugPrint(
          'Request: ${data['requestId']} | Status: ${data['status']}');
      break;

    case 'follow':
      debugPrint('New follower: ${data['userId']}');
      break;

    case 'unfollow':
      debugPrint('Unfollowed by: ${data['userId']}');
      break;

    case 'message':
      debugPrint('New message chat: ${data['chatId']}');
      break;
  }
}


  // ================= KILLED STATE =================
static Future<void> _checkInitialMessage() async {
  final message = await _fcm.getInitialMessage();

  if (message != null) {
    debugPrint("====== FCM CLICKED (KILLED) ======");
    debugPrint("Full payload: ${message.toMap()}");
    debugPrint("==================================");

    await _handleMessage(message);
  }
}


  // ================= TOKEN =================
  static Future<String?> getToken() async {
    return await _fcm.getToken();
  }

  // ================= TOKEN REFRESH =================
  static Future<void> _onTokenRefresh(String token) async {
    debugPrint('🔄 TOKEN REFRESHED: $token');
  }
}
