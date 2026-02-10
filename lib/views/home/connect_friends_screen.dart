
import 'package:dating_app/views/random/random_screen.dart';
import 'package:flutter/material.dart';

class ConnectFriendsScreen extends StatelessWidget {
  const ConnectFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Friends',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const Spacer(flex: 2),
              // Animated floating hearts and icons
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  // Floating decorative elements
                  Positioned(
                    top: -60,
                    left: -20,
                    child: _buildFloatingIcon(Icons.favorite, Colors.pink.shade300, 28),
                  ),
                  Positioned(
                    top: -50,
                    right: -10,
                    child: _buildFloatingIcon(Icons.star, Colors.amber.shade300, 24),
                  ),
                  Positioned(
                    top: -70,
                    right: 60,
                    child: _buildFloatingIcon(Icons.favorite, Colors.pink.shade200, 20),
                  ),
                  Positioned(
                    bottom: -30,
                    left: 20,
                    child: _buildFloatingIcon(Icons.thumb_up, Colors.blue.shade300, 22),
                  ),
                  Positioned(
                    bottom: -25,
                    right: 30,
                    child: _buildFloatingIcon(Icons.favorite, Colors.red.shade300, 26),
                  ),
                  
                  // Center profile image with gradient border
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Colors.pink.shade300,
                          Colors.purple.shade300,
                          Colors.blue.shade300,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pink.shade200.withOpacity(0.5),
                          blurRadius: 20,
                          spreadRadius: 5,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage('assets/homeimage.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              
              // Title
              const Text(
                'Connect with Friends',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12),
              
              // Subtitle
              Text(
                'Discover new connections and\nmake meaningful friendships',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 50),
              
              // Random button with better styling
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      Colors.pink.shade400,
                      Colors.purple.shade400,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pink.shade300.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RandomScreen()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.shuffle_rounded, color: Colors.white, size: 24),
                      SizedBox(width: 12),
                      Text(
                        'Start Random Match',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // Additional options
              // Row(
              //   children: [
              //     Expanded(
              //       child: _buildSecondaryButton(
              //         icon: Icons.group_rounded,
              //         label: 'Browse',
              //         onTap: () {
              //           // Add navigation
              //         },
              //       ),
              //     ),
              //     const SizedBox(width: 16),
              //     Expanded(
              //       child: _buildSecondaryButton(
              //         icon: Icons.chat_bubble_rounded,
              //         label: 'Messages',
              //         onTap: () {
              //           // Add navigation
              //         },
              //       ),
              //     ),
              //   ],
              // ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingIcon(IconData icon, Color color, double size) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: size),
    );
  }

  Widget _buildSecondaryButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.pink.shade200,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.pink.shade400, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
