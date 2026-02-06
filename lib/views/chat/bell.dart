import 'package:flutter/material.dart';

class AnimatedBell extends StatefulWidget {
  const AnimatedBell({Key? key}) : super(key: key);

  @override
  State<AnimatedBell> createState() => _AnimatedBellState();
}

class _AnimatedBellState extends State<AnimatedBell>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _rotation = Tween<double>(begin: -0.15, end: 0.15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotation,
      builder: (_, child) {
        return Transform.rotate(
          angle: _rotation.value,
          child: child,
        );
      },
      child: const Icon(
        Icons.notifications_active,
        size: 18,
        color: Colors.redAccent,
      ),
    );
  }
}
