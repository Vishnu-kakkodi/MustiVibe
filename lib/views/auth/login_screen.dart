// // import 'package:dating_app/views/auth/otp_screen.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:dating_app/providers/auth_provider.dart';

// // class LoginScreen extends StatefulWidget {
// //   const LoginScreen({super.key});

// //   @override
// //   State<LoginScreen> createState() => _LoginScreenState();
// // }

// // class _LoginScreenState extends State<LoginScreen> {
// //   final TextEditingController _phoneController = TextEditingController();

// //   @override
// //   void dispose() {
// //     _phoneController.dispose();
// //     super.dispose();
// //   }

// //   Future<void> _getOtp() async {
// //     final mobile = _phoneController.text.trim();

// //     if (mobile.length != 10) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Enter valid 10-digit mobile number')),
// //       );
// //       return;
// //     }

// //     final authProvider = context.read<AuthProvider>();
// //     final ok = await authProvider.sendOtp(context, mobile);

// //     if (!mounted) return;

// //     if (ok) {
// //       Navigator.push(
// //         context,
// //         MaterialPageRoute(
// //           builder: (_) => OtpScreen(mobile: mobile),
// //         ),
// //       );
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final isLoading = context.watch<AuthProvider>().isLoading;

// //     return WillPopScope(
// //       onWillPop: () async => false,
// //       child: Scaffold(
// //         resizeToAvoidBottomInset: true,
// //         body: SafeArea(
// //           top: false,
// //           bottom: true,
// //           child: SingleChildScrollView(
// //             physics: const BouncingScrollPhysics(),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 // -----------------------------------------------------
// //                 // 🔥 YOUR ORIGINAL TOP STACK WITH IMAGES (kept same)
// //                 // -----------------------------------------------------
// //                 Stack(
// //                   children: [
// //                     Image.asset(
// //                       'assets/splashrectangle.png',
// //                       width: double.infinity,
// //                       fit: BoxFit.cover,
// //                     ),

// //                     Positioned(
// //                       bottom: 0,
// //                       left: 0,
// //                       right: 0,
// //                       child: Center(
// //                         child: Image.asset(
// //                           'assets/loginimage.png',
// //                           height: 250,
// //                           fit: BoxFit.contain,
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),

// //                 // -----------------------------------------------------
// //                 // Bottom Container
// //                 // -----------------------------------------------------
// //                 Container(
// //                   width: double.infinity,
// //                   decoration: BoxDecoration(
// //                     color: Colors.white,
// //                     borderRadius: const BorderRadius.only(
// //                       topLeft: Radius.circular(32),
// //                       topRight: Radius.circular(32),
// //                     ),
// //                     boxShadow: [
// //                       BoxShadow(
// //                         color: Colors.black12,
// //                         blurRadius: 10,
// //                         offset: const Offset(0, -2),
// //                       ),
// //                     ],
// //                   ),
// //                   child: Padding(
// //                     padding: const EdgeInsets.symmetric(
// //                       horizontal: 24,
// //                       vertical: 32,
// //                     ),
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         const Text(
// //                           'Connect. Chat. Feel the\nVibe.',
// //                           style: TextStyle(
// //                             fontSize: 28,
// //                             fontWeight: FontWeight.bold,
// //                             color: Colors.black87,
// //                             height: 1.2,
// //                           ),
// //                         ),
// //                         const SizedBox(height: 32),

// //                         const Text(
// //                           'Mobile Number',
// //                           style: TextStyle(
// //                             fontSize: 14,
// //                             color: Colors.black87,
// //                             fontWeight: FontWeight.w500,
// //                           ),
// //                         ),
// //                         const SizedBox(height: 8),

// //                         // Phone Field
// //                         Container(
// //                           decoration: BoxDecoration(
// //                             color: Colors.white,
// //                             borderRadius: BorderRadius.circular(12),
// //                             border: Border.all(color: Colors.grey.shade300),
// //                           ),
// //                           child: TextField(
// //                             controller: _phoneController,
// //                             keyboardType: TextInputType.phone,
// //                             decoration: InputDecoration(
// //                               hintText: 'Enter your Mobile Number',
// //                               hintStyle: TextStyle(
// //                                 color: Colors.grey.shade400,
// //                                 fontSize: 14,
// //                               ),
// //                               prefixIcon: Icon(
// //                                 Icons.phone_outlined,
// //                                 color: Colors.grey.shade600,
// //                               ),
// //                               border: InputBorder.none,
// //                               contentPadding: const EdgeInsets.symmetric(
// //                                 horizontal: 16,
// //                                 vertical: 14,
// //                               ),
// //                             ),
// //                           ),
// //                         ),

// //                         const SizedBox(height: 32),

// //                         SizedBox(
// //                           width: double.infinity,
// //                           child: ElevatedButton(
// //                             onPressed: isLoading ? null : _getOtp,
// //                             style: ElevatedButton.styleFrom(
// //                               backgroundColor:
// //                                   Theme.of(context).colorScheme.primary,
// //                               foregroundColor: Colors.white,
// //                               padding:
// //                                   const EdgeInsets.symmetric(vertical: 16),
// //                               shape: RoundedRectangleBorder(
// //                                 borderRadius: BorderRadius.circular(32),
// //                               ),
// //                               elevation: 0,
// //                             ),
// //                             child: isLoading
// //                                 ? const SizedBox(
// //                                     width: 20,
// //                                     height: 20,
// //                                     child: CircularProgressIndicator(
// //                                       strokeWidth: 2,
// //                                       color: Colors.white,
// //                                     ),
// //                                   )
// //                                 : const Text(
// //                                     'Get OTP',
// //                                     style: TextStyle(
// //                                       fontSize: 16,
// //                                       fontWeight: FontWeight.w600,
// //                                     ),
// //                                   ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:dating_app/utils/toast_message.dart';
// import 'package:dating_app/utils/validator.dart';
// import 'package:dating_app/views/auth/otp_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:dating_app/providers/auth_provider.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _phoneController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _autoValidate = false;

//   @override
//   void dispose() {
//     _phoneController.dispose();
//     super.dispose();
//   }

//   Future<void> _getOtp() async {
//     // Enable auto-validation after first submit attempt
//     setState(() {
//       _autoValidate = true;
//     });

//     // Validate form
//     if (!_formKey.currentState!.validate()) {
//       // Get the error message from validator
//       final errorMessage = Validators.validatePhoneNumber(_phoneController.text);
//       if (errorMessage != null) {
//         ToastUtils.showError(errorMessage);
//       }
//       return;
//     }

//     final mobile = _phoneController.text.trim();

//     try {
//       final authProvider = context.read<AuthProvider>();
//       final ok = await authProvider.sendOtp(context, mobile);

//       if (!mounted) return;

//       if (ok) {
//         ToastUtils.showSuccess('OTP sent successfully!');
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => OtpScreen(mobile: mobile),
//           ),
//         );
//       } else {
//         ToastUtils.showError('Failed to send OTP. Please try again.');
//       }
//     } catch (e) {
//       if (!mounted) return;
//       ToastUtils.showError('An error occurred. Please try again.');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isLoading = context.watch<AuthProvider>().isLoading;

//     return WillPopScope(
//       onWillPop: () async => false,
//       child: Scaffold(
//         resizeToAvoidBottomInset: true,
//         body: SafeArea(
//           top: false,
//           bottom: true,
//           child: SingleChildScrollView(
//             physics: const BouncingScrollPhysics(),
//             child: Form(
//               key: _formKey,
//               autovalidateMode: _autoValidate
//                   ? AutovalidateMode.onUserInteraction
//                   : AutovalidateMode.disabled,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // -----------------------------------------------------
//                   // 🔥 YOUR ORIGINAL TOP STACK WITH IMAGES (kept same)
//                   // -----------------------------------------------------
//                   Stack(
//                     children: [
//                       Image.asset(
//                         'assets/splashrectangle.png',
//                         width: double.infinity,
//                         fit: BoxFit.cover,
//                       ),
//                       Positioned(
//                         bottom: 0,
//                         left: 0,
//                         right: 0,
//                         child: Center(
//                           child: Image.asset(
//                             'assets/loginimage.png',
//                             height: 250,
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   // -----------------------------------------------------
//                   // Bottom Container
//                   // -----------------------------------------------------
//                   Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(32),
//                         topRight: Radius.circular(32),
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black12,
//                           blurRadius: 10,
//                           offset: const Offset(0, -2),
//                         ),
//                       ],
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 24,
//                         vertical: 32,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Connect. Chat. Feel the\nVibe.',
//                             style: TextStyle(
//                               fontSize: 28,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black87,
//                               height: 1.2,
//                             ),
//                           ),
//                           const SizedBox(height: 32),

//                           const Text(
//                             'Mobile Number',
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.black87,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           const SizedBox(height: 8),

//                           // Phone Field with Validation
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(12),
//                               border: Border.all(color: Colors.grey.shade300),
//                             ),
//                             child: TextFormField(
//                               controller: _phoneController,
//                               keyboardType: TextInputType.phone,
//                               maxLength: 10,
//                               inputFormatters: [
//                                 FilteringTextInputFormatter.digitsOnly,
//                                 LengthLimitingTextInputFormatter(10),
//                               ],
//                               validator: Validators.validatePhoneNumber,
//                               decoration: InputDecoration(
//                                 hintText: 'Enter your Mobile Number',
//                                 hintStyle: TextStyle(
//                                   color: Colors.grey.shade400,
//                                   fontSize: 14,
//                                 ),
//                                 prefixIcon: Icon(
//                                   Icons.phone_outlined,
//                                   color: Colors.grey.shade600,
//                                 ),
//                                 counterText: '', // Hide character counter
//                                 errorStyle: const TextStyle(
//                                   fontSize: 12,
//                                   height: 0.8,
//                                 ),
//                                 border: InputBorder.none,
//                                 contentPadding: const EdgeInsets.symmetric(
//                                   horizontal: 16,
//                                   vertical: 14,
//                                 ),
//                               ),
//                             ),
//                           ),

//                           const SizedBox(height: 32),

//                           SizedBox(
//                             width: double.infinity,
//                             child: ElevatedButton(
//                               onPressed: isLoading ? null : _getOtp,
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor:
//                                     Theme.of(context).colorScheme.primary,
//                                 foregroundColor: Colors.white,
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 16),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(32),
//                                 ),
//                                 elevation: 0,
//                                 disabledBackgroundColor:
//                                     Theme.of(context).colorScheme.primary.withOpacity(0.6),
//                               ),
//                               child: isLoading
//                                   ? const SizedBox(
//                                       width: 20,
//                                       height: 20,
//                                       child: CircularProgressIndicator(
//                                         strokeWidth: 2,
//                                         color: Colors.white,
//                                       ),
//                                     )
//                                   : const Text(
//                                       'Get OTP',
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }










import 'package:dating_app/utils/toast_message.dart';
import 'package:dating_app/utils/validator.dart';
import 'package:dating_app/views/auth/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:dating_app/providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  String? phoneError;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  // -----------------------------
  // VALIDATION + OTP
  // -----------------------------
  Future<void> _getOtp() async {
    FocusScope.of(context).unfocus();

    setState(() {
      phoneError = null;
    });

    final phone = _phoneController.text.trim();

    final error = Validators.validatePhoneNumber(phone);

    if (error != null) {
      setState(() {
        phoneError = error;
      });
      return;
    }

    try {
      final authProvider = context.read<AuthProvider>();

      final ok = await authProvider.sendOtp(context, phone);

      if (!mounted) return;

      if (ok) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => OtpScreen(mobile: phone)),
        );
      } else {
        ToastUtils.showError('We couldn’t send the OTP. Please try again.');
      }
    } catch (e) {
      if (!mounted) return;

      ToastUtils.showError('Something went wrong. Try again.');
      debugPrint('Login Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthProvider>().isLoading;
    final hasError = phoneError != null;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          top: false,
          bottom: true,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // -----------------------------
                // TOP IMAGES
                // -----------------------------
                Stack(
                  children: [
                    Image.asset(
                      'assets/splashrectangle.png',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Image.asset(
                          'assets/loginimage.png',
                          height: 250,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),

                // -----------------------------
                // BOTTOM CONTAINER
                // -----------------------------
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 32,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Connect. Chat. Feel the\nVibe.',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 32),

                        const Text(
                          'Mobile Number',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // -----------------------------
                        // PHONE FIELD (SET PROFILE STYLE)
                        // -----------------------------
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: hasError
                                  ? Colors.red
                                  : Colors.grey.shade300,
                              width: hasError ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  maxLength: 10,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  onChanged: (value) {
                                    if (phoneError != null) {
                                      setState(() {
                                        phoneError = null;
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Enter your Mobile Number',
                                    hintStyle: TextStyle(
                                      color: Colors.grey.shade400,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.phone_outlined,
                                      color: hasError
                                          ? Colors.red
                                          : Colors.grey.shade600,
                                    ),
                                    counterText: '',
                                    border: InputBorder.none,
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 16,
                                    ),
                                  ),
                                ),
                              ),
                              if (hasError)
                                const Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                ),
                            ],
                          ),
                        ),

                        // -----------------------------
                        // ERROR BOX (same as SetProfile)
                        // -----------------------------
                        if (hasError) ...[
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.red,
                                width: 1.5,
                              ),
                            ),
                            child: Text(
                              phoneError!,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],

                        const SizedBox(height: 32),

                        // -----------------------------
                        // GET OTP BUTTON
                        // -----------------------------
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : _getOtp,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    'Get OTP',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
