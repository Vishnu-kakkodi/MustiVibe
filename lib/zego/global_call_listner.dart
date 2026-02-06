
import 'package:flutter/material.dart';

class GlobalCallListener extends StatelessWidget {
  final Widget child;
  const GlobalCallListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class CallSignal {
  static String? incomingCallId;
  static String? callerId;
  static String? callerName;
  static bool isVideo = false;

  static void clear() {
    incomingCallId = null;
    callerId = null;
    callerName = null;
    isVideo = false;
  }
}



