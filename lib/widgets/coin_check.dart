import 'package:dating_app/views/credits/credits_screen.dart';
import 'package:flutter/material.dart';

class InsufficientCoinsSheet extends StatefulWidget {
  const InsufficientCoinsSheet();

  @override
  State<InsufficientCoinsSheet> createState() =>
      _InsufficientCoinsSheetState();
}

class _InsufficientCoinsSheetState extends State<InsufficientCoinsSheet>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _shakeController;
  late AnimationController _slideController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _shakeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Scale animation for icon
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    );

    // Shake animation for attention
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.easeInOut),
    );

    // Slide animation for content
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    // Start animations
    _scaleController.forward();
    _slideController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _shakeController.forward();
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _shakeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.orange.shade50, Colors.white, Colors.amber.shade50],
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Animated coin icon with pulsing effect
              ScaleTransition(
                scale: _scaleAnimation,
                child: AnimatedBuilder(
                  animation: _shakeAnimation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle:
                          (_shakeAnimation.value * 0.1) *
                          (1 - _shakeAnimation.value),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.amber.shade400,
                              Colors.orange.shade600,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.monetization_on,
                          size: 48,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Animated content
              SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _slideController,
                  child: Column(
                    children: [
                      // Title with gradient
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [
                            Colors.orange.shade700,
                            Colors.amber.shade600,
                          ],
                        ).createShader(bounds),
                        child: const Text(
                          'Oops! Not Enough Coins',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Subtitle
                      Text(
                        'You need at least 10 coins to start a call.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade700,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Animated promo banner
                      _buildPromoBanner(),

                      const SizedBox(height: 24),

                      // Action buttons
                      _buildActionButtons(context),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPromoBanner() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: value,
            child: Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.purple.shade400, Colors.deepPurple.shade600],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Decorative circles
                  Positioned(
                    right: -20,
                    top: -20,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -10,
                    bottom: -10,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ),
                  // Content
                  Center(
                    child: TweenAnimationBuilder<int>(
                      tween: IntTween(begin: 0, end: 100),
                      duration: const Duration(milliseconds: 1200),
                      builder: (context, value, child) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Stacked coins
                                ...List.generate(3, (index) {
                                  return Transform.translate(
                                    offset: Offset(-index * 8.0, 0),
                                    child: Icon(
                                      Icons.monetization_on,
                                      color: Colors.amber.shade300,
                                      size: 36,
                                    ),
                                  );
                                }),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              '+$value Coins',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.amber.shade400,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'BONUS ON FIRST PURCHASE',
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
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

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        // Primary button with gradient
        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CreditsScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              shadowColor: Colors.orange.withOpacity(0.4),
            ),
            child: Ink(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange.shade500, Colors.deepOrange.shade600],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.shopping_cart, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Buy Coins Now',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Secondary button
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: Text(
            'Maybe Later',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
          ),
        ),
      ],
    );
  }
}