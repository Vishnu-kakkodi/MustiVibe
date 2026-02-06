import 'package:dating_app/views/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _cardController;
  late AnimationController _heartController;
  late AnimationController _textController;
  late AnimationController _buttonController;

  late Animation<double> _leftCardSlide;
  late Animation<double> _rightCardSlide;
  late Animation<double> _leftCardRotation;
  late Animation<double> _rightCardRotation;
  late Animation<double> _heartScale;
  late Animation<double> _textFade;
  late Animation<double> _textSlide;
  late Animation<double> _buttonFade;
  late Animation<double> _buttonSlide;

  @override
  void initState() {
    super.initState();

    // Card animation controller
    _cardController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Heart animation controller (repeating)
    _heartController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Text animation controller
    _textController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Button animation controller
    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Card animations
    _leftCardSlide = Tween<double>(begin: -300, end: 0).animate(
      CurvedAnimation(
        parent: _cardController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
      ),
    );

    _rightCardSlide = Tween<double>(begin: 300, end: 0).animate(
      CurvedAnimation(
        parent: _cardController,
        curve: const Interval(0.1, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    _leftCardRotation = Tween<double>(begin: -0.5, end: -0.2).animate(
      CurvedAnimation(
        parent: _cardController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutBack),
      ),
    );

    _rightCardRotation = Tween<double>(begin: 0.5, end: 0.2).animate(
      CurvedAnimation(
        parent: _cardController,
        curve: const Interval(0.1, 0.8, curve: Curves.easeOutBack),
      ),
    );

    // Heart animation (pulsing)
    _heartScale = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: _heartController,
        curve: Curves.easeInOut,
      ),
    );

    // Text animations
    _textFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: Curves.easeIn,
      ),
    );

    _textSlide = Tween<double>(begin: 30, end: 0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: Curves.easeOut,
      ),
    );

    // Button animations
    _buttonFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _buttonController,
        curve: Curves.easeIn,
      ),
    );

    _buttonSlide = Tween<double>(begin: 50, end: 0).animate(
      CurvedAnimation(
        parent: _buttonController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Start animations in sequence
    _startAnimations();
  }

  void _startAnimations() async {
    await _cardController.forward();
    _heartController.repeat(reverse: true);
    await _textController.forward();
    await _buttonController.forward();
  }

  @override
  void dispose() {
    _cardController.dispose();
    _heartController.dispose();
    _textController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/splashrectangle.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 1),
              // Illustration section
              SizedBox(
                height: 280,
                child: AnimatedBuilder(
                  animation: Listenable.merge([_cardController, _heartController]),
                  builder: (context, child) {
                    return Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        // Right card (behind) - Peach/Tan card
                        Positioned(
                          right: 40 + _rightCardSlide.value,
                          top: 30,
                          child: Transform.rotate(
                            angle: _rightCardRotation.value,
                            child: Container(
                              width: 160,
                              height: 200,
                              decoration: BoxDecoration(
                                color: const Color(0xFFD4B5A0),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/splashimage.png',
                                      height: 140,
                                      fit: BoxFit.contain,
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Left card (front) - Gray card
                        Positioned(
                          left: 50 + _leftCardSlide.value,
                          top: 70,
                          child: Transform.rotate(
                            angle: _leftCardRotation.value,
                            child: Container(
                              width: 160,
                              height: 200,
                              decoration: BoxDecoration(
                                color: const Color(0xFFD4D4D4),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/splashgirl.png',
                                      height: 140,
                                      fit: BoxFit.contain,
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Heart icons with pulsing animation
                        Positioned(
                          left: 20,
                          top: 30,
                          child: Transform.scale(
                            scale: _heartScale.value,
                            child: Icon(
                              Icons.favorite,
                              color: Colors.red.shade400,
                              size: 24,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 15,
                          top: 60,
                          child: Transform.scale(
                            scale: _heartScale.value * 0.9,
                            child: Icon(
                              Icons.favorite,
                              color: Colors.red.shade300,
                              size: 18,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 20,
                          bottom: 40,
                          child: Transform.scale(
                            scale: _heartScale.value * 1.1,
                            child: Icon(
                              Icons.favorite,
                              color: Colors.red.shade400,
                              size: 24,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 15,
                          bottom: 20,
                          child: Transform.scale(
                            scale: _heartScale.value,
                            child: Icon(
                              Icons.favorite,
                              color: Colors.red.shade300,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 40),
              // Text content with fade and slide animation
              AnimatedBuilder(
                animation: _textController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _textFade.value,
                    child: Transform.translate(
                      offset: Offset(0, _textSlide.value),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          'Discover real friends with\ncomplete safety',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const Spacer(flex: 2),
              // Button with fade and slide animation
              AnimatedBuilder(
                animation: _buttonController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _buttonFade.value,
                    child: Transform.translate(
                      offset: Offset(0, _buttonSlide.value),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>OnboardingScreen()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFE0A62),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              "Let's Go",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}