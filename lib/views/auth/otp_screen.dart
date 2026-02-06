

// // lib/views/auth/otp_screen.dart
// import 'package:dating_app/providers/auth_provider.dart';
// import 'package:dating_app/views/auth/set_profile.dart';
// import 'package:dating_app/views/navbar/navbar_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class OtpScreen extends StatefulWidget {
//   final String mobile;

//   const OtpScreen({super.key, required this.mobile});

//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }

// class _OtpScreenState extends State<OtpScreen> {
//   final List<TextEditingController> _controllers =
//       List.generate(4, (index) => TextEditingController());
//   final List<FocusNode> _focusNodes =
//       List.generate(4, (index) => FocusNode());

//   String get _otp => _controllers.map((c) => c.text).join();

//   @override
//   void dispose() {
//     for (var c in _controllers) {
//       c.dispose();
//     }
//     for (var f in _focusNodes) {
//       f.dispose();
//     }
//     super.dispose();
//   }

//   Future<void> _submitOtp() async {
//     if (_otp.length < 4) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter the 4-digit code')),
//       );
//       return;
//     }

//     final provider = context.read<AuthProvider>();
//     final result = await provider.verifyOtp(context, _otp);

//     if (!mounted || result == null) return;

//     if (result == VerifyResult.newUser) {
//       // go to set profile
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const SetProfile()),
//       );
//     } else if (result == VerifyResult.existingUser) {
//       // user already has profile -> go home
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (_) => MainNavigationScreen()),
//         (route) => false,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final primary = theme.colorScheme.primary;
//     final bg = theme.scaffoldBackgroundColor;
//     final textColor = theme.colorScheme.onBackground;
//     final isLoading = context.watch<AuthProvider>().isLoading;

//     return Scaffold(
//       backgroundColor: bg,
//       appBar: AppBar(
//         backgroundColor: bg,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Verify your\nnumber',
//                 style: theme.textTheme.headlineMedium?.copyWith(
//                   fontWeight: FontWeight.bold,
//                   color: textColor,
//                   height: 1.2,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 'Enter the code we sent to the number',
//                 style: theme.textTheme.bodyMedium?.copyWith(
//                   fontSize: 14,
//                   color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 widget.mobile,
//                 style: theme.textTheme.bodyMedium?.copyWith(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                   color: textColor,
//                 ),
//               ),
//               const SizedBox(height: 32),
//               // ... OTP boxes same as your original ...
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: List.generate(
//                   4,
//                   (index) => SizedBox(
//                     width: 70,
//                     height: 70,
//                     child: TextField(
//                       controller: _controllers[index],
//                       focusNode: _focusNodes[index],
//                       textAlign: TextAlign.center,
//                       keyboardType: TextInputType.number,
//                       maxLength: 1,
//                       style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       decoration: const InputDecoration(
//                         counterText: '',
//                         filled: true,
//                       ),
//                       onChanged: (value) {
//                         if (value.isNotEmpty) {
//                           if (index < 3) {
//                             _focusNodes[index + 1].requestFocus();
//                           } else {
//                             _focusNodes[index].unfocus();
//                           }
//                         } else if (value.isEmpty && index > 0) {
//                           _focusNodes[index - 1].requestFocus();
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               // resend row (same)
//               const Spacer(),
//               SizedBox(
//                 width: double.infinity,
//                 height: 56,
//                 child: ElevatedButton(
//                   onPressed: isLoading ? null : _submitOtp,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: primary,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(28),
//                     ),
//                     elevation: 0,
//                   ),
//                   child: isLoading
//                       ? const SizedBox(
//                           width: 20,
//                           height: 20,
//                           child: CircularProgressIndicator(strokeWidth: 2),
//                         )
//                       : const Text(
//                           'Submit',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }














// lib/views/auth/otp_screen.dart
import 'package:dating_app/providers/auth_provider.dart';
import 'package:dating_app/views/auth/set_profile.dart';
import 'package:dating_app/views/navbar/navbar_screen.dart';
import 'package:dating_app/zego/zego_call_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zego_uikit/zego_uikit.dart';

class OtpScreen extends StatefulWidget {
  final String mobile;

  const OtpScreen({super.key, required this.mobile});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes =
      List.generate(4, (_) => FocusNode());

  String get _otp => _controllers.map((c) => c.text).join();

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  Future<void> _submitOtp() async {
    if (_otp.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the 4-digit code')),
      );
      return;
    }

    final auth = context.read<AuthProvider>();
    final result = await auth.verifyOtp(context, _otp);

    if (!mounted || result == null) return;

    // 🔥 WE HAVE USER NOW
    final userId = auth.userId;
    final userName = auth.userName;

    if (userId == null || userName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed. Try again.')),
      );
      return;
    }

    // 🔥 INIT ZEGO CALL SYSTEM (ONCE)
    // ZegoCallManager.init(
    //   userId: userId,
    //   userName: userName,
    // );

    // // 🔥 LOGIN ZEGO USER
    // ZegoUIKit().login(userId, userName);

    if (result == VerifyResult.newUser) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SetProfile()),
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => MainNavigationScreen()),
        (_) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLoading = context.watch<AuthProvider>().isLoading;

    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verify your\nnumber',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                4,
                (index) => SizedBox(
                  width: 60,
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    decoration: const InputDecoration(counterText: ''),
                    onChanged: (v) {
                      if (v.isNotEmpty && index < 3) {
                        _focusNodes[index + 1].requestFocus();
                      }
                    },
                  ),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: isLoading ? null : _submitOtp,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
