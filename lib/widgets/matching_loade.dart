import 'package:flutter/material.dart';
import 'dart:async';

class MatchingLoader extends StatefulWidget {
  final String? topImageUrl;
  final String? bottomImageUrl;
  final String loadingText;
  final Future<dynamic> Function() apiCall;
  final Function(dynamic) onComplete;
  final Duration minDisplayDuration;

  const MatchingLoader({
    Key? key,
    this.topImageUrl,
    this.bottomImageUrl,
    this.loadingText = "Matching you with\nwhat truly fits",
    required this.apiCall,
    required this.onComplete,
    this.minDisplayDuration = const Duration(seconds: 7),
  }) : super(key: key);

  @override
  State<MatchingLoader> createState() => _MatchingLoaderState();
}

class _MatchingLoaderState extends State<MatchingLoader> {
  bool _minTimeElapsed = false;
  dynamic _apiResponse;
  bool _apiCompleted = false;

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  void _startLoading() async {
    // Start minimum time timer
    Future.delayed(widget.minDisplayDuration, () {
      if (mounted) {
        setState(() {
          _minTimeElapsed = true;
        });
        _checkCompletion();
      }
    });

    // Start API call
    try {
      final response = await widget.apiCall();
      if (mounted) {
        setState(() {
          _apiResponse = response;
          _apiCompleted = true;
        });
        _checkCompletion();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _apiResponse = {'error': e.toString()};
          _apiCompleted = true;
        });
        _checkCompletion();
      }
    }
  }

  void _checkCompletion() {
    if (_minTimeElapsed && _apiCompleted) {
      widget.onComplete(_apiResponse);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFF3F8),
              Colors.white,
            ],
          ),
        ),
        child: Stack(
          children: [
            // Decorative background circles
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFF8BBD0).withOpacity(0.3),
                ),
              ),
            ),
            Positioned(
              bottom: -150,
              left: -150,
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFF8BBD0).withOpacity(0.2),
                ),
              ),
            ),
            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Top image with radio waves
                  _buildTopImageWithWaves(),
                  SizedBox(height: 80),
                  // Arrow
                  _buildArrow(),
                  SizedBox(height: 20),
                  // Bottom image (You)
                  _buildBottomImage(),
                  SizedBox(height: 12),
                  Text(
                    'You',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 30),
                  // Loading text
                  _buildLoadingText(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopImageWithWaves() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Radio wave animations
        RadioWaves(),
        // Top avatar
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: Offset(0, 5),
              ),
            ],
            border: Border.all(color: Colors.white, width: 4),
          ),
          child: ClipOval(
            child: widget.topImageUrl != null
                ? Image.network(
                    widget.topImageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _buildDefaultAvatar(Colors.blue),
                  )
                : _buildDefaultAvatar(Colors.blue),
          ),
        ),
      ],
    );
  }

  Widget _buildArrow() {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 10),
      duration: Duration(milliseconds: 1000),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, value),
          child: Icon(
            Icons.arrow_downward,
            size: 32,
            color: Colors.grey[400],
          ),
        );
      },
      onEnd: () {
        if (mounted) setState(() {});
      },
    );
  }

  Widget _buildBottomImage() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, 5),
          ),
        ],
        border: Border.all(color: Colors.white, width: 4),
      ),
      child: ClipOval(
        child: widget.bottomImageUrl != null
            ? Image.network(
                widget.bottomImageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _buildDefaultAvatar(Colors.red),
              )
            : _buildDefaultAvatar(Colors.red),
      ),
    );
  }

  Widget _buildDefaultAvatar(Color color) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color,
            color.withOpacity(0.7),
          ],
        ),
      ),
      child: Icon(
        Icons.person,
        size: 50,
        color: Colors.white,
      ),
    );
  }

  Widget _buildLoadingText() {
    return Column(
      children: [
        Text(
          widget.loadingText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
            height: 1.5,
          ),
        ),
        SizedBox(height: 16),
        // Progress bar
        Container(
          width: 200,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: null,
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(
                Color(0xFFEC407A),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Radio Waves Animation Widget
class RadioWaves extends StatefulWidget {
  @override
  State<RadioWaves> createState() => _RadioWavesState();
}

class _RadioWavesState extends State<RadioWaves>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            _buildWave(130, _controller.value, 0.75),
            _buildWave(160, (_controller.value + 0.3) % 1, 0.5),
            _buildWave(190, (_controller.value + 0.6) % 1, 0.25),
          ],
        );
      },
    );
  }

  Widget _buildWave(double size, double value, double maxOpacity) {
    return Container(
      width: size + (value * 50),
      height: size + (value * 50),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey[400]!.withOpacity(maxOpacity * (1 - value)),
          width: 2,
        ),
      ),
    );
  }
}
