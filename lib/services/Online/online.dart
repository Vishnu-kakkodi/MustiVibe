import 'package:flutter/widgets.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/foundation.dart';

class SocketPresenceService with WidgetsBindingObserver {
  static final SocketPresenceService _instance =
      SocketPresenceService._internal();
  factory SocketPresenceService() => _instance;
  SocketPresenceService._internal();

  IO.Socket? _socket;
  String? _userId;

  void _log(String msg) {
    debugPrint('[SOCKET ${DateTime.now().toIso8601String()}] $msg');
  }

  void init() {
    _log('init() → adding lifecycle observer');
    WidgetsBinding.instance.addObserver(this);
  }

  void connect(String userId) {
    _log('connect() called with userId=$userId');

    _userId = userId;

    if (_socket != null && _socket!.connected) {
      _log('⚠️ Already connected, skipping');
      return;
    }

    _socket = IO.io(
      'http://31.97.206.144:4055',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableReconnection()
          .disableAutoConnect()
          .build(),
    );

    _log('Creating socket instance');

    _socket!.onConnect((_) {
      _log('🟢 onConnect triggered');
      _socket!.emit('user-online', _userId);
      _log('📤 emitted user-online ($_userId)');
    });

    _socket!.onDisconnect((_) {
            _socket!.emit('disconnect', _userId);

      _log('🔴 onDisconnect triggered');
    });

    _socket!.onConnectError((e) {
      _log('❌ onConnectError → $e');
    });

    _socket!.onError((e) {
      _log('❌ onError → $e');
    });

    _socket!.connect();
    _log('socket.connect() called');
  }

  void disconnect() {
    _log('disconnect() called');

    _socket?.disconnect();
    _socket?.dispose();

    _socket = null;
    _userId = null;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _log('AppLifecycleState → $state');

    if (_userId == null) {
      _log('No userId, ignoring lifecycle change');
      return;
    }

    if (state == AppLifecycleState.resumed) {
      _log('App resumed → reconnect socket');
      connect(_userId!);
    } else if (state == AppLifecycleState.paused) {
      _log('App paused → disconnect socket');
      disconnect();
    } else if (state == AppLifecycleState.detached) {
      _log('App detached → disconnect socket');
      disconnect();
    }
  }

  void dispose() {
    _log('dispose() called → removing observer');
    WidgetsBinding.instance.removeObserver(this);
    disconnect();
  }
}
