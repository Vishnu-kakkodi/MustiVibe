// import 'package:dating_app/zego/zego_call_helper.dart';
// import 'package:flutter/material.dart';

// void showCallOptions({
//   required BuildContext context,
//   required String targetUserId,
//   required String targetUserName,
// }) {
//   showModalBottomSheet(
//     context: context,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//     ),
//     builder: (_) {
//       return Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ListTile(
//             leading: const Icon(Icons.phone),
//             title: const Text('Audio Call'),
//             onTap: () {
//               Navigator.pop(context);
//               ZegoCallHelper.startAudioCall(
//                 targetUserId: targetUserId,
//                 targetUserName: targetUserName,
//               );
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.videocam),
//             title: const Text('Video Call'),
//             onTap: () {
//               Navigator.pop(context);
//               ZegoCallHelper.startVideoCall(
//                 targetUserId: targetUserId,
//                 targetUserName: targetUserName,
//               );
//             },
//           ),
//         ],
//       );
//     },
//   );
// }














import 'package:dating_app/zego/zego_call_helper.dart';
import 'package:flutter/material.dart';

void showCallOptions({
  required BuildContext context,
  required String targetUserId,
  required String targetUserName,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => CallOptionsBottomSheet(
      targetUserId: targetUserId,
      targetUserName: targetUserName,
    ),
  );
}

class CallOptionsBottomSheet extends StatefulWidget {
  final String targetUserId;
  final String targetUserName;

  const CallOptionsBottomSheet({
    Key? key,
    required this.targetUserId,
    required this.targetUserName,
  }) : super(key: key);

  @override
  State<CallOptionsBottomSheet> createState() => _CallOptionsBottomSheetState();
}

class _CallOptionsBottomSheetState extends State<CallOptionsBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          margin: const EdgeInsets.only(top: 100),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.5 : 0.2),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),

              // Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Text(
                      'Call ${widget.targetUserName}',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Choose your call type',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Call Options
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildCallOption(
                        context: context,
                        icon: Icons.phone,
                        label: 'Audio Call',
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue.shade400,
                            Colors.blue.shade600,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          ZegoCallHelper.startAudioCall(
                            targetUserId: widget.targetUserId,
                            targetUserName: widget.targetUserName,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildCallOption(
                        context: context,
                        icon: Icons.videocam,
                        label: 'Video Call',
                        gradient: LinearGradient(
                          colors: [
                            theme.colorScheme.primary,
                            theme.colorScheme.primary.withOpacity(0.8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          ZegoCallHelper.startVideoCall(
                            targetUserId: widget.targetUserId,
                            targetUserName: widget.targetUserName,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Cancel Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onSurface.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'Cancel',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCallOption({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 200),
      tween: Tween(begin: 1.0, end: 1.0),
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: GestureDetector(
            onTapDown: (_) {
              setState(() {
                // Trigger scale animation
              });
            },
            onTapUp: (_) {
              setState(() {
                // Reset scale
              });
              onTap();
            },
            onTapCancel: () {
              setState(() {
                // Reset scale
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: gradient.colors.first.withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}