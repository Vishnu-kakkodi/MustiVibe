// import 'dart:convert';
// import 'dart:ui';
// import 'dart:io'; // ✅ NEW

// import 'package:dating_app/views/Earnings/earning_screen.dart';
// import 'package:dating_app/views/auth/login_screen.dart';
// import 'package:dating_app/views/blocked/blocked_chat.dart';
// import 'package:dating_app/views/follow/follow_screen.dart';
// import 'package:dating_app/views/profile/edit_profile.dart';
// import 'package:dating_app/views/profile/refer_and_earn_screen.dart';
// import 'package:dating_app/views/rateapp/rate_app_screen.dart';
// import 'package:dating_app/views/settings/settings_screen.dart';
// import 'package:dating_app/views/transactions/transaction_history.dart';
// import 'package:dating_app/views/warning/warning_text.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:fluttertoast/fluttertoast.dart';

// // 🔹 NEW
// import 'package:provider/provider.dart';
// import 'package:dating_app/providers/user_profile_provider.dart';
// import 'package:intl/intl.dart';
// import 'package:dating_app/models/app_user.dart';

// // 🔹 NEW – to read asset bytes
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:path_provider/path_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   // ------- PROFILE / AVATAR -------
//   int selectedAvatarIndex = 0;

//   final TextEditingController realNameController =
//       TextEditingController(text: '');
//   final TextEditingController nickNameController =
//       TextEditingController(text: '');

//   final List<String> avatarImages = [
//     'assets/boyimage2.png',
//     'assets/boyimage2.png',
//     'assets/boyimage2.png',
//     'assets/boyimage2.png',
//     'assets/boyimage2.png',
//     'assets/boyimage2.png',
//     'assets/boyimage2.png',
//     'assets/boyimage2.png',
//   ];

//   // ------- LANGUAGE -------
//   String _currentLanguage = 'English'; // will be synced from API

//   // replace with your logged-in user id
// String? _userId;
// bool _loadingUserId = true;

//   // replace with your stored token if API needs auth
//   final String? _token =
//       null; // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9....';

//   bool _initializedFromProfile = false;

// @override
// void initState() {
//   super.initState();
//   _loadUserId();
// }

// Future<void> _loadUserId() async {
//   final prefs = await SharedPreferences.getInstance();
//   final id = prefs.getString('userId');

//   if (!mounted) return;

//   setState(() {
//     _userId = id;
//     _loadingUserId = false;
//   });

//   if (_userId != null && _userId!.isNotEmpty) {
//     context.read<UserProfileProvider>().loadUserProfile(_userId!);
//   }
// }

// Future<void> _launchUrl(String url) async {
//   final Uri uri = Uri.parse(url);

//   if (!await launchUrl(
//     uri,
//     mode: LaunchMode.externalApplication,
//   )) {
//     Fluttertoast.showToast(msg: 'Could not open link');
//   }
// }

//   // 🔹 NEW: Convert selected asset avatar to a real File (for upload)
//   Future<File?> _getSelectedAvatarFile() async {
//     try {
//       final String assetPath = avatarImages[selectedAvatarIndex];

//       // Load bytes from asset
//       final byteData = await rootBundle.load(assetPath);
//       final bytes = byteData.buffer.asUint8List();

//       // Write to temporary file
//       final tempDir = await getTemporaryDirectory();
//       final file = File(
//         '${tempDir.path}/avatar_$selectedAvatarIndex.png',
//       );

//       await file.writeAsBytes(bytes, flush: true);
//       return file;
//     } catch (e) {
//       debugPrint('Error creating file from asset: $e');
//       return null;
//     }
//   }

//   // ---------- EDIT PROFILE MODAL ----------
//   void _showEditDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext dialogContext) {
//         final screenHeight = MediaQuery.of(dialogContext).size.height;

//         return StatefulBuilder(
//           builder: (context, setModalState) {
//             return Dialog(
//               insetPadding:
//                   const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(
//                   maxHeight: screenHeight * 0.58,
//                   minWidth: double.infinity,
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Header
//                       Row(
//                         children: [
//                           const Spacer(),
//                           const Text(
//                             'Edit your profile',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const Spacer(),
//                           IconButton(
//                             icon: const Icon(Icons.close),
//                             onPressed: () => Navigator.pop(dialogContext),
//                             padding: EdgeInsets.zero,
//                             constraints: const BoxConstraints(),
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 12),

//                       const Text(
//                         'Select Avatar',
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const SizedBox(height: 10),

//                       // HORIZONTAL AVATAR LIST
//                       SizedBox(
//                         height: 70,
//                         child: ListView.separated(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: avatarImages.length,
//                           separatorBuilder: (_, __) =>
//                               const SizedBox(width: 10),
//                           itemBuilder: (context, index) {
//                             final isSelected = selectedAvatarIndex == index;
//                             return GestureDetector(
//                               onTap: () {
//                                 setModalState(() {
//                                   selectedAvatarIndex = index;
//                                 });
//                               },
//                               child: Container(
//                                 padding: const EdgeInsets.all(2),
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   border: Border.all(
//                                     color: isSelected
//                                         ? Colors.pink
//                                         : Colors.transparent,
//                                     width: 3,
//                                   ),
//                                 ),
//                                 child: CircleAvatar(
//                                   radius: 26,
//                                   backgroundColor: _getAvatarColor(index),
//                                   child: ClipOval(
//                                     child: Image.asset(
//                                       avatarImages[index],
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),

//                       const SizedBox(height: 18),

//                       const Text(
//                         'Edit Details',
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const SizedBox(height: 10),

//                       const Text(
//                         'Real Name',
//                         style: TextStyle(
//                           fontSize: 13,
//                           color: Colors.black87,
//                         ),
//                       ),
//                       const SizedBox(height: 6),

//                       SizedBox(
//                         height: 44,
//                         child: TextField(
//                           controller: realNameController,
//                           decoration: InputDecoration(
//                             contentPadding:
//                                 const EdgeInsets.symmetric(vertical: 10),
//                             prefixIcon: const Icon(
//                               Icons.person_outline,
//                               color: Colors.grey,
//                             ),
//                             suffixIcon: const Icon(
//                               Icons.lock_outline,
//                               color: Colors.grey,
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide(color: Colors.grey[300]!),
//                             ),
//                             focusedBorder: const OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(8)),
//                               borderSide: BorderSide(color: Colors.pink),
//                             ),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 12),

//                       const Text(
//                         'Nick Name',
//                         style: TextStyle(
//                           fontSize: 13,
//                           color: Colors.black87,
//                         ),
//                       ),
//                       const SizedBox(height: 6),

//                       SizedBox(
//                         height: 44,
//                         child: TextField(
//                           controller: nickNameController,
//                           decoration: InputDecoration(
//                             contentPadding:
//                                 const EdgeInsets.symmetric(vertical: 10),
//                             prefixIcon: const Icon(
//                               Icons.person_outline,
//                               color: Colors.grey,
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide(color: Colors.grey[300]!),
//                             ),
//                             focusedBorder: const OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(8)),
//                               borderSide: BorderSide(color: Colors.pink),
//                             ),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 18),

//                       SizedBox(
//                         width: double.infinity,
//                         height: 44,
//                         child: ElevatedButton(
//                           onPressed: () async {
//                             final profileProv =
//                                 context.read<UserProfileProvider>();
//                             final user = profileProv.user;

//                             if (user == null) {
//                               Fluttertoast.showToast(
//                                   msg: 'Profile not loaded yet');
//                               return;
//                             }

//                             // 🔹 Build DOB string (fallback if null)
//                             final dobString = user.dob != null
//                                 ? DateFormat('yyyy-MM-dd').format(user.dob!)
//                                 : '2002-10-27';

//                             // 🔹 Convert selected avatar asset into a File
//                             final avatarFile = await _getSelectedAvatarFile();

//                             final success =
//                                 await profileProv.saveUserProfile(
//                               userId: user.id,
//                               name: realNameController.text.trim(),
//                               nickname: nickNameController.text.trim(),
//                               gender: user.gender ?? 'male',
//                               dobString: dobString,
//                               language: _currentLanguage,
//                               userType: user.userType ?? 'normal',
//                               imageFile:
//                                   avatarFile, // ✅ now sending a real file
//                             );

//                             if (success) {
//                               Fluttertoast.showToast(
//                                   msg: 'Profile updated successfully');
//                               if (mounted) {
//                                 Navigator.pop(dialogContext);
//                               }
//                             } else {
//                               Fluttertoast.showToast(
//                                 msg: profileProv.error ?? 'Update failed',
//                               );
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFFFE0A62),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             elevation: 0,
//                           ),
//                           child: const Text(
//                             'Save',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 15,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   Color _getAvatarColor(int index) {
//     final colors = [
//       Colors.orange,
//       Colors.red,
//       Colors.purple,
//       Colors.blue,
//       Colors.amber,
//       Colors.teal,
//       Colors.pink,
//       Colors.indigo,
//     ];
//     return colors[index % colors.length];
//   }

//   // ---------- LANGUAGE MODAL WITH BLUR ----------
//   void _showLanguageDialog() {
//     showGeneralDialog(
//       context: context,
//       barrierDismissible: true,
//       barrierLabel: 'Language',
//       barrierColor: Colors.black.withOpacity(0.2),
//       transitionDuration: const Duration(milliseconds: 200),
//       pageBuilder: (ctx, anim1, anim2) {
//         String selected = _currentLanguage;
//         bool isSaving = false;

//         Future<void> save() async {
//           if (isSaving) return;
//           isSaving = true;

//           (ctx as Element).markNeedsBuild();

//           await _updateLanguageOnServer(selected);

//           if (mounted) {
//             setState(() {
//               _currentLanguage = selected;
//             });
//           }
//           if (Navigator.of(ctx).canPop()) {
//             Navigator.of(ctx).pop();
//           }
//         }

//         return BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
//           child: Center(
//             child: StatefulBuilder(
//               builder: (context, setModalState) {
//                 void selectLang(String lang) {
//                   setModalState(() {
//                     selected = lang;
//                   });
//                 }

//                 Widget buildOption({
//                   required String label,
//                   required String code,
//                   required String langValue,
//                 }) {
//                   final bool isSelected = selected == langValue;

//                   return GestureDetector(
//                     onTap: () => selectLang(langValue),
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 12,
//                         vertical: 10,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                           color: isSelected
//                               ? const Color(0xFFFE0A62)
//                               : Colors.grey.shade300,
//                           width: 1.4,
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.03),
//                             blurRadius: 4,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 8, vertical: 4),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(6),
//                               border: Border.all(
//                                 color: isSelected
//                                     ? const Color(0xFFFE0A62)
//                                     : Colors.grey.shade300,
//                               ),
//                             ),
//                             child: Text(
//                               code,
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w600,
//                                 color: isSelected
//                                     ? const Color(0xFFFE0A62)
//                                     : Colors.black87,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                           Text(
//                             label,
//                             style: const TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black87,
//                             ),
//                           ),
//                           if (isSelected) ...[
//                             const SizedBox(width: 8),
//                             const Icon(
//                               Icons.check_circle,
//                               size: 16,
//                               color: Color(0xFFFE0A62),
//                             ),
//                           ]
//                         ],
//                       ),
//                     ),
//                   );
//                 }

//                 return Material(
//                   color: Colors.transparent,
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 32),
//                     padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(18),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.15),
//                           blurRadius: 16,
//                           offset: const Offset(0, 6),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         // header
//                         Row(
//                           children: [
//                             const Spacer(),
//                             const Text(
//                               'Select Language',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             const Spacer(),
//                             GestureDetector(
//                               onTap: () => Navigator.of(ctx).pop(),
//                               child: const Icon(
//                                 Icons.close,
//                                 size: 20,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 16),

//                         const SizedBox(height: 6),

// Text(
//   'Note: This is not the app language. It is only for your identity.',
//   textAlign: TextAlign.center,
//   style: TextStyle(
//     fontSize: 12,
//     color: Colors.black54,
//   ),
// ),

//                         // options
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Flexible(
//                               child: buildOption(
//                                 label: 'English',
//                                 code: 'En',
//                                 langValue: 'English',
//                               ),
//                             ),
//                             const SizedBox(width: 10),
//                             Flexible(
//                               child: buildOption(
//                                 label: 'Hindi',
//                                 code: 'अ',
//                                 langValue: 'Hindi',
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 10),
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: buildOption(
//                             label: 'Telugu',
//                             code: 'తెలు',
//                             langValue: 'Telugu',
//                           ),
//                         ),

//                         const SizedBox(height: 18),

//                         SizedBox(
//                           width: double.infinity,
//                           height: 44,
//                           child: ElevatedButton(
//                             onPressed: isSaving
//                                 ? null
//                                 : () async {
//                                     await save();
//                                   },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xFFFE0A62),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                               elevation: 0,
//                             ),
//                             child: isSaving
//                                 ? const SizedBox(
//                                     height: 18,
//                                     width: 18,
//                                     child: CircularProgressIndicator(
//                                       strokeWidth: 2,
//                                       color: Colors.white,
//                                     ),
//                                   )
//                                 : const Text(
//                                     'Save',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _updateLanguageOnServer(String lang) async {
//     final uri = Uri.parse(
//         'http://31.97.206.144:4055/api/users/update-language/$_userId');

//     final headers = <String, String>{
//       'Content-Type': 'application/json',
//     };

//     // if (_token != null) {
//     //   headers['Authorization'] = 'Bearer $_token';
//     // }

//     try {
//       final response = await http.put(
//         uri,
//         headers: headers,
//         body: jsonEncode({'language': lang}),
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final data = jsonDecode(response.body);

//         if (data['success'] == true) {
//           Fluttertoast.showToast(
//             msg: data['message'] ?? "Language updated successfully",
//           );

//           // 🔹 Refresh profile from server so Consumer rebuilds
//           await context
//               .read<UserProfileProvider>()
//               .loadUserProfile(_userId.toString());
//         } else {
//           Fluttertoast.showToast(
//             msg: data['message'] ?? "Something went wrong",
//           );
//         }
//       } else {
//         Fluttertoast.showToast(
//           msg: "Server error: ${response.statusCode}",
//         );
//       }
//     } catch (e) {
//       Fluttertoast.showToast(
//         msg: "Something went wrong: $e",
//       );
//     }
//   }

//   // ---------- BUILD ----------
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<UserProfileProvider>(
//       builder: (context, profileProv, _) {
//         final user = profileProv.user;

//         // Initialize controllers once from user
//         if (user != null && !_initializedFromProfile) {
//           realNameController.text = user.name ?? '';
//           nickNameController.text = user.nickname ?? '';
//           _currentLanguage = user.language ?? _currentLanguage;
//           _initializedFromProfile = true;
//         }

//         return Scaffold(
//           backgroundColor: const Color(0xFFFFF5F5),
//           appBar: AppBar(
//             backgroundColor: const Color(0xFFFFF5F5),
//             elevation: 0,
//             leading: Builder(
//               builder: (context) => IconButton(
//                 icon: const Icon(Icons.menu, color: Colors.black),
//                 onPressed: () {
//                   Scaffold.of(context).openDrawer();
//                 },
//               ),
//             ),
//             actions: [
//               IconButton(
//                 icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//           drawer: Drawer(
//             backgroundColor: Colors.white,
//             width: MediaQuery.of(context).size.width * 0.65,
//             child: ListView(
//               padding: EdgeInsets.zero,
//               children: [
//                 const SizedBox(height: 50),
//                 // GestureDetector(
//                 //   onTap: () {
//                 //     // Navigator.push(
//                 //     //   context,
//                 //     //   MaterialPageRoute(builder: (context) => const EditProfile()),
//                 //     // );
//                 //   },
//                 //   child: _buildMenuItem(
//                 //     context: context,
//                 //     icon: Icons.person_outline,
//                 //     title: 'Edit Profile',
//                 //   ),
//                 // ),
//                 // GestureDetector(
//                 //   onTap: () {
//                 //     Navigator.push(
//                 //       context,
//                 //       MaterialPageRoute(
//                 //           builder: (context) => const TransactionHistory()),
//                 //     );
//                 //   },
//                 //   child: _buildMenuItem(
//                 //     context: context,
//                 //     icon: Icons.swap_horiz,
//                 //     title: 'Transactions',
//                 //   ),
//                 // ),

//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const WarningInfo()),
//                     );
//                   },
//                   child: _buildMenuItem(
//                     context: context,
//                     icon: Icons.warning_amber_outlined,
//                     title: 'Warnings',
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const BlockedChat()),
//                     );
//                   },
//                   child: _buildMenuItem(
//                     context: context,
//                     icon: Icons.block_outlined,
//                     title: 'Blocked Chats',
//                   ),
//                 ),
//                 // GestureDetector(
//                 //   onTap: () {
//                 //     Navigator.push(
//                 //       context,
//                 //       MaterialPageRoute(
//                 //           builder: (context) => const EarningScreen()),
//                 //     );
//                 //   },
//                 //   child: _buildMenuItem(
//                 //     context: context,
//                 //     icon: Icons.account_balance_wallet_outlined,
//                 //     title: 'My Earnings',
//                 //   ),
//                 // ),
//                                GestureDetector(
//                   onTap: () {
//                         _launchUrl('https://mastivibe.vercel.app/');

//                   },
//                   child: _buildMenuItem(
//                     context: context,
//                     icon: Icons.person,
//                     title: 'About Us',
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     _launchUrl('https://musti-vibes-policies.onrender.com/support');
//                   },
//                   child: _buildMenuItem(
//                     context: context,
//                     icon: Icons.headset_mic_outlined,
//                     title: 'Contact Us',
//                   ),
//                 ),
//                                GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) =>  ReferAndEarnScreen()),
//                     );
//                   },
//                   child: _buildMenuItem(
//                     context: context,
//                     icon: Icons.star_outline,
//                     title: 'Refer App',
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const RateAppScreen()),
//                     );
//                   },
//                   child: _buildMenuItem(
//                     context: context,
//                     icon: Icons.star_outline,
//                     title: 'Rate App',
//                   ),
//                 ),
//                 GestureDetector(
//                                     onTap: () {
//                 _launchUrl('https://musti-vibes-policies.onrender.com/privacy-and-policy');

//                   },
//                   child: _buildMenuItem(
//                     context: context,
//                     icon: Icons.privacy_tip_outlined,
//                     title: 'Privacy Policy',
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                         _launchUrl('https://musti-vibes-policies.onrender.com/terms-and-conditions');

//                   },
//                   child: _buildMenuItem(
//                     context: context,
//                     icon: Icons.description_outlined,
//                     title: 'Terms Of Use',
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const SettingsScreen()),
//                     );
//                   },
//                   child: _buildMenuItem(
//                     context: context,
//                     icon: Icons.settings_outlined,
//                     title: 'Settings',
//                   ),
//                 ),

//                                 GestureDetector(
//                   onTap: () {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const LoginScreen()),
//                     );
//                   },
//                   child: _buildMenuItem(
//                     context: context,
//                     icon: Icons.settings_outlined,
//                     title: 'Logout',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           body: profileProv.isLoading && user == null
//               ? const Center(child: CircularProgressIndicator())
//               : SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       const SizedBox(height: 12),
//                       // _buildCoinsChip(),
//                       const SizedBox(height: 24),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         child: _buildProfileCard(context, user),
//                       ),
//                       const SizedBox(height: 24),
//                     ],
//                   ),
//                 ),
//         );
//       },
//     );
//   }

//   // ---------- OTHER UI PARTS ----------

//   Widget _buildCoinsChip() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(999),
//         border: Border.all(color: Colors.black12, width: 0.8),
//         boxShadow: [
//           BoxShadow(
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//             color: Colors.black.withOpacity(0.03),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const Icon(Icons.monetization_on_outlined, size: 18),
//           const SizedBox(width: 6),
//           const Text(
//             '200',
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(width: 8),
//           Container(
//             height: 22,
//             width: 22,
//             decoration: const BoxDecoration(
//               shape: BoxShape.circle,
//               color: Color(0xFFFF3366),
//             ),
//             child: const Center(
//               child: Icon(
//                 Icons.add,
//                 size: 16,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProfileCard(BuildContext context, AppUser? user) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: Colors.black12, width: 0.6),
//         boxShadow: [
//           BoxShadow(
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//             color: Colors.black.withOpacity(0.04),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Avatar + edit icon
//           SizedBox(
//             height: 80,
//             width: 80,
//             child: Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 Container(
//                   width: 80,
//                   height: 80,
//                   // decoration: BoxDecoration(
//                   //   shape: BoxShape.circle,
//                   //   border:
//                   //       Border.all(color: Colors.grey.shade200, width: 3),
//                   // ),
//                   child: ClipOval(
//                     child: (user != null &&
//                             user.profileImage != null &&
//                             user.profileImage!.isNotEmpty)
//                         ? Image.network(
//                             user.profileImage!,
//                             fit: BoxFit.cover,
//                           )
//                         : Image.asset(
//                             avatarImages[selectedAvatarIndex],
//                             fit: BoxFit.cover,
//                           ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: -2,
//                   right: -2,
//                   child: GestureDetector(
//                     onTap: _showEditDialog,
//                     child: Container(
//                       height: 26,
//                       width: 26,
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Color(0xFFFF3366),
//                       ),
//                       child: const Icon(
//                         Icons.edit,
//                         size: 14,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 14),

//           Text(
//             realNameController.text.isEmpty
//                 ? (user?.name ?? 'Name')
//                 : realNameController.text,
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           // const SizedBox(height: 4),

//           // Row(
//           //   mainAxisAlignment: MainAxisAlignment.center,
//           //   children: const [
//           //     Icon(
//           //       Icons.location_on_outlined,
//           //       size: 16,
//           //       color: Colors.black54,
//           //     ),
//           //     SizedBox(width: 4),
//           //     Text(
//           //       'Kakinada',
//           //       style: TextStyle(
//           //         fontSize: 13,
//           //         color: Colors.black54,
//           //       ),
//           //     ),
//           //   ],
//           // ),

//                    const SizedBox(height: 10),

// Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//     const Icon(
//       Icons.language,
//       size: 16,
//       color: Colors.black54,
//     ),
//     const SizedBox(width: 4),

//     Text(
//       (user?.language ?? 'English'),
//       style: const TextStyle(
//         fontSize: 13,
//         color: Colors.black54,
//       ),
//     ),

//     const SizedBox(width: 6),

//     /// ✏️ Pencil icon
//     GestureDetector(
//       onTap: _showLanguageDialog, // ✅ opens language modal
//       child: const Icon(
//         Icons.edit,
//         size: 14,
//         color: Color(0xFFFE0A62), // same pink as app theme
//       ),
//     ),
//   ],
// ),

//           const SizedBox(height: 18),

//           // Followers / Following box
//           GestureDetector(
// onTap: () async {
//   await Navigator.push(
//     context,
//     MaterialPageRoute(builder: (_) => const FollowScreen()),
//   );

//   // 🔁 refresh profile after coming back
//   if (_userId != null) {
//     context.read<UserProfileProvider>().loadUserProfile(_userId!);
//   }
// },

//             child: Container(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: Colors.black12, width: 0.6),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       children: [
//                         Text(
//                           (user?.followers.length.toString() ?? '0'),
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         const SizedBox(height: 2),
//                         const Text(
//                           'Followers',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.black54,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     height: 32,
//                     width: 1,
//                     color: Colors.grey,
//                   ),
//                   Expanded(
//                     child: Column(
//                       children: [
//                         Text(
//                           (user?.following.length.toString() ?? '0'),
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         const SizedBox(height: 2),
//                         const Text(
//                           'Following',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.black54,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMenuItem({
//     required BuildContext context,
//     required IconData icon,
//     required String title,
//   }) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
//       decoration: BoxDecoration(
//         border: Border(
//           bottom: BorderSide(color: Colors.grey.shade200, width: 1),
//         ),
//       ),
//       child: ListTile(
//         contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
//         leading: Icon(icon, color: Colors.black87, size: 22),
//         title: Text(
//           title,
//           style: const TextStyle(
//             fontSize: 15,
//             color: Colors.black87,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//         trailing: const Icon(
//           Icons.chevron_right,
//           color: Colors.black54,
//           size: 24,
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     realNameController.dispose();
//     nickNameController.dispose();
//     super.dispose();
//   }
// }

import 'dart:convert';
import 'dart:ui';
import 'dart:io'; // ✅ NEW

import 'package:dating_app/views/Earnings/earning_screen.dart';
import 'package:dating_app/views/auth/login_screen.dart';
import 'package:dating_app/views/blocked/blocked_chat.dart';
import 'package:dating_app/views/follow/follow_screen.dart';
import 'package:dating_app/views/profile/edit_profile.dart';
import 'package:dating_app/views/profile/refer_and_earn_screen.dart';
import 'package:dating_app/views/rateapp/rate_app_screen.dart';
import 'package:dating_app/views/settings/settings_screen.dart';
import 'package:dating_app/views/transactions/transaction_history.dart';
import 'package:dating_app/views/warning/warning_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

// 🔹 NEW
import 'package:provider/provider.dart';
import 'package:dating_app/providers/user_profile_provider.dart';
import 'package:intl/intl.dart';
import 'package:dating_app/models/app_user.dart';

// 🔹 NEW – to read asset bytes
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // ------- PROFILE / AVATAR -------
  int selectedAvatarIndex = 0;

  final TextEditingController realNameController = TextEditingController(
    text: '',
  );
  final TextEditingController nickNameController = TextEditingController(
    text: '',
  );

  final List<String> avatarImages = [
    'assets/boyimage2.png',
    'assets/boyimage2.png',
    'assets/boyimage2.png',
    'assets/boyimage2.png',
    'assets/boyimage2.png',
    'assets/boyimage2.png',
    'assets/boyimage2.png',
    'assets/boyimage2.png',
  ];

  // ------- LANGUAGE -------
  String _currentLanguage = 'English'; // will be synced from API

  // replace with your logged-in user id
  String? _userId;
  bool _loadingUserId = true;

  // replace with your stored token if API needs auth
  final String? _token = null; // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9....';

  bool _initializedFromProfile = false;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  // Add this method to your _ProfileScreenState class

  void _showLogoutDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFE0A62).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.logout,
                    color: Color(0xFFFE0A62),
                    size: 32,
                  ),
                ),

                const SizedBox(height: 20),

                // Title
                const Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 12),

                // Message
                const Text(
                  'Are you sure you want to logout?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 24),

                // Buttons
                Row(
                  children: [
                    // Cancel Button
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          side: const BorderSide(
                            color: Color(0xFFFE0A62),
                            width: 1.5,
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Color(0xFFFE0A62),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Logout Button
                    // Expanded(
                    //   child: ElevatedButton(
                    //     onPressed: () async {
                    //       Navigator.pop(dialogContext); // Close dialog

                    //       // Clear user data from SharedPreferences
                    //       final prefs = await SharedPreferences.getInstance();
                    //       await prefs.clear();

                    //       // Navigate to LoginScreen
                    //       if (mounted) {
                    //         Navigator.pushAndRemoveUntil(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => const LoginScreen(),
                    //           ),
                    //           (route) => false,
                    //         );
                    //       }
                    //     },
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: const Color(0xFFFE0A62),
                    //       padding: const EdgeInsets.symmetric(vertical: 12),
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(30),
                    //       ),
                    //       elevation: 0,
                    //     ),
                    //     child: const Text(
                    //       'Logout',
                    //       style: TextStyle(
                    //         color: Colors.white,
                    //         fontSize: 15,
                    //         fontWeight: FontWeight.w600,
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    // Logout Button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(dialogContext); // Close dialog

                          // Clear user data from SharedPreferences
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.clear();

                          // Show success message
                          Fluttertoast.showToast(
                            msg: 'Logged out successfully',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 14.0,
                          );

                          // Navigate to LoginScreen
                          if (mounted) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                              (route) => false,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFE0A62),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('userId');

    if (!mounted) return;

    setState(() {
      _userId = id;
      _loadingUserId = false;
    });

    if (_userId != null && _userId!.isNotEmpty) {
      context.read<UserProfileProvider>().loadUserProfile(_userId!);
    }
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Fluttertoast.showToast(msg: 'Could not open link');
    }
  }

  // 🔹 NEW: Convert selected asset avatar to a real File (for upload)
  Future<File?> _getSelectedAvatarFile() async {
    try {
      final String assetPath = avatarImages[selectedAvatarIndex];

      // Load bytes from asset
      final byteData = await rootBundle.load(assetPath);
      final bytes = byteData.buffer.asUint8List();

      // Write to temporary file
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/avatar_$selectedAvatarIndex.png');

      await file.writeAsBytes(bytes, flush: true);
      return file;
    } catch (e) {
      debugPrint('Error creating file from asset: $e');
      return null;
    }
  }

  // ---------- EDIT PROFILE MODAL ----------
  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        final screenHeight = MediaQuery.of(dialogContext).size.height;

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Dialog(
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 24,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: screenHeight * 0.70,
                  minWidth: double.infinity,
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          children: [
                            const Spacer(),
                            const Text(
                              'Edit your profile',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => Navigator.pop(dialogContext),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        const Text(
                          'Select Avatar',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // HORIZONTAL AVATAR LIST
                        SizedBox(
                          height: 70,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: avatarImages.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 10),
                            itemBuilder: (context, index) {
                              final isSelected = selectedAvatarIndex == index;
                              return GestureDetector(
                                onTap: () {
                                  setModalState(() {
                                    selectedAvatarIndex = index;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected
                                          ? Colors.pink
                                          : Colors.transparent,
                                      width: 3,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 26,
                                    backgroundColor: _getAvatarColor(index),
                                    child: ClipOval(
                                      child: Image.asset(
                                        avatarImages[index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 18),

                        const Text(
                          'Edit Details',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),

                        const Text(
                          'Real Name',
                          style: TextStyle(fontSize: 13, color: Colors.black87),
                        ),
                        const SizedBox(height: 6),

                        SizedBox(
                          height: 44,
                          child: TextField(
                            controller: realNameController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              prefixIcon: const Icon(
                                Icons.person_outline,
                                color: Colors.grey,
                              ),
                              suffixIcon: const Icon(
                                Icons.lock_outline,
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(color: Colors.pink),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        const Text(
                          'Nick Name',
                          style: TextStyle(fontSize: 13, color: Colors.black87),
                        ),
                        const SizedBox(height: 6),

                        SizedBox(
                          height: 44,
                          child: TextField(
                            controller: nickNameController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              prefixIcon: const Icon(
                                Icons.person_outline,
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(color: Colors.pink),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        SizedBox(
                          width: double.infinity,
                          height: 44,
                          child: ElevatedButton(
                            onPressed: () async {
                              final profileProv = context
                                  .read<UserProfileProvider>();
                              final user = profileProv.user;

                              if (user == null) {
                                Fluttertoast.showToast(
                                  msg: 'Profile not loaded yet',
                                );
                                return;
                              }

                              // 🔹 Build DOB string (fallback if null)
                              final dobString = user.dob != null
                                  ? DateFormat('yyyy-MM-dd').format(user.dob!)
                                  : '2002-10-27';

                              // 🔹 Convert selected avatar asset into a File
                              final avatarFile = await _getSelectedAvatarFile();

                              final success = await profileProv.saveUserProfile(
                                userId: user.id,
                                name: realNameController.text.trim(),
                                nickname: nickNameController.text.trim(),
                                gender: user.gender ?? 'male',
                                dobString: dobString,
                                language: _currentLanguage,
                                userType: user.userType ?? 'normal',
                                imageFile:
                                    avatarFile, // ✅ now sending a real file
                              );

                              if (success) {
                                Fluttertoast.showToast(
                                  msg: 'Profile updated successfully',
                                );
                                if (mounted) {
                                  Navigator.pop(dialogContext);
                                }
                              } else {
                                Fluttertoast.showToast(
                                  msg: profileProv.error ?? 'Update failed',
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFE0A62),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        // Add bottom padding to ensure content is visible above keyboard
                        SizedBox(
                          height: MediaQuery.of(
                            dialogContext,
                          ).viewInsets.bottom,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Color _getAvatarColor(int index) {
    final colors = [
      Colors.orange,
      Colors.red,
      Colors.purple,
      Colors.blue,
      Colors.amber,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
    ];
    return colors[index % colors.length];
  }

  // ---------- LANGUAGE MODAL WITH BLUR ----------
  void _showLanguageDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Language',
      barrierColor: Colors.black.withOpacity(0.2),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (ctx, anim1, anim2) {
        String selected = _currentLanguage;
        bool isSaving = false;

        Future<void> save() async {
          if (isSaving) return;
          isSaving = true;

          (ctx as Element).markNeedsBuild();

          await _updateLanguageOnServer(selected);

          if (mounted) {
            setState(() {
              _currentLanguage = selected;
            });
          }
          if (Navigator.of(ctx).canPop()) {
            Navigator.of(ctx).pop();
          }
        }

        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Center(
            child: StatefulBuilder(
              builder: (context, setModalState) {
                void selectLang(String lang) {
                  setModalState(() {
                    selected = lang;
                  });
                }

                Widget buildOption({
                  required String label,
                  required String code,
                  required String langValue,
                }) {
                  final bool isSelected = selected == langValue;

                  return GestureDetector(
                    onTap: () => selectLang(langValue),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFFFE0A62)
                              : Colors.grey.shade300,
                          width: 1.4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFFFE0A62)
                                    : Colors.grey.shade300,
                              ),
                            ),
                            child: Text(
                              code,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? const Color(0xFFFE0A62)
                                    : Colors.black87,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            label,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                          if (isSelected) ...[
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.check_circle,
                              size: 16,
                              color: Color(0xFFFE0A62),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }

                return Material(
                  color: Colors.transparent,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // header
                        Row(
                          children: [
                            const Spacer(),
                            const Text(
                              'Select Language',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () => Navigator.of(ctx).pop(),
                              child: const Icon(Icons.close, size: 20),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        const SizedBox(height: 6),

                        const Text(
                          'Note: This is not the app language. It is only for your identity.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),

                        // options
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: buildOption(
                                label: 'English',
                                code: 'En',
                                langValue: 'English',
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: buildOption(
                                label: 'Hindi',
                                code: 'अ',
                                langValue: 'Hindi',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: buildOption(
                            label: 'Telugu',
                            code: 'తెలు',
                            langValue: 'Telugu',
                          ),
                        ),

                        const SizedBox(height: 18),

                        SizedBox(
                          width: double.infinity,
                          height: 44,
                          child: ElevatedButton(
                            onPressed: isSaving
                                ? null
                                : () async {
                                    await save();
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFE0A62),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0,
                            ),
                            child: isSaving
                                ? const SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    'Save',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _updateLanguageOnServer(String lang) async {
    final uri = Uri.parse(
      'http://31.97.206.144:4055/api/users/update-language/$_userId',
    );

    final headers = <String, String>{'Content-Type': 'application/json'};

    // if (_token != null) {
    //   headers['Authorization'] = 'Bearer $_token';
    // }

    try {
      final response = await http.put(
        uri,
        headers: headers,
        body: jsonEncode({'language': lang}),
      );

      print('Response status code for update languages ${response.statusCode}');
            print('Response bodyyyyyyy for update languages ${response.body}');


      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          Fluttertoast.showToast(
            msg: data['message'] ?? "Language updated successfully",
          );

          // 🔹 Refresh profile from server so Consumer rebuilds
          await context.read<UserProfileProvider>().loadUserProfile(
            _userId.toString(),
          );
        } else {
          Fluttertoast.showToast(
            msg: data['message'] ?? "Something went wrong",
          );
        }
      } else {
        Fluttertoast.showToast(msg: "Server error: ${response.statusCode}");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went wrong: $e");
    }
  }

  // ---------- BUILD ----------
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileProvider>(
      builder: (context, profileProv, _) {
        final user = profileProv.user;

        // Initialize controllers once from user
        if (user != null && !_initializedFromProfile) {
          realNameController.text = user.name ?? '';
          nickNameController.text = user.nickname ?? '';
          _currentLanguage = user.language ?? _currentLanguage;
          _initializedFromProfile = true;
        }

        return Scaffold(
          backgroundColor: const Color(0xFFFFF5F5),
          appBar: AppBar(
            backgroundColor: const Color(0xFFFFF5F5),
            elevation: 0,
            leading: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
            actions: [
              // IconButton(
              //   icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              // ),
            ],
          ),
          drawer: Drawer(
            backgroundColor: Colors.white,
            width: MediaQuery.of(context).size.width * 0.65,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 50),

                // GestureDetector(
                //   onTap: () {
                //     // Navigator.push(
                //     //   context,
                //     //   MaterialPageRoute(builder: (context) => const EditProfile()),
                //     // );
                //   },
                //   child: _buildMenuItem(
                //     context: context,
                //     icon: Icons.person_outline,
                //     title: 'Edit Profile',
                //   ),
                // ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => const TransactionHistory()),
                //     );
                //   },
                //   child: _buildMenuItem(
                //     context: context,
                //     icon: Icons.swap_horiz,
                //     title: 'Transactions',
                //   ),
                // ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WarningInfo(),
                      ),
                    );
                  },
                  child: _buildMenuItem(
                    context: context,
                    icon: Icons.warning_amber_outlined,
                    title: 'Warnings',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BlockedChat(),
                      ),
                    );
                  },
                  child: _buildMenuItem(
                    context: context,
                    icon: Icons.block_outlined,
                    title: 'Blocked Chats',
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => const EarningScreen()),
                //     );
                //   },
                //   child: _buildMenuItem(
                //     context: context,
                //     icon: Icons.account_balance_wallet_outlined,
                //     title: 'My Earnings',
                //   ),
                // ),
                GestureDetector(
                  onTap: () {
                    _launchUrl('https://mastivibe.vercel.app/');
                  },
                  child: _buildMenuItem(
                    context: context,
                    icon: Icons.person,
                    title: 'About Us',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _launchUrl(
                      'https://musti-vibes-policies.onrender.com/support',
                    );
                  },
                  child: _buildMenuItem(
                    context: context,
                    icon: Icons.headset_mic_outlined,
                    title: 'Contact Us',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReferAndEarnScreen(),
                      ),
                    );
                  },
                  child: _buildMenuItem(
                    context: context,
                    icon: Icons.star_outline,
                    title: 'Refer App',
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => const RateAppScreen(),
                //       ),
                //     );
                //   },
                //   child: _buildMenuItem(
                //     context: context,
                //     icon: Icons.star_outline,
                //     title: 'Rate App',
                //   ),
                // ),
                GestureDetector(
                  onTap: () {
                    _launchUrl(
                      'https://musti-vibes-policies.onrender.com/privacy-and-policy',
                    );
                  },
                  child: _buildMenuItem(
                    context: context,
                    icon: Icons.privacy_tip_outlined,
                    title: 'Privacy Policy',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _launchUrl(
                      'https://musti-vibes-policies.onrender.com/terms-and-conditions',
                    );
                  },
                  child: _buildMenuItem(
                    context: context,
                    icon: Icons.description_outlined,
                    title: 'Terms Of Use',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ),
                    );
                  },
                  child: _buildMenuItem(
                    context: context,
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                  ),
                ),

                // GestureDetector(
                //   onTap: () {
                //     Navigator.pushReplacement(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => const LoginScreen(),
                //       ),
                //     );
                //   },
                //   child: _buildMenuItem(
                //     context: context,
                //     icon: Icons.settings_outlined,
                //     title: 'Logout',
                //   ),
                // ),
                GestureDetector(
                  onTap:
                      _showLogoutDialog, // Changed from Navigator.pushReplacement
                  child: _buildMenuItem(
                    context: context,
                    icon: Icons.logout, // Changed icon to logout
                    title: 'Logout',
                  ),
                ),
              ],
            ),
          ),
          body: profileProv.isLoading && user == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      // _buildCoinsChip(),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: _buildProfileCard(context, user),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
        );
      },
    );
  }

  // ---------- OTHER UI PARTS ----------

  Widget _buildCoinsChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.black12, width: 0.8),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            offset: const Offset(0, 2),
            color: Colors.black.withOpacity(0.03),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.monetization_on_outlined, size: 18),
          const SizedBox(width: 6),
          const Text(
            '200',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 8),
          Container(
            height: 22,
            width: 22,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFFF3366),
            ),
            child: const Center(
              child: Icon(Icons.add, size: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, AppUser? user) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black12, width: 0.6),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            offset: const Offset(0, 4),
            color: Colors.black.withOpacity(0.04),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Avatar + edit icon
          SizedBox(
            height: 80,
            width: 80,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  // decoration: BoxDecoration(
                  //   shape: BoxShape.circle,
                  //   border:
                  //       Border.all(color: Colors.grey.shade200, width: 3),
                  // ),
                  child: ClipOval(
                    child:
                        (user != null &&
                            user.profileImage != null &&
                            user.profileImage!.isNotEmpty)
                        ? Image.network(user.profileImage!, fit: BoxFit.cover)
                        : Image.asset(
                            avatarImages[selectedAvatarIndex],
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Positioned(
                  bottom: -2,
                  right: -2,
                  child: GestureDetector(
                    onTap: _showEditDialog,
                    child: Container(
                      height: 26,
                      width: 26,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFF3366),
                      ),
                      child: const Icon(
                        Icons.edit,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          Text(
            realNameController.text.isEmpty
                ? (user?.name ?? 'Name')
                : realNameController.text,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),

          // const SizedBox(height: 4),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: const [
          //     Icon(
          //       Icons.location_on_outlined,
          //       size: 16,
          //       color: Colors.black54,
          //     ),
          //     SizedBox(width: 4),
          //     Text(
          //       'Kakinada',
          //       style: TextStyle(
          //         fontSize: 13,
          //         color: Colors.black54,
          //       ),
          //     ),
          //   ],
          // ),
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.language, size: 16, color: Colors.black54),
              const SizedBox(width: 4),

              Text(
                (user?.language ?? 'English'),
                style: const TextStyle(fontSize: 13, color: Colors.black54),
              ),

              const SizedBox(width: 6),

              /// ✏️ Pencil icon
              GestureDetector(
                onTap: _showLanguageDialog, // ✅ opens language modal
                child: const Icon(
                  Icons.edit,
                  size: 16,
                  color: Color(0xFFFE0A62), // same pink as app theme
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Followers / Following box
          GestureDetector(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FollowScreen()),
              );

              // 🔁 refresh profile after coming back
              if (_userId != null) {
                context.read<UserProfileProvider>().loadUserProfile(_userId!);
              }
            },

            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 10.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black12, width: 0.6),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          (user?.followers.length.toString() ?? '0'),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Followers',
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  Container(height: 32, width: 1, color: Colors.grey),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          (user?.following.length.toString() ?? '0'),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Following',
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
        leading: Icon(icon, color: Colors.black87, size: 22),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: Colors.black54,
          size: 24,
        ),
      ),
    );
  }

  @override
  void dispose() {
    realNameController.dispose();
    nickNameController.dispose();
    super.dispose();
  }
}
