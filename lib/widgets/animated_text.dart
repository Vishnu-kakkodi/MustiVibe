import 'package:flutter/material.dart';

class AnimatedTitle extends StatefulWidget {
  const AnimatedTitle({super.key});

  @override
  State<AnimatedTitle> createState() => _AnimatedTitleState();
}

class _AnimatedTitleState extends State<AnimatedTitle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800), // animation duration
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _startLoop();
  }

  void _startLoop() async {
    while (mounted) {
      await _controller.forward();           // animate in
      await Future.delayed(const Duration(seconds: 4)); // stay visible
      _controller.reset();                   // reset
      await Future.delayed(const Duration(seconds: 2)); // pause
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Text(
  'Talk to Someone',
  style: TextStyle(
    fontFamily: 'Cursive',
    color: Colors.white,
    fontSize: 34,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.4,
  ),
),

      ),
    );
  }
}
