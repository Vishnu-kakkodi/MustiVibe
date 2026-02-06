import 'package:dating_app/views/auth/login_screen.dart';
import 'package:dating_app/views/navbar/call_intro_screen.dart';
import 'package:dating_app/views/navbar/navbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  bool _checkingLogin = true; // loader state until pref is checked

  final List<OnboardingContent> _contents = [
    OnboardingContent(
      image: 'assets/onboardimage.png',
      title: 'Meet Real People. Build\nReal Bonds.',
      description: 'Find genuine friends and connections\nthat go beyond just swipes.',
    ),
    OnboardingContent(
      image: 'assets/onboardlove.png',
      title: '100% Safe & Secure\nSpace',
      description: 'Verified profiles, respectful chats and\nprivacy you can trust',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    if (userId != null && userId.isNotEmpty) {
      // Already logged in → go to home
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => DatingAppWelcomeScreen(isLoggedIn: true,)),
        );
      });
    } else {
      // Not logged in → show onboarding
      setState(() {
        _checkingLogin = false;
      });
    }
  }

  void _goToLoginScreen() {
    print("iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  DatingAppWelcomeScreen(isLoggedIn: false,)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    // Show blank screen while checking login status
    if (_checkingLogin) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/splashrectangle.png',
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: _goToLoginScreen,
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (value) {
                      setState(() => _currentPage = value);
                    },
                    itemCount: _contents.length,
                    itemBuilder: (context, index) {
                      return OnboardingPage(content: _contents[index]);
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: List.generate(
                            _contents.length,
                            (index) => _buildDotIndicator(context, index),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                primary,
                                primary.withOpacity(0.9),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: IconButton(
                            onPressed: () {
                              if (_currentPage == _contents.length - 1) {
                                _goToLoginScreen();
                              } else {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            icon: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDotIndicator(BuildContext context, int index) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final bool isActive = _currentPage == index;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 8,
      width: isActive ? 24 : 8,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: isActive ? primary : theme.colorScheme.onSurface.withOpacity(0.2),
      ),
    );
  }
}

class OnboardingContent {
  final String image;
  final String title;
  final String description;

  OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

class OnboardingPage extends StatelessWidget {
  final OnboardingContent content;

  const OnboardingPage({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.headlineSmall?.copyWith(
      fontWeight: FontWeight.bold,
      height: 1.3,
      color: theme.colorScheme.onBackground,
    );
    final descStyle = theme.textTheme.bodyMedium?.copyWith(
      fontSize: 15,
      height: 1.4,
      color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            child: Image.asset(
              content.image,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 40),
          Text(content.title, textAlign: TextAlign.center, style: titleStyle),
          const SizedBox(height: 16),
          Text(content.description, textAlign: TextAlign.center, style: descStyle),
        ],
      ),
    );
  }
}
