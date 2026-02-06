
import 'dart:async';
import 'package:dating_app/providers/MyChat/pending_request_provider.dart';
import 'package:dating_app/providers/MyChat/random_user_provider.dart';
import 'package:dating_app/services/Call/fcm_service.dart';
import 'package:dating_app/services/Online/online.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';

import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import 'firebase_options.dart';
import 'config/zego_config.dart';

/// 🔔 Providers
import 'providers/auth_provider.dart';
import 'providers/navbar/navbar_provider.dart';
import 'providers/LocationProvider/location_provider.dart';
import 'providers/nearby_user_provider.dart';
import 'providers/room_provider.dart';
import 'providers/user_profile_provider.dart';
import 'providers/ChatMessage/chat_message_provider.dart';
import 'providers/MyChat/chat_provider.dart';
import 'providers/Follow/follow_provider.dart';
import 'providers/moderation/moderation_provider.dart';
import 'providers/moderation/blocked_users_provider.dart';
import 'providers/Coin/coins_provider.dart';

/// 🔔 Services
import 'services/user_service.dart';

/// 🔔 UI
import 'views/onboarding/onboarding_screen.dart';
import 'views/theme/app_theme.dart';

/// 🔑 GLOBAL NAVIGATOR (REQUIRED)
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// 🔔 FCM BACKGROUND HANDLER
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 🔒 Lock orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  /// 🔥 Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(
    firebaseMessagingBackgroundHandler,
  );

  await FCMService.init();


  /// 🔥 ZEGO CORE INIT (NO USER)
  await ZegoUIKit().init(
    appID: ZegoConfig.appID,
    appSign: ZegoConfig.appSign,
    scenario: ZegoScenario.StandardVideoCall,
  );

  /// 🔥 REQUIRED — Call UI wiring
  ZegoUIKitPrebuiltCallInvitationService()
      .setNavigatorKey(navigatorKey);

  ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
    [ZegoUIKitSignalingPlugin()],
  );

    SocketPresenceService().init();


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavbarProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => RoomProvider()),
        ChangeNotifierProvider(create: (_) => NearbyUserProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => ChatMessageProvider()),
        ChangeNotifierProvider(create: (_) => FollowProvider()),
        ChangeNotifierProvider(create: (_) => ModerationProvider()),
        ChangeNotifierProvider(create: (_) => BlockedUsersProvider()),
        ChangeNotifierProvider(create: (_) => CoinsProvider()),
                ChangeNotifierProvider(create: (_) => RandomUserProvider()),
                                ChangeNotifierProvider(create: (_) => PendingRequestProvider()),


        ChangeNotifierProvider(
          create: (_) => UserProfileProvider(
            UserService(baseUrl: 'http://31.97.206.144:4055'),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Dating App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const OnboardingScreen(),

      /// 🔥 REQUIRED FOR ZEGO CALL UI
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            ZegoUIKitPrebuiltCallMiniOverlayPage(
              contextQuery: () => navigatorKey.currentContext!,
            ),
          ],
        );
      },
    );
  }
}





