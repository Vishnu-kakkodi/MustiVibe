import 'package:flutter/material.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

class CallScreen extends StatefulWidget {
  final String roomId;
  final String token;
  final String userId;
  final bool isVideo;

  const CallScreen({
    super.key,
    required this.roomId,
    required this.token,
    required this.userId,
    required this.isVideo,
  });

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {

  Widget? localView;
  Widget? remoteView;

  @override
  void initState() {
    super.initState();
    startCall();
  }

  Future<void> startCall() async {

    /// Mic + camera
    await ZegoExpressEngine.instance.enableCamera(widget.isVideo);
    await ZegoExpressEngine.instance.muteMicrophone(false);

    /// Listen for remote stream
    ZegoExpressEngine.onRoomStreamUpdate = (
      roomID,
      updateType,
      streamList,
      extendedData,
    ) async {
      if (updateType == ZegoUpdateType.Add) {

        final stream = streamList.first;

        /// Create remote view
        remoteView = await ZegoExpressEngine.instance
            .createCanvasView((viewID) {});

        setState(() {});

        await ZegoExpressEngine.instance.startPlayingStream(
          stream.streamID,
          canvas: ZegoCanvas(0),
        );
      }
    };

    /// Login room
    final config = ZegoRoomConfig(
      10,
      true,
      widget.token,
    );

    await ZegoExpressEngine.instance.loginRoom(
      widget.roomId,
      ZegoUser(widget.userId, widget.userId),
      config: config,
    );

    /// Local preview
    if (widget.isVideo) {
      localView = await ZegoExpressEngine.instance
          .createCanvasView((viewID) {});

      setState(() {});

      await ZegoExpressEngine.instance.startPreview(
        canvas: ZegoCanvas(0),
      );
    }

    /// Publish stream
    await ZegoExpressEngine.instance
        .startPublishingStream("stream_${widget.userId}");
  }

  Future<void> endCall() async {
    await ZegoExpressEngine.instance.stopPublishingStream();
    await ZegoExpressEngine.instance.stopPreview();
    await ZegoExpressEngine.instance.logoutRoom(widget.roomId);

    if (mounted) Navigator.pop(context);
  }

  @override
  void dispose() {
    endCall();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [

          /// Remote video
          if (remoteView != null)
            Positioned.fill(child: remoteView!),

          /// Local preview
          if (localView != null && widget.isVideo)
            Positioned(
              right: 20,
              top: 50,
              width: 120,
              height: 160,
              child: localView!,
            ),

          /// End button
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: endCall,
                child: const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.red,
                  child: Icon(Icons.call_end, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
