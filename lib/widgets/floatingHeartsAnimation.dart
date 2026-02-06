import 'dart:math' as math;
import 'package:flutter/material.dart';

class FloatingHeartsAnimation extends StatefulWidget {
  const FloatingHeartsAnimation({Key? key}) : super(key: key);

  @override
  _FloatingHeartsAnimationState createState() => _FloatingHeartsAnimationState();
}

class _FloatingHeartsAnimationState extends State<FloatingHeartsAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_HeartParticle> _hearts = [];
  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Periodically add new hearts
    _controller.addListener(() {
      if (_random.nextDouble() < 0.1) { // Control frequency of hearts
        _addHeart();
      }
      _updateHearts();
    });
  }

  void _addHeart() {
    setState(() {
      _hearts.add(_HeartParticle(
        x: _random.nextDouble() * 40, // spread width
        opacity: 1.0,
        size: _random.nextDouble() * 15 + 10,
        color: _random.nextBool() ? Colors.red : Colors.pink,
        speed: _random.nextDouble() * 1 + 0.5,
      ));
    });
  }

  void _updateHearts() {
    setState(() {
      for (var heart in _hearts) {
        heart.y -= heart.speed; // Move up
        heart.opacity -= 0.01; // Fade out
      }
      _hearts.removeWhere((h) => h.opacity <= 0);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: HeartPainter(_hearts),
      size: const Size(50, 50),
    );
  }
}

class _HeartParticle {
  double x, y = 0, opacity, size, speed;
  Color color;
  _HeartParticle({required this.x, required this.opacity, required this.size, required this.color, required this.speed});
}

class HeartPainter extends CustomPainter {
  final List<_HeartParticle> hearts;
  HeartPainter(this.hearts);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    for (var heart in hearts) {
      paint.color = heart.color.withOpacity(heart.opacity.clamp(0, 1));
      
      // Drawing a simple heart shape
      final path = Path();
      double width = heart.size;
      double height = heart.size;
      double x = heart.x;
      double y = heart.y + 40; // Start offset

      path.moveTo(x, y + height * 0.35);
      path.cubicTo(x, y, x - width, y, x - width, y + height * 0.35);
      path.cubicTo(x - width, y + height * 0.7, x, y + height, x, y + height);
      path.cubicTo(x, y + height, x + width, y + height * 0.7, x + width, y + height * 0.35);
      path.cubicTo(x + width, y, x, y, x, y + height * 0.35);

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}