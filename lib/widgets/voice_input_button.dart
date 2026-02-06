import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceInputButton extends StatefulWidget {
  final TextEditingController controller;

  const VoiceInputButton({
    super.key,
    required this.controller,
  });

  @override
  State<VoiceInputButton> createState() => _VoiceInputButtonState();
}

class _VoiceInputButtonState extends State<VoiceInputButton> {
  late stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  /// Check + Request mic permission
  Future<bool> _checkMicPermission() async {
    var status = await Permission.microphone.status;

    if (status.isGranted) {
      return true;
    }

    if (status.isDenied || status.isRestricted) {
      final result = await Permission.microphone.request();
      return result.isGranted;
    }

    // Permission permanently denied
    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }

    return false;
  }

  Future<void> _toggleListening() async {
    final hasPermission = await _checkMicPermission();
    if (!hasPermission) return;

    if (!_isListening) {
      final available = await _speech.initialize(
        onStatus: (status) => debugPrint('Speech status: $status'),
        onError: (err) => debugPrint('Speech error: $err'),
      );

      if (!available) return;

      setState(() => _isListening = true);

      _speech.listen(
        localeId: "en_IN", // or auto: leave empty
        onResult: (result) {
          setState(() {
            widget.controller.text = result.recognizedWords;
            widget.controller.selection = TextSelection.fromPosition(
              TextPosition(offset: widget.controller.text.length),
            );
          });
        },
      );
    } else {
      setState(() => _isListening = false);
      await _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IconButton(
      onPressed: _toggleListening,
      icon: Icon(
        _isListening ? Icons.mic : Icons.mic_none,
        color: _isListening
            ? theme.colorScheme.primary
            : theme.iconTheme.color?.withOpacity(0.7),
      ),
      tooltip: 'Speak to fill',
    );
  }
}
