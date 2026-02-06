// import 'package:dating_app/views/follow/follow_screen.dart';
// import 'package:flutter/material.dart';

// class EditProfile extends StatefulWidget {
//   const EditProfile({super.key});

//   @override
//   State<EditProfile> createState() => _EditProfileState();
// }

// class _EditProfileState extends State<EditProfile> {
//   int selectedAvatarIndex = 0;
//   final TextEditingController realNameController =
//       TextEditingController(text: 'Name');
//   final TextEditingController nickNameController =
//       TextEditingController(text: 'Nick name');

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

//   void _showEditDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return Dialog(
//               insetPadding: const EdgeInsets.symmetric(horizontal: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: ConstrainedBox(
//                 constraints: const BoxConstraints(
//                   maxHeight: 500, // FIX FOR OVERFLOW
//                 ),
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Header
//                       Row(
//                         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           SizedBox(width: 85,),
//                           const Text(
//                             'Edit your profile',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.close),
//                             onPressed: () => Navigator.pop(context),
//                             padding: EdgeInsets.zero,
//                             constraints: const BoxConstraints(),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),

//                       // Select Avatar
//                       const Text(
//                         'Select Avatar',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const SizedBox(height: 12),

//                       GridView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 4,
//                           crossAxisSpacing: 12,
//                           mainAxisSpacing: 12,
//                         ),
//                         itemCount: 8,
//                         itemBuilder: (context, index) {
//                           final isSelected = selectedAvatarIndex == index;
//                           return GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 selectedAvatarIndex = index;
//                               });
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 border: Border.all(
//                                   color: isSelected
//                                       ? Colors.pink
//                                       : Colors.transparent,
//                                   width: 3,
//                                 ),
//                               ),
//                               child: CircleAvatar(
//                                 backgroundColor: _getAvatarColor(index),
//                                 child: Image.asset(avatarImages[0]),
//                               ),
//                             ),
//                           );
//                         },
//                       ),

//                       const SizedBox(height: 24),

//                       const Text(
//                         'Edit Details',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const SizedBox(height: 12),

//                       const Text(
//                         'Real Name',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.black87,
//                         ),
//                       ),
//                       const SizedBox(height: 8),

//                       TextField(
//                         controller: realNameController,
//                         decoration: InputDecoration(
//                           prefixIcon:
//                               const Icon(Icons.person_outline, color: Colors.grey),
//                           suffixIcon:
//                               const Icon(Icons.lock_outline, color: Colors.grey),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide(color: Colors.grey[300]!),
//                           ),
//                           focusedBorder: const OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(8)),
//                             borderSide: BorderSide(color: Colors.pink),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 16),

//                       const Text(
//                         'Nick Name',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.black87,
//                         ),
//                       ),
//                       const SizedBox(height: 8),

//                       TextField(
//                         controller: nickNameController,
//                         decoration: InputDecoration(
//                           prefixIcon:
//                               const Icon(Icons.person_outline, color: Colors.grey),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide(color: Colors.grey[300]!),
//                           ),
//                           focusedBorder: const OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(8)),
//                             borderSide: BorderSide(color: Colors.pink),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 24),

//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () => Navigator.pop(context),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFFFE0A62),
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             elevation: 0,
//                           ),
//                           child: const Text(
//                             'Save',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
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

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const [
//             Icon(Icons.menu, color: Colors.black, size: 24),
//             SizedBox(width: 8),
//             Icon(Icons.chevron_right, color: Colors.black, size: 24),
//           ],
//         ),
//         actions: [
//           Container(
//             margin: const EdgeInsets.only(right: 16),
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//             decoration: BoxDecoration(
//               color: Colors.grey[200],
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Row(
//               children: const [
//                 CircleAvatar(
//                   radius: 10,
//                   backgroundColor: Colors.amber,
//                   child: Text(
//                     'C',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 6),
//                 Text(
//                   '200',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 16,
//                   ),
//                 ),
//                 SizedBox(width: 4),
//                 Icon(Icons.add, color: Colors.black, size: 18),
//               ],
//             ),
//           ),
//         ],
//       ),

//       body: Center(
//         child: Container(
//           margin: const EdgeInsets.all(16),
//           padding: const EdgeInsets.all(24),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey),
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.1),
//                 spreadRadius: 1,
//                 blurRadius: 10,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),

//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Stack(
//                 children: [
//                   Container(
//                     width: 90,
//                     height: 90,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(color: Colors.grey[200]!, width: 3),
//                     ),
//                     child: ClipOval(
//                       child: Image.asset(
//                         'assets/boyimage2.png',
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: GestureDetector(
//                       onTap: _showEditDialog,
//                       child: Container(
//                         width: 32,
//                         height: 32,
//                         decoration: BoxDecoration(
//                           color: Colors.pink,
//                           shape: BoxShape.circle,
//                           border: Border.all(color: Colors.white, width: 2),
//                         ),
//                         child: const Icon(
//                           Icons.edit,
//                           color: Colors.white,
//                           size: 16,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 16),

//               const Text(
//                 'Name',
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),

//               const SizedBox(height: 4),

//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
//                   const SizedBox(width: 4),
//                   Text(
//                     'Kakinada',
//                     style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 24),

//               Container(
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 margin: const EdgeInsets.symmetric(horizontal: 16),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.2),
//                       blurRadius: 4,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context)=>FollowScreen()));
//                       },
//                       child: Column(
//                         children: [
//                           const Text(
//                             '100',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             'Followers',
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(width: 1, height: 40, color: Colors.grey[300]),
//                     Column(
//                       children: [
//                         const Text(
//                           '100',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           'Following',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
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
