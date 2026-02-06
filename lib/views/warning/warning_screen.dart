// import 'package:dating_app/views/navbar/navbar_screen.dart';
// import 'package:flutter/material.dart';

// class WarningScreen extends StatefulWidget {
//   const WarningScreen({super.key});

//   @override
//   State<WarningScreen> createState() => _WarningScreenState();
// }

// class _WarningScreenState extends State<WarningScreen> {
//   bool isChecked = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Column(
//             children: [
//               const SizedBox(height: 40),
//               // Warning text
//               const Text(
//                 'Warning',
//                 style: TextStyle(
//                   color: Color(0xFFFFA500),
//                   fontSize: 24,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 30),
//               Image.asset('assets/warningimage.png'),
//               const Spacer(),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     width: 20,
//                     height: 20,
//                     child: Checkbox(
//                       value: isChecked,
//                       onChanged: (value) {
//                         setState(() {
//                           isChecked = value ?? false;
//                         });
//                       },
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                       side: const BorderSide(
//                         color: Colors.grey,
//                         width: 1.5,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   const Expanded(
//                     child: Text(
//                       'If I misbehave with any user, I can be permanently blocked from this app.',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.black87,
//                         height: 1.4,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),
//               // Submit button
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=>MainNavigationScreen()));
//                     // Handle submit
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFFFE0A62),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     elevation: 0,
//                   ),
//                   child: const Text(
//                     'Submit',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 32),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }








import 'package:dating_app/views/navbar/navbar_screen.dart';
import 'package:flutter/material.dart';

class WarningScreen extends StatefulWidget {
  const WarningScreen({super.key});

  @override
  State<WarningScreen> createState() => _WarningScreenState();
}

class _WarningScreenState extends State<WarningScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                'Warning',
                style: TextStyle(
                  color: Color(0xFFFFA500),
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 30),
              Image.asset('assets/warningimage.png'),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      side: const BorderSide(
                        color: Colors.grey,
                        width: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'If I misbehave with any user, I can be permanently blocked from this app.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isChecked
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainNavigationScreen(),
                            ),
                          );
                        }
                      : () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please accept the warning before continuing.',
                              ),
                            ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isChecked ? const Color(0xFFFE0A62) : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
