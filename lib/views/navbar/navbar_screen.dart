
// import 'package:dating_app/views/home/chat_screen.dart';
// import 'package:dating_app/views/home/connect_friends_screen.dart';
// import 'package:dating_app/views/home/home_screen.dart';
// import 'package:dating_app/views/home/interact_screen.dart';
// import 'package:dating_app/views/home/room_screen.dart';
// import 'package:dating_app/views/profile/profile_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MainNavigationScreen extends StatefulWidget {
//   const MainNavigationScreen({Key? key}) : super(key: key);

//   @override
//   State<MainNavigationScreen> createState() => _MainNavigationScreenState();
// }

// class _MainNavigationScreenState extends State<MainNavigationScreen> {
//   int _currentIndex = 0;

//   String? userId;
//   String? name;
//   bool _loadingUser = true;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserId();
//   }

//   /// ✅ LOAD USER ID ON APP START
//   Future<void> _loadUserId() async {
//     final prefs = await SharedPreferences.getInstance();
//     final id = prefs.getString('userId');
//     final username = prefs.getString('name');

//     if (!mounted) return;

//     setState(() {
//       userId = id ?? '';
//       name = username ?? '';
//       _loadingUser = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     /// ⏳ WAIT UNTIL USER ID IS LOADED
//     if (_loadingUser) {
//       return const Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     /// ✅ SCREENS WITH REAL USER ID
//     final List<Widget> screens = [
//       const HomeScreen(),
//       InteractScreen(currentUserId: userId!),
//       const RoomScreen(),
//       // ConnectFriendsScreen(), // later if needed
//                   ChatScreen(),
//                               ProfileScreen(),



//     ];

//     return Scaffold(
//       body: screens[_currentIndex],
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: theme.colorScheme.surface,
//           boxShadow: [
//             BoxShadow(
//               color: theme.brightness == Brightness.light
//                   ? Colors.black.withOpacity(0.05)
//                   : Colors.black.withOpacity(0.3),
//               blurRadius: 10,
//               offset: const Offset(0, -2),
//             ),
//           ],
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 _buildNavItem(
//                   context: context,
//                   index: 0,
//                   icon: Icons.home_outlined,
//                   activeIcon: Icons.home,
//                   label: 'Home',
//                 ),
//                 _buildNavItem(
//                   context: context,
//                   index: 1,
//                   icon: Icons.call_outlined,
//                   activeIcon: Icons.call,
//                   label: 'Interact',
//                 ),
//                 _buildNavItem(
//                   context: context,
//                   index: 2,
//                   icon: Icons.grid_view_outlined,
//                   activeIcon: Icons.grid_view,
//                   label: 'Room',
//                 ),

//                                                 _buildNavItem(
//                   context: context,
//                   index: 3,
//                   icon: Icons.message,
//                   activeIcon: Icons.grid_view,
//                   label: 'Messages',
//                 ),
//                                                 _buildNavItem(
//                   context: context,
//                   index: 4,
//                   icon: Icons.person,
//                   activeIcon: Icons.grid_view,
//                   label: 'Profile',
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNavItem({
//     required BuildContext context,
//     required int index,
//     required IconData icon,
//     required IconData activeIcon,
//     required String label,
//   }) {
//     final theme = Theme.of(context);
//     final isSelected = _currentIndex == index;

//     final Color activeColor = theme.colorScheme.primary;
//     final Color inactiveColor =
//         theme.colorScheme.onSurface.withOpacity(0.5);

//     final Color color = isSelected ? activeColor : inactiveColor;

//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _currentIndex = index;
//         });
//       },
//       behavior: HitTestBehavior.opaque,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               isSelected ? activeIcon : icon,
//               color: color,
//               size: 24,
//             ),
//             if (isSelected) ...[
//               const SizedBox(width: 8),
//               Text(
//                 label,
//                 style: TextStyle(
//                   color: color,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }
















// import 'package:dating_app/views/home/chat_screen.dart';
// import 'package:dating_app/views/home/connect_friends_screen.dart';
// import 'package:dating_app/views/home/home_screen.dart';
// import 'package:dating_app/views/home/interact_screen.dart';
// import 'package:dating_app/views/home/room_screen.dart';
// import 'package:dating_app/views/profile/profile_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MainNavigationScreen extends StatefulWidget {
//   const MainNavigationScreen({Key? key}) : super(key: key);

//   @override
//   State<MainNavigationScreen> createState() => _MainNavigationScreenState();
// }

// class _MainNavigationScreenState extends State<MainNavigationScreen> {
//   int _currentIndex = 0;

//   String? userId;
//   String? name;
//   bool _loadingUser = true;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserId();
//   }

//   /// ✅ LOAD USER ID ON APP START
//   Future<void> _loadUserId() async {
//     final prefs = await SharedPreferences.getInstance();
//     final id = prefs.getString('userId');
//     final username = prefs.getString('name');

//     if (!mounted) return;

//     setState(() {
//       userId = id ?? '';
//       name = username ?? '';
//       _loadingUser = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     /// ⏳ WAIT UNTIL USER ID IS LOADED
//     if (_loadingUser) {
//       return const Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     /// ✅ SCREENS WITH REAL USER ID
//     final List<Widget> screens = [
//       const HomeScreen(),
//       InteractScreen(currentUserId: userId!),
//       ConnectFriendsScreen(), // Camera Screen in center
//       ChatScreen(),
//       ProfileScreen(),
//     ];

//     return Scaffold(
//       body: screens[_currentIndex],
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: theme.colorScheme.surface,
//           boxShadow: [
//             BoxShadow(
//               color: theme.brightness == Brightness.light
//                   ? Colors.black.withOpacity(0.05)
//                   : Colors.black.withOpacity(0.3),
//               blurRadius: 10,
//               offset: const Offset(0, -2),
//             ),
//           ],
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 _buildNavItem(
//                   context: context,
//                   index: 0,
//                   icon: Icons.home_outlined,
//                   activeIcon: Icons.home,
//                 ),
//                 _buildNavItem(
//                   context: context,
//                   index: 1,
//                   icon: Icons.call_outlined,
//                   activeIcon: Icons.call,
//                 ),
//                 // EMPTY SPACE FOR FLOATING BUTTON
//                 const SizedBox(width: 56),
//                 _buildNavItem(
//                   context: context,
//                   index: 3,
//                   icon: Icons.message_outlined,
//                   activeIcon: Icons.message,
//                 ),
//                 _buildNavItem(
//                   context: context,
//                   index: 4,
//                   icon: Icons.person_outline,
//                   activeIcon: Icons.person,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       floatingActionButton: _buildFloatingCameraButton(context),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }

//   /// 📸 FLOATING CAMERA BUTTON (Snapchat Style)
//   Widget _buildFloatingCameraButton(BuildContext context) {
//     final theme = Theme.of(context);
//     final isSelected = _currentIndex == 2;

//     return Container(
//       margin: const EdgeInsets.only(top: 30),
//       child: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             _currentIndex = 2;
//           });
//         },
//         elevation: isSelected ? 8 : 6,
//         backgroundColor: Colors.transparent,
//         child: Container(
//           width: 60,
//           height: 60,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             gradient: LinearGradient(
//               colors: isSelected
//                   ? [
//                       theme.colorScheme.primary,
//                       theme.colorScheme.primary.withOpacity(0.8),
//                     ]
//                   : [
//                       theme.colorScheme.primary.withOpacity(0.9),
//                       theme.colorScheme.primary.withOpacity(0.7),
//                     ],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: theme.colorScheme.primary.withOpacity(0.5),
//                 blurRadius: 15,
//                 offset: const Offset(0, 5),
//               ),
//             ],
//           ),
//           child: Icon(
//            Icons.shuffle_rounded,
//             color: Colors.white,
//             size: 30,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNavItem({
//     required BuildContext context,
//     required int index,
//     required IconData icon,
//     required IconData activeIcon,
//   }) {
//     final theme = Theme.of(context);
//     final isSelected = _currentIndex == index;

//     final Color activeColor = theme.colorScheme.primary;
//     final Color inactiveColor = theme.colorScheme.onSurface.withOpacity(0.5);

//     final Color color = isSelected ? activeColor : inactiveColor;

//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _currentIndex = index;
//         });
//       },
//       behavior: HitTestBehavior.opaque,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Icon(
//           isSelected ? activeIcon : icon,
//           color: color,
//           size: 26,
//         ),
//       ),
//     );
//   }
// }














import 'package:dating_app/views/home/chat_screen.dart';
import 'package:dating_app/views/home/connect_friends_screen.dart';
import 'package:dating_app/views/home/home_screen.dart';
import 'package:dating_app/views/home/interact_screen.dart';
import 'package:dating_app/views/home/room_screen.dart';
import 'package:dating_app/views/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  String? userId;
  String? name;
  bool _loadingUser = true;

  @override
  void initState() {
    super.initState();
    _loadUserId();
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// ✅ LOAD USER ID ON APP START
  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('userId');
    final username = prefs.getString('name');

    if (!mounted) return;

    setState(() {
      userId = id ?? '';
      name = username ?? '';
      _loadingUser = false;
    });
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    /// ⏳ WAIT UNTIL USER ID IS LOADED
    if (_loadingUser) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    /// ✅ SCREENS WITH REAL USER ID
    final List<Widget> screens = [
      const HomeScreen(),
      InteractScreen(currentUserId: userId!),
      ConnectFriendsScreen(), // Camera Screen in center
      ChatScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: _buildCurvedNavBar(theme),
      floatingActionButton: _buildFloatingCameraButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  /// 🎨 CURVED NAVIGATION BAR
  Widget _buildCurvedNavBar(ThemeData theme) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: theme.brightness == Brightness.light
                ? Colors.black.withOpacity(0.08)
                : Colors.black.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: ClipPath(
        clipper: CurvedNavBarClipper(),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            gradient: theme.brightness == Brightness.dark
                ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      theme.colorScheme.surface,
                      theme.colorScheme.surface.withOpacity(0.95),
                    ],
                  )
                : null,
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    context: context,
                    index: 0,
                    icon: Icons.home_outlined,
                    activeIcon: Icons.home,
                    label: 'Home',
                  ),
                  _buildNavItem(
                    context: context,
                    index: 1,
                    icon: Icons.call_outlined,
                    activeIcon: Icons.call,
                    label: 'Calls',
                  ),
                  // EMPTY SPACE FOR FLOATING BUTTON
                  const SizedBox(width: 56),
                  _buildNavItem(
                    context: context,
                    index: 3,
                    icon: Icons.message_outlined,
                    activeIcon: Icons.message,
                    label: 'Chat',
                  ),
                  _buildNavItem(
                    context: context,
                    index: 4,
                    icon: Icons.person_outline,
                    activeIcon: Icons.person,
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 📸 FLOATING CAMERA BUTTON (Enhanced)
  Widget _buildFloatingCameraButton(BuildContext context) {
    final theme = Theme.of(context);
    final isSelected = _currentIndex == 2;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(top: 30),
      child: ScaleTransition(
        scale: isSelected ? _scaleAnimation : const AlwaysStoppedAnimation(1.0),
        child: FloatingActionButton(
          onPressed: () => _onNavItemTapped(2),
          elevation: isSelected ? 10 : 6,
          backgroundColor: Colors.transparent,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: isSelected
                    ? [
                        theme.colorScheme.primary,
                        theme.colorScheme.primary.withOpacity(0.8),
                      ]
                    : [
                        theme.colorScheme.primary.withOpacity(0.9),
                        theme.colorScheme.primary.withOpacity(0.7),
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withOpacity(isSelected ? 0.6 : 0.4),
                  blurRadius: isSelected ? 20 : 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Icon(
              Icons.shuffle_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }

  /// 🎯 ANIMATED NAV ITEM
  Widget _buildNavItem({
    required BuildContext context,
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final theme = Theme.of(context);
    final isSelected = _currentIndex == index;

    final Color activeColor = theme.colorScheme.primary;
    final Color inactiveColor = theme.colorScheme.onSurface.withOpacity(0.5);

    return GestureDetector(
      onTap: () => _onNavItemTapped(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon with scale animation
            AnimatedScale(
              scale: isSelected ? 1.15 : 1.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Icon(
                isSelected ? activeIcon : icon,
                color: isSelected ? activeColor : inactiveColor,
                size: 20,
              ),
            ),
            const SizedBox(height: 4),
            // Animated indicator dot
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: isSelected ? 6 : 0,
              height: isSelected ? 6 : 0,
              decoration: BoxDecoration(
                color: activeColor,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 🎨 CUSTOM CLIPPER FOR CURVED NAV BAR
class CurvedNavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final curveHeight = 30.0;
    final curveWidth = 80.0;

    // Start from top-left
    path.lineTo(0, 0);
    
    // Draw left side
    path.lineTo(0, size.height);
    
    // Draw bottom
    path.lineTo(size.width, size.height);
    
    // Draw right side
    path.lineTo(size.width, 0);
    
    // Create the curve in the middle
    final centerX = size.width / 2;
    
    // Left curve
    path.lineTo(centerX - curveWidth, 0);
    
    // Bezier curve for the notch
    path.quadraticBezierTo(
      centerX - curveWidth / 2,
      0,
      centerX - curveWidth / 2 + 10,
      curveHeight / 2,
    );
    
    path.quadraticBezierTo(
      centerX,
      curveHeight,
      centerX + curveWidth / 2 - 10,
      curveHeight / 2,
    );
    
    path.quadraticBezierTo(
      centerX + curveWidth / 2,
      0,
      centerX + curveWidth,
      0,
    );
    
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}