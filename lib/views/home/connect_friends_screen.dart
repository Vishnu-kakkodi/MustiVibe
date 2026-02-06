// import 'package:dating_app/views/random/random_screen.dart';
// import 'package:flutter/material.dart';

// class ConnectFriendsScreen extends StatelessWidget {
//   const ConnectFriendsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFFF0F5), // light pink background
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: const Text(
//           'Friends',
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         automaticallyImplyLeading: false,
//         centerTitle: false,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 // Floating hearts
//                 Positioned(
//                   top: -40,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: const [
//                       Icon(Icons.favorite, color: Colors.pink, size: 20),
//                       SizedBox(width: 10),
//                       Icon(Icons.thumb_up, color: Colors.blue, size: 20),
//                       SizedBox(width: 10),
//                       Icon(Icons.favorite, color: Colors.pink, size: 24),
//                     ],
//                   ),
//                 ),
//                 // Center image
//                 Container(
//                   height: 120,
//                   width: 120,
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 6,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                     image: DecorationImage(
//                       image: AssetImage('assets/homeimage.png'),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Connect with friends',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 25),
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 gradient: const LinearGradient(
//                   colors: [Color(0xFFFFC0CB), Color(0xFFFFFFFF)],
//                   begin: Alignment.centerLeft,
//                   end: Alignment.centerRight,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 4,
//                     offset: Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: ElevatedButton.icon(
//                 style: ElevatedButton.styleFrom(
//                   elevation: 0,
//                   backgroundColor: Colors.transparent,
//                   shadowColor: Colors.transparent,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=>RandomScreen()));
//                 },
//                 icon: const Icon(Icons.shuffle, color: Colors.black),
//                 label: const Text(
//                   'Random',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }








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











// // import 'package:flutter/foundation.dart';
// // import 'package:flutter/material.dart';
// // import 'package:camera/camera.dart';
// // import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
// // import 'dart:ui' as ui;
// // import 'dart:async';
// // import 'dart:math' as math;

// // class ConnectFriendsScreen extends StatefulWidget {
// //   const ConnectFriendsScreen({Key? key}) : super(key: key);

// //   @override
// //   State<ConnectFriendsScreen> createState() => _ConnectFriendsScreenState();
// // }

// // class _ConnectFriendsScreenState extends State<ConnectFriendsScreen> {
// //   CameraController? _cameraController;
// //   List<CameraDescription>? _cameras;
// //   bool _isCameraInitialized = false;
// //   int _selectedFilterIndex = 0;
  
// //   final FaceDetector _faceDetector = FaceDetector(
// //     options: FaceDetectorOptions(
// //       enableLandmarks: true,
// //       enableContours: true,
// //       enableClassification: true,
// //       enableTracking: true,
// //     ),
// //   );

// //   List<Face> _faces = [];
// //   bool _isDetecting = false;
// //   Size? _imageSize;

// //   // AR Filter List
// //   final List<Map<String, dynamic>> _arFilters = [
// //     {
// //       'name': 'None',
// //       'type': 'none',
// //       'icon': Icons.face,
// //     },
// //     {
// //       'name': 'Dog',
// //       'type': 'dog',
// //       'icon': Icons.pets,
// //     },
// //     {
// //       'name': 'Cat',
// //       'type': 'cat',
// //       'icon': Icons.emoji_nature,
// //     },
// //     {
// //       'name': 'Crown',
// //       'type': 'crown',
// //       'icon': Icons.diamond,
// //     },
// //     {
// //       'name': 'Glasses',
// //       'type': 'glasses',
// //       'icon': Icons.visibility,
// //     },
// //     {
// //       'name': 'Hearts',
// //       'type': 'hearts',
// //       'icon': Icons.favorite,
// //     },
// //     {
// //       'name': 'Bunny',
// //       'type': 'bunny',
// //       'icon': Icons.cruelty_free,
// //     },
// //     {
// //       'name': 'Mustache',
// //       'type': 'mustache',
// //       'icon': Icons.face_retouching_natural,
// //     },
// //     {
// //       'name': 'Sparkles',
// //       'type': 'sparkles',
// //       'icon': Icons.auto_awesome,
// //     },
// //     {
// //       'name': 'Zombie',
// //       'type': 'zombie',
// //       'icon': Icons.sentiment_very_dissatisfied,
// //     },
// //   ];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _initializeCamera();
// //   }

// //   Future<void> _initializeCamera() async {
// //     try {
// //       _cameras = await availableCameras();
      
// //       if (_cameras != null && _cameras!.isNotEmpty) {
// //         final frontCamera = _cameras!.firstWhere(
// //           (camera) => camera.lensDirection == CameraLensDirection.front,
// //           orElse: () => _cameras!.first,
// //         );

// //         _cameraController = CameraController(
// //           frontCamera,
// //           ResolutionPreset.high,
// //           enableAudio: false,
// //           imageFormatGroup: ImageFormatGroup.yuv420,
// //         );

// //         await _cameraController!.initialize();
        
// //         // Start face detection stream
// //         _cameraController!.startImageStream(_processCameraImage);

// //         if (!mounted) return;

// //         setState(() {
// //           _isCameraInitialized = true;
// //         });
// //       }
// //     } catch (e) {
// //       print('Error initializing camera: $e');
// //     }
// //   }

// //   Future<void> _processCameraImage(CameraImage cameraImage) async {
// //     if (_isDetecting) return;
    
// //     _isDetecting = true;

// //     try {
// //       final WriteBuffer allBytes = WriteBuffer();
// //       for (Plane plane in cameraImage.planes) {
// //         allBytes.putUint8List(plane.bytes);
// //       }
// //       final bytes = allBytes.done().buffer.asUint8List();

// //       final Size imageSize = Size(
// //         cameraImage.width.toDouble(),
// //         cameraImage.height.toDouble(),
// //       );

// //       final InputImageRotation imageRotation =
// //           InputImageRotation.rotation0deg;

// //       final InputImageFormat inputImageFormat =
// //           InputImageFormat.yuv420;

// //       final planeData = cameraImage.planes.map(
// //         (Plane plane) {
// //           return InputImageMetadata(
// //             size: imageSize,
// //             rotation: imageRotation,
// //             format: inputImageFormat,
// //             bytesPerRow: plane.bytesPerRow,
// //           );
// //         },
// //       ).toList();

// //       final inputImageMetadata = InputImageMetadata(
// //         size: imageSize,
// //         rotation: imageRotation,
// //         format: inputImageFormat,
// //         bytesPerRow: cameraImage.planes[0].bytesPerRow,
// //       );

// //       final inputImage = InputImage.fromBytes(
// //         bytes: bytes,
// //         metadata: inputImageMetadata,
// //       );

// //       final faces = await _faceDetector.processImage(inputImage);

// //       if (mounted) {
// //         setState(() {
// //           _faces = faces;
// //           _imageSize = imageSize;
// //         });
// //       }
// //     } catch (e) {
// //       print('Error detecting faces: $e');
// //     }

// //     _isDetecting = false;
// //   }

// //   void _switchCamera() async {
// //     if (_cameras == null || _cameras!.length < 2) return;

// //     await _cameraController?.stopImageStream();
    
// //     final currentCamera = _cameraController!.description;
// //     final newCamera = _cameras!.firstWhere(
// //       (camera) => camera.lensDirection != currentCamera.lensDirection,
// //       orElse: () => currentCamera,
// //     );

// //     await _cameraController?.dispose();

// //     _cameraController = CameraController(
// //       newCamera,
// //       ResolutionPreset.high,
// //       enableAudio: false,
// //       imageFormatGroup: ImageFormatGroup.yuv420,
// //     );

// //     await _cameraController!.initialize();
// //     _cameraController!.startImageStream(_processCameraImage);

// //     if (!mounted) return;

// //     setState(() {});
// //   }

// //   @override
// //   void dispose() {
// //     _cameraController?.stopImageStream();
// //     _cameraController?.dispose();
// //     _faceDetector.close();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final theme = Theme.of(context);
// //     final size = MediaQuery.of(context).size;

// //     if (!_isCameraInitialized || _cameraController == null) {
// //       return Scaffold(
// //         backgroundColor: Colors.black,
// //         body: Center(
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               CircularProgressIndicator(color: theme.colorScheme.primary),
// //               const SizedBox(height: 16),
// //               Text(
// //                 'Loading AR Camera...',
// //                 style: TextStyle(color: Colors.white, fontSize: 16),
// //               ),
// //             ],
// //           ),
// //         ),
// //       );
// //     }

// //     return Scaffold(
// //       backgroundColor: Colors.black,
// //       body: Stack(
// //         children: [
// //           // Camera Preview
// //           Positioned.fill(
// //             child: CameraPreview(_cameraController!),
// //           ),

// //           // AR Face Filter Overlay
// //           if (_selectedFilterIndex != 0)
// //             Positioned.fill(
// //               child: CustomPaint(
// //                 painter: FaceFilterPainter(
// //                   faces: _faces,
// //                   imageSize: _imageSize ?? Size.zero,
// //                   filterType: _arFilters[_selectedFilterIndex]['type'],
// //                   cameraLensDirection: _cameraController!.description.lensDirection,
// //                 ),
// //               ),
// //             ),

// //           // Face Detection Debug (Optional - remove in production)
// //           if (_faces.isNotEmpty)
// //             Positioned(
// //               top: 60,
// //               left: 16,
// //               child: Container(
// //                 padding: const EdgeInsets.all(8),
// //                 decoration: BoxDecoration(
// //                   color: Colors.black.withOpacity(0.6),
// //                   borderRadius: BorderRadius.circular(8),
// //                 ),
// //                 child: Text(
// //                   'Faces detected: ${_faces.length}',
// //                   style: TextStyle(color: Colors.white, fontSize: 12),
// //                 ),
// //               ),
// //             ),

// //           // Top Bar
// //           Positioned(
// //             top: 0,
// //             left: 0,
// //             right: 0,
// //             child: SafeArea(
// //               child: Container(
// //                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //                 decoration: BoxDecoration(
// //                   gradient: LinearGradient(
// //                     begin: Alignment.topCenter,
// //                     end: Alignment.bottomCenter,
// //                     colors: [
// //                       Colors.black.withOpacity(0.6),
// //                       Colors.transparent,
// //                     ],
// //                   ),
// //                 ),
// //                 child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     IconButton(
// //                       icon: Icon(Icons.close, color: Colors.white, size: 28),
// //                       onPressed: () => Navigator.pop(context),
// //                     ),
// //                     Text(
// //                       'AR Filters',
// //                       style: TextStyle(
// //                         color: Colors.white,
// //                         fontSize: 18,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //                     IconButton(
// //                       icon: Icon(Icons.settings, color: Colors.white, size: 28),
// //                       onPressed: () {},
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ),

// //           // Side Controls
// //           Positioned(
// //             right: 16,
// //             top: size.height * 0.3,
// //             child: Column(
// //               children: [
// //                 _buildSideButton(
// //                   icon: Icons.flip_camera_ios,
// //                   onTap: _switchCamera,
// //                 ),
// //                 const SizedBox(height: 24),
// //                 _buildSideButton(
// //                   icon: Icons.flash_off,
// //                   onTap: () {},
// //                 ),
// //               ],
// //             ),
// //           ),

// //           // Bottom Filter Selector
// //           Positioned(
// //             bottom: 0,
// //             left: 0,
// //             right: 0,
// //             child: Container(
// //               padding: const EdgeInsets.only(bottom: 100, top: 20),
// //               decoration: BoxDecoration(
// //                 gradient: LinearGradient(
// //                   begin: Alignment.bottomCenter,
// //                   end: Alignment.topCenter,
// //                   colors: [
// //                     Colors.black.withOpacity(0.8),
// //                     Colors.black.withOpacity(0.4),
// //                     Colors.transparent,
// //                   ],
// //                 ),
// //               ),
// //               child: Column(
// //                 mainAxisSize: MainAxisSize.min,
// //                 children: [
// //                   // Capture Button
// //                   GestureDetector(
// //                     onTap: () async {
// //                       try {
// //                         await _cameraController!.stopImageStream();
// //                         final image = await _cameraController!.takePicture();
// //                         print('Picture saved to: ${image.path}');
// //                         _cameraController!.startImageStream(_processCameraImage);
// //                       } catch (e) {
// //                         print('Error taking picture: $e');
// //                       }
// //                     },
// //                     child: Container(
// //                       width: 70,
// //                       height: 70,
// //                       decoration: BoxDecoration(
// //                         shape: BoxShape.circle,
// //                         border: Border.all(color: Colors.white, width: 4),
// //                       ),
// //                       child: Container(
// //                         margin: const EdgeInsets.all(4),
// //                         decoration: BoxDecoration(
// //                           shape: BoxShape.circle,
// //                           color: Colors.white,
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                   const SizedBox(height: 24),
                  
// //                   // AR Filter List
// //                   SizedBox(
// //                     height: 100,
// //                     child: ListView.builder(
// //                       scrollDirection: Axis.horizontal,
// //                       padding: const EdgeInsets.symmetric(horizontal: 16),
// //                       itemCount: _arFilters.length,
// //                       itemBuilder: (context, index) {
// //                         final filter = _arFilters[index];
// //                         final isSelected = _selectedFilterIndex == index;

// //                         return GestureDetector(
// //                           onTap: () {
// //                             setState(() {
// //                               _selectedFilterIndex = index;
// //                             });
// //                           },
// //                           child: Container(
// //                             margin: const EdgeInsets.only(right: 12),
// //                             child: Column(
// //                               children: [
// //                                 Container(
// //                                   width: 60,
// //                                   height: 60,
// //                                   decoration: BoxDecoration(
// //                                     shape: BoxShape.circle,
// //                                     color: isSelected
// //                                         ? theme.colorScheme.primary
// //                                         : Colors.white.withOpacity(0.2),
// //                                     border: Border.all(
// //                                       color: isSelected
// //                                           ? theme.colorScheme.primary
// //                                           : Colors.white.withOpacity(0.5),
// //                                       width: isSelected ? 3 : 2,
// //                                     ),
// //                                   ),
// //                                   child: Icon(
// //                                     filter['icon'],
// //                                     color: Colors.white,
// //                                     size: 30,
// //                                   ),
// //                                 ),
// //                                 const SizedBox(height: 6),
// //                                 Text(
// //                                   filter['name'],
// //                                   style: TextStyle(
// //                                     color: isSelected
// //                                         ? theme.colorScheme.primary
// //                                         : Colors.white,
// //                                     fontSize: 12,
// //                                     fontWeight: isSelected
// //                                         ? FontWeight.bold
// //                                         : FontWeight.normal,
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         );
// //                       },
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildSideButton({
// //     required IconData icon,
// //     required VoidCallback onTap,
// //   }) {
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Container(
// //         width: 48,
// //         height: 48,
// //         decoration: BoxDecoration(
// //           shape: BoxShape.circle,
// //           color: Colors.black.withOpacity(0.5),
// //           border: Border.all(color: Colors.white.withOpacity(0.3)),
// //         ),
// //         child: Icon(
// //           icon,
// //           color: Colors.white,
// //           size: 24,
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // AR Face Filter Painter
// // class FaceFilterPainter extends CustomPainter {
// //   final List<Face> faces;
// //   final Size imageSize;
// //   final String filterType;
// //   final CameraLensDirection cameraLensDirection;

// //   FaceFilterPainter({
// //     required this.faces,
// //     required this.imageSize,
// //     required this.filterType,
// //     required this.cameraLensDirection,
// //   });

// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     if (faces.isEmpty || imageSize.width == 0 || imageSize.height == 0) return;

// //     final double scaleX = size.width / imageSize.height;
// //     final double scaleY = size.height / imageSize.width;

// //     for (Face face in faces) {
// //       // Get face landmarks
// //       final leftEye = face.landmarks[FaceLandmarkType.leftEye];
// //       final rightEye = face.landmarks[FaceLandmarkType.rightEye];
// //       final nose = face.landmarks[FaceLandmarkType.noseBase];
// //       final mouth = face.landmarks[FaceLandmarkType.bottomMouth];
// //       final leftCheek = face.landmarks[FaceLandmarkType.leftCheek];
// //       final rightCheek = face.landmarks[FaceLandmarkType.rightCheek];

// //       // Convert coordinates from Point<int> to Offset
// //       Offset? convertPoint(FaceLandmark? landmark) {
// //         if (landmark == null) return null;
// //         final point = landmark.position;
        
// //         double x, y;
// //         if (cameraLensDirection == CameraLensDirection.front) {
// //           x = size.width - (point.y.toDouble() * scaleX);
// //           y = point.x.toDouble() * scaleY;
// //         } else {
// //           x = point.y.toDouble() * scaleX;
// //           y = point.x.toDouble() * scaleY;
// //         }
// //         return Offset(x, y);
// //       }

// //       final leftEyePos = convertPoint(leftEye);
// //       final rightEyePos = convertPoint(rightEye);
// //       final nosePos = convertPoint(nose);
// //       final mouthPos = convertPoint(mouth);
// //       final leftCheekPos = convertPoint(leftCheek);
// //       final rightCheekPos = convertPoint(rightCheek);

// //       // Draw filter based on type
// //       switch (filterType) {
// //         case 'dog':
// //           _drawDogFilter(canvas, leftEyePos, rightEyePos, nosePos, mouthPos, face);
// //           break;
// //         case 'cat':
// //           _drawCatFilter(canvas, leftEyePos, rightEyePos, nosePos, mouthPos);
// //           break;
// //         case 'crown':
// //           _drawCrownFilter(canvas, leftEyePos, rightEyePos, face);
// //           break;
// //         case 'glasses':
// //           _drawGlassesFilter(canvas, leftEyePos, rightEyePos);
// //           break;
// //         case 'hearts':
// //           _drawHeartsFilter(canvas, leftCheekPos, rightCheekPos);
// //           break;
// //         case 'bunny':
// //           _drawBunnyFilter(canvas, leftEyePos, rightEyePos, face);
// //           break;
// //         case 'mustache':
// //           _drawMustacheFilter(canvas, nosePos, mouthPos);
// //           break;
// //         case 'sparkles':
// //           _drawSparklesFilter(canvas, face, size);
// //           break;
// //         case 'zombie':
// //           _drawZombieFilter(canvas, leftEyePos, rightEyePos, mouthPos);
// //           break;
// //       }
// //     }
// //   }

// //   void _drawDogFilter(Canvas canvas, Offset? leftEye, Offset? rightEye, 
// //                       Offset? nose, Offset? mouth, Face face) {
// //     if (leftEye == null || rightEye == null || nose == null) return;

// //     final paint = Paint()..color = Colors.brown;
    
// //     // Dog ears
// //     final earSize = (rightEye.dx - leftEye.dx) * 0.7;
    
// //     // Left ear
// //     final leftEarPath = Path();
// //     leftEarPath.moveTo(leftEye.dx - earSize / 2, leftEye.dy - earSize);
// //     leftEarPath.quadraticBezierTo(
// //       leftEye.dx - earSize, leftEye.dy - earSize / 2,
// //       leftEye.dx - earSize / 3, leftEye.dy + earSize / 2,
// //     );
// //     leftEarPath.close();
// //     canvas.drawPath(leftEarPath, paint);

// //     // Right ear
// //     final rightEarPath = Path();
// //     rightEarPath.moveTo(rightEye.dx + earSize / 2, rightEye.dy - earSize);
// //     rightEarPath.quadraticBezierTo(
// //       rightEye.dx + earSize, rightEye.dy - earSize / 2,
// //       rightEye.dx + earSize / 3, rightEye.dy + earSize / 2,
// //     );
// //     rightEarPath.close();
// //     canvas.drawPath(rightEarPath, paint);

// //     // Dog nose
// //     paint.color = Colors.black;
// //     canvas.drawCircle(nose, 20, paint);

// //     // Tongue (if mouth is open)
// //     if (mouth != null && face.smilingProbability != null && 
// //         face.smilingProbability! > 0.3) {
// //       paint.color = Colors.pink;
// //       final tonguePath = Path();
// //       tonguePath.moveTo(mouth.dx, mouth.dy);
// //       tonguePath.quadraticBezierTo(
// //         mouth.dx - 15, mouth.dy + 30,
// //         mouth.dx, mouth.dy + 40,
// //       );
// //       tonguePath.quadraticBezierTo(
// //         mouth.dx + 15, mouth.dy + 30,
// //         mouth.dx, mouth.dy,
// //       );
// //       canvas.drawPath(tonguePath, paint);
// //     }
// //   }

// //   void _drawCatFilter(Canvas canvas, Offset? leftEye, Offset? rightEye, 
// //                       Offset? nose, Offset? mouth) {
// //     if (leftEye == null || rightEye == null || nose == null) return;

// //     final paint = Paint()
// //       ..color = Colors.pink
// //       ..strokeWidth = 2
// //       ..style = PaintingStyle.stroke;

// //     // Cat ears
// //     final earSize = (rightEye.dx - leftEye.dx) * 0.5;
    
// //     // Left ear
// //     final leftEarPath = Path();
// //     leftEarPath.moveTo(leftEye.dx - earSize / 2, leftEye.dy - earSize * 1.5);
// //     leftEarPath.lineTo(leftEye.dx - earSize, leftEye.dy);
// //     leftEarPath.lineTo(leftEye.dx, leftEye.dy);
// //     leftEarPath.close();
// //     paint.style = PaintingStyle.fill;
// //     paint.color = Colors.pink.withOpacity(0.8);
// //     canvas.drawPath(leftEarPath, paint);

// //     // Right ear
// //     final rightEarPath = Path();
// //     rightEarPath.moveTo(rightEye.dx + earSize / 2, rightEye.dy - earSize * 1.5);
// //     rightEarPath.lineTo(rightEye.dx + earSize, rightEye.dy);
// //     rightEarPath.lineTo(rightEye.dx, rightEye.dy);
// //     rightEarPath.close();
// //     canvas.drawPath(rightEarPath, paint);

// //     // Cat nose
// //     paint.color = Colors.pink;
// //     final noseTriangle = Path();
// //     noseTriangle.moveTo(nose.dx, nose.dy - 10);
// //     noseTriangle.lineTo(nose.dx - 10, nose.dy + 5);
// //     noseTriangle.lineTo(nose.dx + 10, nose.dy + 5);
// //     noseTriangle.close();
// //     canvas.drawPath(noseTriangle, paint);

// //     // Whiskers
// //     paint.style = PaintingStyle.stroke;
// //     paint.strokeWidth = 2;
// //     paint.color = Colors.white;
    
// //     // Left whiskers
// //     for (int i = 0; i < 3; i++) {
// //       canvas.drawLine(
// //         Offset(nose.dx - 10, nose.dy + i * 5),
// //         Offset(nose.dx - 50, nose.dy + i * 5 - 10),
// //         paint,
// //       );
// //     }
    
// //     // Right whiskers
// //     for (int i = 0; i < 3; i++) {
// //       canvas.drawLine(
// //         Offset(nose.dx + 10, nose.dy + i * 5),
// //         Offset(nose.dx + 50, nose.dy + i * 5 - 10),
// //         paint,
// //       );
// //     }
// //   }

// //   void _drawCrownFilter(Canvas canvas, Offset? leftEye, Offset? rightEye, Face face) {
// //     if (leftEye == null || rightEye == null) return;

// //     final centerX = (leftEye.dx + rightEye.dx) / 2;
// //     final centerY = leftEye.dy - (rightEye.dx - leftEye.dx) * 0.8;
// //     final width = (rightEye.dx - leftEye.dx) * 1.2;

// //     final paint = Paint()
// //       ..shader = ui.Gradient.linear(
// //         Offset(centerX - width / 2, centerY),
// //         Offset(centerX + width / 2, centerY),
// //         [Colors.yellow, Colors.orange, Colors.yellow],
// //       );

// //     final crownPath = Path();
// //     crownPath.moveTo(centerX - width / 2, centerY + 20);
    
// //     for (int i = 0; i < 5; i++) {
// //       final x = centerX - width / 2 + (width / 4) * i;
// //       if (i % 2 == 0) {
// //         crownPath.lineTo(x, centerY - 30);
// //       } else {
// //         crownPath.lineTo(x, centerY + 10);
// //       }
// //     }
    
// //     crownPath.lineTo(centerX + width / 2, centerY + 20);
// //     crownPath.close();
// //     canvas.drawPath(crownPath, paint);

// //     // Jewels on crown
// //     final jewelPaint = Paint()..color = Colors.red;
// //     for (int i = 0; i < 3; i++) {
// //       canvas.drawCircle(
// //         Offset(centerX - width / 4 + (width / 4) * i, centerY),
// //         5,
// //         jewelPaint,
// //       );
// //     }
// //   }

// //   void _drawGlassesFilter(Canvas canvas, Offset? leftEye, Offset? rightEye) {
// //     if (leftEye == null || rightEye == null) return;

// //     final paint = Paint()
// //       ..color = Colors.black
// //       ..style = PaintingStyle.stroke
// //       ..strokeWidth = 3;

// //     final lensRadius = (rightEye.dx - leftEye.dx) * 0.25;

// //     // Left lens
// //     canvas.drawCircle(leftEye, lensRadius, paint);
    
// //     // Right lens
// //     canvas.drawCircle(rightEye, lensRadius, paint);

// //     // Bridge
// //     canvas.drawLine(
// //       Offset(leftEye.dx + lensRadius, leftEye.dy),
// //       Offset(rightEye.dx - lensRadius, rightEye.dy),
// //       paint,
// //     );

// //     // Left arm
// //     canvas.drawLine(
// //       Offset(leftEye.dx - lensRadius, leftEye.dy),
// //       Offset(leftEye.dx - lensRadius - 30, leftEye.dy - 5),
// //       paint,
// //     );

// //     // Right arm
// //     canvas.drawLine(
// //       Offset(rightEye.dx + lensRadius, rightEye.dy),
// //       Offset(rightEye.dx + lensRadius + 30, rightEye.dy - 5),
// //       paint,
// //     );
// //   }

// //   void _drawHeartsFilter(Canvas canvas, Offset? leftCheek, Offset? rightCheek) {
// //     if (leftCheek == null || rightCheek == null) return;

// //     final paint = Paint()
// //       ..color = Colors.pink.withOpacity(0.8)
// //       ..style = PaintingStyle.fill;

// //     _drawHeart(canvas, leftCheek, 25, paint);
// //     _drawHeart(canvas, rightCheek, 25, paint);
// //   }

// //   void _drawHeart(Canvas canvas, Offset center, double size, Paint paint) {
// //     final path = Path();
// //     path.moveTo(center.dx, center.dy + size / 4);
    
// //     path.cubicTo(
// //       center.dx - size / 2, center.dy - size / 3,
// //       center.dx - size, center.dy + size / 10,
// //       center.dx, center.dy + size,
// //     );
    
// //     path.cubicTo(
// //       center.dx + size, center.dy + size / 10,
// //       center.dx + size / 2, center.dy - size / 3,
// //       center.dx, center.dy + size / 4,
// //     );
    
// //     canvas.drawPath(path, paint);
// //   }

// //   void _drawBunnyFilter(Canvas canvas, Offset? leftEye, Offset? rightEye, Face face) {
// //     if (leftEye == null || rightEye == null) return;

// //     final centerX = (leftEye.dx + rightEye.dx) / 2;
// //     final centerY = leftEye.dy - (rightEye.dx - leftEye.dx) * 0.5;
// //     final earWidth = (rightEye.dx - leftEye.dx) * 0.3;
// //     final earHeight = earWidth * 2.5;

// //     final paint = Paint()
// //       ..color = Colors.pink.withOpacity(0.9)
// //       ..style = PaintingStyle.fill;

// //     // Left ear
// //     final leftEarPath = Path();
// //     leftEarPath.moveTo(centerX - earWidth, centerY);
// //     leftEarPath.quadraticBezierTo(
// //       centerX - earWidth - 5, centerY - earHeight / 2,
// //       centerX - earWidth, centerY - earHeight,
// //     );
// //     leftEarPath.quadraticBezierTo(
// //       centerX - earWidth / 2, centerY - earHeight - 10,
// //       centerX - earWidth / 2, centerY,
// //     );
// //     canvas.drawPath(leftEarPath, paint);

// //     // Right ear
// //     final rightEarPath = Path();
// //     rightEarPath.moveTo(centerX + earWidth, centerY);
// //     rightEarPath.quadraticBezierTo(
// //       centerX + earWidth + 5, centerY - earHeight / 2,
// //       centerX + earWidth, centerY - earHeight,
// //     );
// //     rightEarPath.quadraticBezierTo(
// //       centerX + earWidth / 2, centerY - earHeight - 10,
// //       centerX + earWidth / 2, centerY,
// //     );
// //     canvas.drawPath(rightEarPath, paint);
// //   }

// //   void _drawMustacheFilter(Canvas canvas, Offset? nose, Offset? mouth) {
// //     if (nose == null || mouth == null) return;

// //     final paint = Paint()
// //       ..color = Colors.black
// //       ..style = PaintingStyle.fill;

// //     final mustacheY = (nose.dy + mouth.dy) / 2;
// //     final mustacheWidth = (mouth.dx - nose.dx).abs() * 2;

// //     // Left mustache curl
// //     final leftPath = Path();
// //     leftPath.moveTo(nose.dx, mustacheY);
// //     leftPath.quadraticBezierTo(
// //       nose.dx - mustacheWidth / 2, mustacheY - 20,
// //       nose.dx - mustacheWidth / 2, mustacheY,
// //     );
// //     leftPath.quadraticBezierTo(
// //       nose.dx - mustacheWidth / 3, mustacheY + 10,
// //       nose.dx, mustacheY,
// //     );
// //     canvas.drawPath(leftPath, paint);

// //     // Right mustache curl
// //     final rightPath = Path();
// //     rightPath.moveTo(nose.dx, mustacheY);
// //     rightPath.quadraticBezierTo(
// //       nose.dx + mustacheWidth / 2, mustacheY - 20,
// //       nose.dx + mustacheWidth / 2, mustacheY,
// //     );
// //     rightPath.quadraticBezierTo(
// //       nose.dx + mustacheWidth / 3, mustacheY + 10,
// //       nose.dx, mustacheY,
// //     );
// //     canvas.drawPath(rightPath, paint);
// //   }

// //   void _drawSparklesFilter(Canvas canvas, Face face, Size size) {
// //     final paint = Paint()
// //       ..color = Colors.yellow
// //       ..style = PaintingStyle.fill;

// //     // Draw sparkles around the face
// //     final boundingBox = face.boundingBox;
// //     final centerX = (boundingBox.left + boundingBox.right) / 2;
// //     final centerY = (boundingBox.top + boundingBox.bottom) / 2;

// //     for (int i = 0; i < 8; i++) {
// //       final angle = (i * math.pi * 2) / 8;
// //       final radius = boundingBox.width / 2 + 30;
// //       final sparkleX = centerX + radius * math.cos(angle);
// //       final sparkleY = centerY + radius * math.sin(angle);
      
// //       // Convert to screen coordinates
// //       final scaleX = size.width / imageSize.height;
// //       final scaleY = size.height / imageSize.width;
      
// //       final sparklePos = Offset(
// //         size.width - (sparkleY * scaleX),
// //         sparkleX * scaleY,
// //       );

// //       _drawStar(canvas, sparklePos, 15, paint);
// //     }
// //   }

// //   void _drawStar(Canvas canvas, Offset center, double size, Paint paint) {
// //     final path = Path();
// //     for (int i = 0; i < 5; i++) {
// //       final angle = (i * 4 * math.pi) / 5 - math.pi / 2;
// //       final x = center.dx + size * math.cos(angle);
// //       final y = center.dy + size * math.sin(angle);
// //       if (i == 0) {
// //         path.moveTo(x, y);
// //       } else {
// //         path.lineTo(x, y);
// //       }
// //     }
// //     path.close();
// //     canvas.drawPath(path, paint);
// //   }

// //   void _drawZombieFilter(Canvas canvas, Offset? leftEye, Offset? rightEye, Offset? mouth) {
// //     if (leftEye == null || rightEye == null) return;

// //     final paint = Paint()
// //       ..color = Colors.green.withOpacity(0.3)
// //       ..style = PaintingStyle.fill;

// //     // Green skin overlay would go on the whole face
// //     // For simplicity, draw green circles around eyes
// //     canvas.drawCircle(leftEye, 35, paint);
// //     canvas.drawCircle(rightEye, 35, paint);

// //     // Dark eyes
// //     paint.color = Colors.red.withOpacity(0.8);
// //     canvas.drawCircle(leftEye, 15, paint);
// //     canvas.drawCircle(rightEye, 15, paint);

// //     // Stitches on mouth
// //     if (mouth != null) {
// //       paint.color = Colors.black;
// //       paint.style = PaintingStyle.stroke;
// //       paint.strokeWidth = 2;
      
// //       for (int i = 0; i < 5; i++) {
// //         canvas.drawLine(
// //           Offset(mouth.dx - 30 + i * 15, mouth.dy - 5),
// //           Offset(mouth.dx - 30 + i * 15, mouth.dy + 5),
// //           paint,
// //         );
// //       }
// //     }
// //   }

// //   @override
// //   bool shouldRepaint(FaceFilterPainter oldDelegate) {
// //     return oldDelegate.faces != faces ||
// //         oldDelegate.filterType != filterType;
// //   }
// // }

















// // import 'dart:io';
// // import 'dart:math';
// // import 'package:flutter/material.dart';
// // import 'package:camera/camera.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:share_plus/share_plus.dart';
// // import 'package:ffmpeg_kit_flutter_new_min_gpl/ffmpeg_kit.dart';
// // import 'package:ffmpeg_kit_flutter_new_min_gpl/return_code.dart';
// // import 'package:video_player/video_player.dart';
// // import 'package:permission_handler/permission_handler.dart';
// // import 'package:gal/gal.dart';

// // /// ================= AUDIO MODEL =================
// // class AudioItem {
// //   final String id;
// //   final String name;
// //   final String assetPath;
// //   final IconData icon;
// //   final Color color;
// //   final int durationSeconds;

// //   const AudioItem({
// //     required this.id,
// //     required this.name,
// //     required this.assetPath,
// //     required this.icon,
// //     this.color = Colors.purple,
// //     this.durationSeconds = 5,
// //   });
// // }

// // /// ================= EFFECT MODEL =================
// // class EffectItem {
// //   final String name;
// //   final String type;
// //   final IconData icon;
// //   const EffectItem({
// //     required this.name,
// //     required this.type,
// //     required this.icon,
// //   });
// // }

// // /// ================= MAIN SCREEN =================
// // class CameraVideoEffectsScreen extends StatefulWidget {
// //   const CameraVideoEffectsScreen({super.key});

// //   @override
// //   State<CameraVideoEffectsScreen> createState() => _CameraVideoEffectsScreenState();
// // }

// // class _CameraVideoEffectsScreenState extends State<CameraVideoEffectsScreen>
// //     with SingleTickerProviderStateMixin {
// //   CameraController? _cameraController;
// //   bool _cameraReady = false;
// //   late AnimationController _animationController;
// //   int _selectedEffect = 0;
// //   bool _isRecording = false;
// //   XFile? _recordedFile;
  
// //   // Audio section
// //   AudioItem? _selectedAudio;
// //   String? _finalVideoPath;
// //   VideoPlayerController? _videoController;
// //   bool _isProcessingVideo = false;
// //   bool _videoReady = false;

// //   final List<EffectItem> effects = const [
// //     EffectItem(name: 'None', type: 'none', icon: Icons.block),
// //     EffectItem(name: 'Hearts', type: 'hearts', icon: Icons.favorite),
// //     EffectItem(name: 'Rain', type: 'rain', icon: Icons.water_drop),
// //     EffectItem(name: 'Rainbow', type: 'rainbow', icon: Icons.gradient),
// //     EffectItem(name: 'Flowers', type: 'flowers', icon: Icons.local_florist),
// //     EffectItem(name: 'Stars', type: 'stars', icon: Icons.star),
// //     EffectItem(name: 'Sparkles', type: 'sparkles', icon: Icons.auto_awesome),
// //   ];

// //   // Audio Library - Add your audio files to assets folder
// //   final List<AudioItem> audioLibrary = const [
// //     AudioItem(
// //       id: 'audio_1',
// //       name: 'Happy Vibe',
// //       assetPath: 'assets/sounds/outgoing.mp3',
// //       icon: Icons.music_note,
// //       color: Colors.orange,
// //       durationSeconds: 5,
// //     ),
// //     AudioItem(
// //       id: 'audio_2',
// //       name: 'Chill Beat',
// //       assetPath: 'assets/sounds/outgoing.mp3',
// //       icon: Icons.music_note,
// //       color: Colors.blue,
// //       durationSeconds: 5,
// //     ),
// //     AudioItem(
// //       id: 'audio_3',
// //       name: 'Upbeat',
// //       assetPath: 'assets/sounds/outgoing.mp3',
// //       icon: Icons.music_note,
// //       color: Colors.green,
// //       durationSeconds: 5,
// //     ),
// //     AudioItem(
// //       id: 'audio_4',
// //       name: 'Romantic',
// //       assetPath: 'assets/sounds/outgoing.mp3',
// //       icon: Icons.favorite,
// //       color: Colors.pink,
// //       durationSeconds: 5,
// //     ),
// //     AudioItem(
// //       id: 'audio_5',
// //       name: 'Epic',
// //       assetPath: 'assets/sounds/outgoing.mp3',
// //       icon: Icons.whatshot,
// //       color: Colors.red,
// //       durationSeconds: 5,
// //     ),
// //     AudioItem(
// //       id: 'audio_6',
// //       name: 'Funky',
// //       assetPath: 'assets/sounds/outgoing.mp3',
// //       icon: Icons.music_note,
// //       color: Colors.purple,
// //       durationSeconds: 5,
// //     ),
// //   ];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _initCamera();
// //     _animationController = AnimationController(
// //       vsync: this,
// //       duration: const Duration(seconds: 3),
// //     )..repeat();
// //   }

// //   /// ---------- INIT FRONT CAMERA ----------
// //   Future<void> _initCamera() async {
// //     final cameras = await availableCameras();
// //     final frontCamera = cameras.firstWhere(
// //       (c) => c.lensDirection == CameraLensDirection.front,
// //       orElse: () => cameras.first,
// //     );
// //     _cameraController = CameraController(
// //       frontCamera,
// //       ResolutionPreset.high,
// //       enableAudio: true,
// //     );
// //     await _cameraController!.initialize();
// //     if (!mounted) return;
// //     setState(() => _cameraReady = true);
// //   }

// //   /// ---------- SHOW AUDIO LIBRARY ----------
// //   Future<void> _showAudioLibrary() async {
// //     final selected = await showModalBottomSheet<AudioItem>(
// //       context: context,
// //       backgroundColor: Colors.transparent,
// //       isScrollControlled: true,
// //       builder: (context) => Container(
// //         height: MediaQuery.of(context).size.height * 0.7,
// //         decoration: const BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.only(
// //             topLeft: Radius.circular(20),
// //             topRight: Radius.circular(20),
// //           ),
// //         ),
// //         child: Column(
// //           children: [
// //             // Handle bar
// //             Container(
// //               width: 40,
// //               height: 4,
// //               margin: const EdgeInsets.only(top: 12, bottom: 8),
// //               decoration: BoxDecoration(
// //                 color: Colors.grey[300],
// //                 borderRadius: BorderRadius.circular(2),
// //               ),
// //             ),
            
// //             // Title
// //             Padding(
// //               padding: const EdgeInsets.all(16),
// //               child: Row(
// //                 children: [
// //                   Icon(Icons.library_music, color: Colors.deepPurple, size: 28),
// //                   const SizedBox(width: 12),
// //                   const Text(
// //                     'Audio Library',
// //                     style: TextStyle(
// //                       fontSize: 22,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),

// //             // Audio List
// //             Expanded(
// //               child: ListView.builder(
// //                 padding: const EdgeInsets.symmetric(horizontal: 16),
// //                 itemCount: audioLibrary.length,
// //                 itemBuilder: (context, index) {
// //                   final audio = audioLibrary[index];
// //                   final isSelected = _selectedAudio?.id == audio.id;
                  
// //                   return Container(
// //                     margin: const EdgeInsets.only(bottom: 12),
// //                     decoration: BoxDecoration(
// //                       gradient: isSelected
// //                           ? LinearGradient(
// //                               colors: [
// //                                 audio.color.withOpacity(0.2),
// //                                 audio.color.withOpacity(0.1),
// //                               ],
// //                             )
// //                           : null,
// //                       border: Border.all(
// //                         color: isSelected ? audio.color : Colors.grey.shade300,
// //                         width: isSelected ? 2 : 1,
// //                       ),
// //                       borderRadius: BorderRadius.circular(12),
// //                     ),
// //                     child: ListTile(
// //                       leading: Container(
// //                         padding: const EdgeInsets.all(12),
// //                         decoration: BoxDecoration(
// //                           color: audio.color.withOpacity(0.2),
// //                           shape: BoxShape.circle,
// //                         ),
// //                         child: Icon(
// //                           audio.icon,
// //                           color: audio.color,
// //                           size: 24,
// //                         ),
// //                       ),
// //                       title: Text(
// //                         audio.name,
// //                         style: TextStyle(
// //                           fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
// //                           fontSize: 16,
// //                         ),
// //                       ),
// //                       subtitle: Text(
// //                         '${audio.durationSeconds}s duration',
// //                         style: TextStyle(
// //                           color: Colors.grey[600],
// //                           fontSize: 12,
// //                         ),
// //                       ),
// //                       trailing: isSelected
// //                           ? Icon(Icons.check_circle, color: audio.color, size: 28)
// //                           : Icon(Icons.circle_outlined, color: Colors.grey, size: 28),
// //                       onTap: () {
// //                         Navigator.pop(context, audio);
// //                       },
// //                     ),
// //                   );
// //                 },
// //               ),
// //             ),

// //             // Clear Selection Button
// //             if (_selectedAudio != null)
// //               Padding(
// //                 padding: const EdgeInsets.all(16),
// //                 child: ElevatedButton.icon(
// //                   onPressed: () {
// //                     Navigator.pop(context, null);
// //                   },
// //                   icon: const Icon(Icons.clear),
// //                   label: const Text('Clear Audio'),
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: Colors.grey[300],
// //                     foregroundColor: Colors.black87,
// //                     minimumSize: const Size(double.infinity, 50),
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(12),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //           ],
// //         ),
// //       ),
// //     );

// //     if (selected != null) {
// //       setState(() {
// //         _selectedAudio = selected;
// //         _finalVideoPath = null;
// //         _videoReady = false;
// //       });
      
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('🎵 Audio selected: ${selected.name}'),
// //           backgroundColor: selected.color,
// //           behavior: SnackBarBehavior.floating,
// //           duration: const Duration(seconds: 2),
// //         ),
// //       );
// //     } else if (selected == null && _selectedAudio != null) {
// //       // Clear selection
// //       setState(() {
// //         _selectedAudio = null;
// //       });
      
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(
// //           content: Text('Audio cleared'),
// //           backgroundColor: Colors.grey,
// //           behavior: SnackBarBehavior.floating,
// //           duration: Duration(seconds: 2),
// //         ),
// //       );
// //     }
// //   }

// //   /// ---------- START RECORD ----------
// //   Future<void> _startRecording() async {
// //     if (_cameraController == null || _isRecording) return;

// //     await _cameraController!.startVideoRecording();
// //     setState(() => _isRecording = true);

// //     // Auto stop after 5 seconds (or selected audio duration)
// //     final duration = _selectedAudio?.durationSeconds ?? 5;
// //     await Future.delayed(Duration(seconds: duration));
// //     await _stopRecording();
// //   }

// //   /// ---------- STOP RECORD ----------
// //   Future<void> _stopRecording() async {
// //     if (!_isRecording) return;

// //     final file = await _cameraController!.stopVideoRecording();
// //     setState(() {
// //       _isRecording = false;
// //       _recordedFile = file;
// //     });

// //     // If audio is selected, merge it
// //     if (_selectedAudio != null) {
// //       await _mergeAudioWithVideo(file.path);
// //     } else {
// //       // No audio, just share the video
// //       await Share.shareXFiles(
// //         [XFile(file.path)],
// //         text: '🔥 Made with Flutter',
// //       );
// //     }
// //   }

// //   /// ---------- MERGE AUDIO WITH VIDEO ----------
// //   Future<void> _mergeAudioWithVideo(String videoPath) async {
// //     setState(() => _isProcessingVideo = true);

// //     try {
// //       print("1️⃣ Starting audio merge...");
      
// //       final tempDir = await getTemporaryDirectory();
// //       final outputPath = '${tempDir.path}/final_${DateTime.now().millisecondsSinceEpoch}.mp4';
      
// //       // Get audio file from assets
// //       final audioPath = await _getAudioPathFromAssets(_selectedAudio!.assetPath);
      
// //       print("2️⃣ Video: $videoPath");
// //       print("   Audio: $audioPath");
      
// //       // FFmpeg command to merge video and audio
// //       final command = '''
// //         -y 
// //         -i "$videoPath" 
// //         -i "$audioPath" 
// //         -c:v copy 
// //         -c:a aac 
// //         -map 0:v:0 
// //         -map 1:a:0 
// //         -shortest 
// //         "$outputPath"
// //       '''.replaceAll('\n', ' ').replaceAll(RegExp(r'\s+'), ' ').trim();
      
// //       print("3️⃣ Executing FFmpeg...");
// //       print("Command: $command");
      
// //       final session = await FFmpegKit.execute(command);
// //       final returnCode = await session.getReturnCode();
// //       final logs = await session.getAllLogs();
      
// //       // Print logs for debugging
// //       for (var log in logs) {
// //         print("FFmpeg: ${log.getMessage()}");
// //       }
      
// //       if (ReturnCode.isSuccess(returnCode)) {
// //         final outputFile = File(outputPath);
// //         if (await outputFile.exists()) {
// //           final fileSize = await outputFile.length();
// //           print("4️⃣ ✅ Success! File size: $fileSize bytes");
          
// //           setState(() {
// //             _finalVideoPath = outputPath;
// //             _isProcessingVideo = false;
// //           });
          
// //           // Initialize video player for preview
// //           await _initVideoPlayer(outputPath);
          
// //           // Show success message
// //           if (mounted) {
// //             ScaffoldMessenger.of(context).showSnackBar(
// //               SnackBar(
// //                 content: Text('✨ Video with ${_selectedAudio!.name} ready!'),
// //                 backgroundColor: Colors.green,
// //                 behavior: SnackBarBehavior.floating,
// //                 action: SnackBarAction(
// //                   label: 'Preview',
// //                   textColor: Colors.white,
// //                   onPressed: () {
// //                     setState(() => _videoReady = true);
// //                   },
// //                 ),
// //               ),
// //             );
// //           }
// //         } else {
// //           throw Exception("Output file not created");
// //         }
// //       } else {
// //         throw Exception("FFmpeg failed with code: ${returnCode?.getValue()}");
// //       }
// //     } catch (e, stackTrace) {
// //       print("❌ Error: $e");
// //       print("Stack: $stackTrace");
      
// //       setState(() => _isProcessingVideo = false);
      
// //       if (mounted) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(
// //             content: Text('Error: $e'),
// //             backgroundColor: Colors.red,
// //             duration: const Duration(seconds: 4),
// //           ),
// //         );
// //       }
// //     }
// //   }

// //   /// ---------- GET AUDIO FROM ASSETS ----------
// //   Future<String> _getAudioPathFromAssets(String assetPath) async {
// //     // For this example, we'll use a placeholder
// //     // In real app, you need to copy asset to temp directory
// //     final tempDir = await getTemporaryDirectory();
// //     final audioFile = File('${tempDir.path}/temp_audio.mp3');
    
// //     // TODO: Copy from assets
// //     // final byteData = await rootBundle.load(assetPath);
// //     // await audioFile.writeAsBytes(byteData.buffer.asUint8List());
    
// //     // For now, create a silent audio as fallback
// //     if (!await audioFile.exists()) {
// //       final silentCmd = '-y -f lavfi -i anullsrc=r=44100:cl=stereo -t ${_selectedAudio!.durationSeconds} ${audioFile.path}';
// //       await FFmpegKit.execute(silentCmd);
// //     }
    
// //     return audioFile.path;
// //   }

// //   /// ---------- INIT VIDEO PLAYER ----------
// //   Future<void> _initVideoPlayer(String videoPath) async {
// //     if (_videoController != null) {
// //       await _videoController!.dispose();
// //     }
    
// //     _videoController = VideoPlayerController.file(File(videoPath));
// //     await _videoController!.initialize();
// //     await _videoController!.setLooping(true);
// //     setState(() => _videoReady = true);
// //   }

// //   /// ---------- DOWNLOAD VIDEO ----------
// //   Future<void> _downloadVideo() async {
// //     if (_finalVideoPath == null) return;

// //     final status = await Permission.videos.request();
// //     if (!status.isGranted) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text("Gallery permission required")),
// //       );
// //       return;
// //     }

// //     try {
// //       await Gal.putVideo(
// //         _finalVideoPath!,
// //         album: "Camera Effects",
// //       );

// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(
// //           content: Text("Video saved to Gallery! 🎉"),
// //           backgroundColor: Colors.green,
// //         ),
// //       );
// //     } catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("Failed to save: $e")),
// //       );
// //     }
// //   }

// //   /// ---------- SHARE VIDEO ----------
// //   Future<void> _shareVideo() async {
// //     if (_finalVideoPath == null) return;

// //     try {
// //       await Share.shareXFiles(
// //         [XFile(_finalVideoPath!)],
// //         text: "✨ Created with Flutter Camera Effects 🎬🎵",
// //       );
// //     } catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("Error sharing: $e")),
// //       );
// //     }
// //   }

// //   @override
// //   void dispose() {
// //     _animationController.dispose();
// //     _cameraController?.dispose();
// //     _videoController?.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     if (!_cameraReady) {
// //       return const Scaffold(
// //         backgroundColor: Colors.black,
// //         body: Center(
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               CircularProgressIndicator(color: Colors.pinkAccent),
// //               SizedBox(height: 16),
// //               Text(
// //                 'Initializing Camera...',
// //                 style: TextStyle(color: Colors.white),
// //               ),
// //             ],
// //           ),
// //         ),
// //       );
// //     }

// //     return Scaffold(
// //       backgroundColor: Colors.black,
// //       body: Stack(
// //         children: [
// //           /// Camera Preview
// // /// Camera Preview - FIXED
// // Positioned.fill(
// //   child: _videoReady && _videoController != null
// //       ? FittedBox(
// //           fit: BoxFit.cover,
// //           child: SizedBox(
// //             width: _videoController!.value.size.width,
// //             height: _videoController!.value.size.height,
// //             child: VideoPlayer(_videoController!),
// //           ),
// //         )
// //       : OverflowBox(
// //           alignment: Alignment.center,
// //           child: FittedBox(
// //             fit: BoxFit.cover,
// //             child: SizedBox(
// //               width: _cameraController!.value.previewSize!.height,
// //               height: _cameraController!.value.previewSize!.width,
// //               child: CameraPreview(_cameraController!),
// //             ),
// //           ),
// //         ),
// // ),

// //           /// Live Effects (only when not showing video)
// //           if (!_videoReady && effects[_selectedEffect].type != 'none')
// //             AnimatedBuilder(
// //               animation: _animationController,
// //               builder: (_, __) {
// //                 return CustomPaint(
// //                   size: MediaQuery.of(context).size,
// //                   painter: EffectsPainter(
// //                     progress: _animationController.value,
// //                     effect: effects[_selectedEffect].type,
// //                   ),
// //                 );
// //               },
// //             ),

// //           /// Processing Overlay
// //           if (_isProcessingVideo)
// //             Container(
// //               color: Colors.black87,
// //               child: Center(
// //                 child: Column(
// //                   mainAxisSize: MainAxisSize.min,
// //                   children: [
// //                     const CircularProgressIndicator(color: Colors.pinkAccent),
// //                     const SizedBox(height: 16),
// //                     Text(
// //                       'Adding ${_selectedAudio?.name ?? "audio"}...',
// //                       style: const TextStyle(color: Colors.white, fontSize: 16),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),

// //           /// Top Bar
// //           SafeArea(
// //             child: Padding(
// //               padding: const EdgeInsets.all(16),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   const Text(
// //                     'Live Camera Effects',
// //                     style: TextStyle(
// //                       color: Colors.white,
// //                       fontSize: 20,
// //                       fontWeight: FontWeight.bold,
// //                       shadows: [
// //                         Shadow(color: Colors.black54, blurRadius: 10),
// //                       ],
// //                     ),
// //                   ),
                  
// //                   // Audio Button
// //                   GestureDetector(
// //                     onTap: _showAudioLibrary,
// //                     child: Container(
// //                       padding: const EdgeInsets.symmetric(
// //                         horizontal: 16,
// //                         vertical: 8,
// //                       ),
// //                       decoration: BoxDecoration(
// //                         color: _selectedAudio != null
// //                             ? _selectedAudio!.color
// //                             : Colors.white.withOpacity(0.3),
// //                         borderRadius: BorderRadius.circular(20),
// //                         border: Border.all(
// //                           color: Colors.white,
// //                           width: 2,
// //                         ),
// //                       ),
// //                       child: Row(
// //                         mainAxisSize: MainAxisSize.min,
// //                         children: [
// //                           Icon(
// //                             _selectedAudio != null
// //                                 ? _selectedAudio!.icon
// //                                 : Icons.library_music,
// //                             color: Colors.white,
// //                             size: 20,
// //                           ),
// //                           const SizedBox(width: 8),
// //                           Text(
// //                             _selectedAudio?.name ?? 'Add Audio',
// //                             style: const TextStyle(
// //                               color: Colors.white,
// //                               fontWeight: FontWeight.bold,
// //                               fontSize: 14,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),

// //           /// Bottom Controls
// //           Positioned(
// //             bottom: 40,
// //             left: 0,
// //             right: 0,
// //             child: Column(
// //               children: [
// //                 /// Video Preview Controls
// //                 if (_videoReady && _videoController != null) ...[
// //                   Container(
// //                     margin: const EdgeInsets.symmetric(horizontal: 16),
// //                     padding: const EdgeInsets.all(16),
// //                     decoration: BoxDecoration(
// //                       color: Colors.black87,
// //                       borderRadius: BorderRadius.circular(16),
// //                     ),
// //                     child: Column(
// //                       children: [
// //                         Text(
// //                           '✨ Video Ready with ${_selectedAudio?.name ?? "audio"}!',
// //                           style: const TextStyle(
// //                             color: Colors.white,
// //                             fontSize: 16,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                         const SizedBox(height: 16),
                        
// //                         Row(
// //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                           children: [
// //                             // Play/Pause
// //                             IconButton(
// //                               icon: Icon(
// //                                 _videoController!.value.isPlaying
// //                                     ? Icons.pause_circle_filled
// //                                     : Icons.play_circle_filled,
// //                                 size: 48,
// //                                 color: Colors.white,
// //                               ),
// //                               onPressed: () {
// //                                 setState(() {
// //                                   if (_videoController!.value.isPlaying) {
// //                                     _videoController!.pause();
// //                                   } else {
// //                                     _videoController!.play();
// //                                   }
// //                                 });
// //                               },
// //                             ),
                            
// //                             // Download
// //                             ElevatedButton.icon(
// //                               onPressed: _downloadVideo,
// //                               icon: const Icon(Icons.download),
// //                               label: const Text('Save'),
// //                               style: ElevatedButton.styleFrom(
// //                                 backgroundColor: Colors.green,
// //                                 foregroundColor: Colors.white,
// //                               ),
// //                             ),
                            
// //                             // Share
// //                             ElevatedButton.icon(
// //                               onPressed: _shareVideo,
// //                               icon: const Icon(Icons.share),
// //                               label: const Text('Share'),
// //                               style: ElevatedButton.styleFrom(
// //                                 backgroundColor: Colors.pinkAccent,
// //                                 foregroundColor: Colors.white,
// //                               ),
// //                             ),
// //                           ],
// //                         ),
                        
// //                         const SizedBox(height: 16),
                        
// //                         // Record Again Button
// //                         ElevatedButton.icon(
// //                           onPressed: () {
// //                             setState(() {
// //                               _videoReady = false;
// //                               _finalVideoPath = null;
// //                             });
// //                             _videoController?.dispose();
// //                             _videoController = null;
// //                           },
// //                           icon: const Icon(Icons.refresh),
// //                           label: const Text('Record Again'),
// //                           style: ElevatedButton.styleFrom(
// //                             backgroundColor: Colors.white.withOpacity(0.3),
// //                             foregroundColor: Colors.white,
// //                             minimumSize: const Size(double.infinity, 48),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
                  
// //                   const SizedBox(height: 20),
// //                 ],

// //                 /// Record Button (only when not showing video)
// //                 if (!_videoReady) ...[
// //                   GestureDetector(
// //                     onTap: _isRecording || _isProcessingVideo
// //                         ? null
// //                         : _startRecording,
// //                     child: Container(
// //                       width: 70,
// //                       height: 70,
// //                       decoration: BoxDecoration(
// //                         shape: BoxShape.circle,
// //                         color: _isRecording ? Colors.red : Colors.white,
// //                         border: Border.all(color: Colors.white, width: 4),
// //                         boxShadow: [
// //                           BoxShadow(
// //                             color: (_isRecording ? Colors.red : Colors.pinkAccent)
// //                                 .withOpacity(0.5),
// //                             blurRadius: 15,
// //                             spreadRadius: 2,
// //                           ),
// //                         ],
// //                       ),
// //                       child: _isRecording
// //                           ? const Icon(Icons.stop, color: Colors.white, size: 32)
// //                           : const Icon(
// //                               Icons.fiber_manual_record,
// //                               color: Colors.red,
// //                               size: 32,
// //                             ),
// //                     ),
// //                   ),

// //                   const SizedBox(height: 20),

// //                   /// Effects Selector
// //                   SizedBox(
// //                     height: 100,
// //                     child: ListView.builder(
// //                       scrollDirection: Axis.horizontal,
// //                       padding: const EdgeInsets.symmetric(horizontal: 16),
// //                       itemCount: effects.length,
// //                       itemBuilder: (_, i) {
// //                         final selected = _selectedEffect == i;
// //                         return GestureDetector(
// //                           onTap: () => setState(() => _selectedEffect = i),
// //                           child: Column(
// //                             children: [
// //                               Container(
// //                                 margin: const EdgeInsets.symmetric(horizontal: 8),
// //                                 width: 60,
// //                                 height: 60,
// //                                 decoration: BoxDecoration(
// //                                   shape: BoxShape.circle,
// //                                   color: selected
// //                                       ? Colors.pinkAccent
// //                                       : Colors.white30,
// //                                   boxShadow: selected
// //                                       ? [
// //                                           BoxShadow(
// //                                             color: Colors.pinkAccent
// //                                                 .withOpacity(0.5),
// //                                             blurRadius: 15,
// //                                             spreadRadius: 2,
// //                                           ),
// //                                         ]
// //                                       : null,
// //                                 ),
// //                                 child: Icon(
// //                                   effects[i].icon,
// //                                   color: Colors.white,
// //                                   size: 28,
// //                                 ),
// //                               ),
// //                               const SizedBox(height: 8),
// //                               Text(
// //                                 effects[i].name,
// //                                 style: TextStyle(
// //                                   color: selected
// //                                       ? Colors.pinkAccent
// //                                       : Colors.white70,
// //                                   fontSize: 11,
// //                                   fontWeight: selected
// //                                       ? FontWeight.bold
// //                                       : FontWeight.normal,
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         );
// //                       },
// //                     ),
// //                   ),
// //                 ],
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // /// ================= PREVIEW EFFECTS PAINTER =================
// // class EffectsPainter extends CustomPainter {
// //   final double progress;
// //   final String effect;
// //   final Random random = Random(42);

// //   EffectsPainter({
// //     required this.progress,
// //     required this.effect,
// //   });

// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     switch (effect) {
// //       case 'hearts':
// //         _drawHearts(canvas, size);
// //         break;
// //       case 'rain':
// //         _drawRain(canvas, size);
// //         break;
// //       case 'rainbow':
// //         _drawRainbow(canvas, size);
// //         break;
// //       case 'flowers':
// //         _drawFlowers(canvas, size);
// //         break;
// //       case 'stars':
// //         _drawStars(canvas, size);
// //         break;
// //       case 'sparkles':
// //         _drawSparkles(canvas, size);
// //         break;
// //     }
// //   }

// //   void _drawHearts(Canvas canvas, Size size) {
// //     for (int i = 0; i < 25; i++) {
// //       final x = random.nextDouble() * size.width;
// //       final baseY = random.nextDouble() * size.height;
// //       final y = (baseY - progress * 200) % size.height;
// //       final opacity = (1 - (y / size.height)) * 0.6;

// //       // Draw heart shape
// //       final path = Path();
// //       final heartSize = random.nextDouble() * 15 + 10;
// //       path.moveTo(x, y + heartSize * 0.3);
// //       path.cubicTo(
// //         x - heartSize * 0.5,
// //         y - heartSize * 0.3,
// //         x - heartSize,
// //         y + heartSize * 0.3,
// //         x,
// //         y + heartSize,
// //       );
// //       path.cubicTo(
// //         x + heartSize,
// //         y + heartSize * 0.3,
// //         x + heartSize * 0.5,
// //         y - heartSize * 0.3,
// //         x,
// //         y + heartSize * 0.3,
// //       );

// //       canvas.drawPath(
// //         path,
// //         Paint()
// //           ..color = Colors.pinkAccent.withOpacity(opacity)
// //           ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2),
// //       );
// //     }
// //   }

// //   void _drawRain(Canvas canvas, Size size) {
// //     for (int i = 0; i < 120; i++) {
// //       final x = random.nextDouble() * size.width;
// //       final y = (progress * size.height * 2 + i * 30) % size.height;

// //       canvas.drawLine(
// //         Offset(x, y),
// //         Offset(x, y + 12),
// //         Paint()
// //           ..color = Colors.lightBlueAccent.withOpacity(0.6)
// //           ..strokeWidth = 2,
// //       );
// //     }
// //   }

// //   void _drawRainbow(Canvas canvas, Size size) {
// //     final rect = Offset.zero & size;
// //     canvas.drawRect(
// //       rect,
// //       Paint()
// //         ..shader = LinearGradient(
// //           colors: [
// //             Colors.red.withOpacity(0.3),
// //             Colors.orange.withOpacity(0.3),
// //             Colors.yellow.withOpacity(0.3),
// //             Colors.green.withOpacity(0.3),
// //             Colors.blue.withOpacity(0.3),
// //             Colors.purple.withOpacity(0.3),
// //           ],
// //         ).createShader(rect),
// //     );
// //   }

// //   void _drawFlowers(Canvas canvas, Size size) {
// //     for (int i = 0; i < 20; i++) {
// //       final x = random.nextDouble() * size.width;
// //       final baseY = random.nextDouble() * size.height;
// //       final y = (baseY - progress * 150) % size.height;
// //       final opacity = (1 - (y / size.height)) * 0.5;

// //       for (int p = 0; p < 5; p++) {
// //         final angle = (p * 2 * pi) / 5;
// //         canvas.drawCircle(
// //           Offset(x + cos(angle) * 10, y + sin(angle) * 10),
// //           4,
// //           Paint()..color = Colors.purpleAccent.withOpacity(opacity),
// //         );
// //       }
      
// //       // Center
// //       canvas.drawCircle(
// //         Offset(x, y),
// //         3,
// //         Paint()..color = Colors.yellowAccent.withOpacity(opacity),
// //       );
// //     }
// //   }

// //   void _drawStars(Canvas canvas, Size size) {
// //     for (int i = 0; i < 30; i++) {
// //       final x = random.nextDouble() * size.width;
// //       final y = random.nextDouble() * size.height;
// //       final twinkle = sin(progress * 2 * pi + i);
// //       final opacity = ((twinkle + 1) / 2) * 0.7;

// //       // Draw star
// //       final path = Path();
// //       final starSize = random.nextDouble() * 8 + 5;
// //       for (int p = 0; p < 5; p++) {
// //         final angle = (p * 4 * pi) / 5 - pi / 2;
// //         final radius = p % 2 == 0 ? starSize : starSize / 2;
// //         if (p == 0) {
// //           path.moveTo(x + cos(angle) * radius, y + sin(angle) * radius);
// //         } else {
// //           path.lineTo(x + cos(angle) * radius, y + sin(angle) * radius);
// //         }
// //       }
// //       path.close();

// //       canvas.drawPath(
// //         path,
// //         Paint()
// //           ..color = Colors.yellowAccent.withOpacity(opacity)
// //           ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
// //       );
// //     }
// //   }

// // void _drawSparkles(Canvas canvas, Size size) {
// //   for (int i = 0; i < 40; i++) {
// //     final x = random.nextDouble() * size.width;  // ✅ Fixed
// //     final y = random.nextDouble() * size.height; // ✅ Fixed
// //     final sparkle = sin(progress * 4 * pi + i * 0.5);
// //     final opacity = ((sparkle + 1) / 2) * 0.8;
// //     final sparkleSize = (sparkle + 1) * 2 + 2;

// //     // Cross sparkle
// //     canvas.drawLine(
// //       Offset(x - sparkleSize, y),
// //       Offset(x + sparkleSize, y),
// //       Paint()
// //         ..color = Colors.white.withOpacity(opacity)
// //         ..strokeWidth = 2
// //         ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2),
// //     );
    
// //     canvas.drawLine(
// //       Offset(x, y - sparkleSize),
// //       Offset(x, y + sparkleSize),
// //       Paint()
// //         ..color = Colors.white.withOpacity(opacity)
// //         ..strokeWidth = 2
// //         ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2),
// //     );
// //   }
// // }

// //   @override
// //   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// // }



















// // import 'dart:io';
// // import 'dart:math';
// // import 'package:flutter/material.dart';
// // import 'package:camera/camera.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:share_plus/share_plus.dart';
// // import 'package:ffmpeg_kit_flutter_new_min_gpl/ffmpeg_kit.dart';
// // import 'package:ffmpeg_kit_flutter_new_min_gpl/return_code.dart';
// // import 'package:video_player/video_player.dart';
// // import 'package:permission_handler/permission_handler.dart';
// // import 'package:gal/gal.dart';
// // import 'package:flutter/services.dart';

// // /// ================= AUDIO MODEL =================
// // class AudioItem {
// //   final String id;
// //   final String name;
// //   final String assetPath;
// //   final IconData icon;
// //   final Color color;
// //   final int durationSeconds;

// //   const AudioItem({
// //     required this.id,
// //     required this.name,
// //     required this.assetPath,
// //     required this.icon,
// //     this.color = Colors.purple,
// //     this.durationSeconds = 5,
// //   });
// // }

// // /// ================= EFFECT MODEL =================
// // class EffectItem {
// //   final String name;
// //   final String type;
// //   final IconData icon;
// //   const EffectItem({
// //     required this.name,
// //     required this.type,
// //     required this.icon,
// //   });
// // }

// // /// ================= MAIN SCREEN =================
// // class CameraVideoEffectsScreen extends StatefulWidget {
// //   const CameraVideoEffectsScreen({super.key});

// //   @override
// //   State<CameraVideoEffectsScreen> createState() => _CameraVideoEffectsScreenState();
// // }

// // class _CameraVideoEffectsScreenState extends State<CameraVideoEffectsScreen>
// //     with SingleTickerProviderStateMixin {
// //   CameraController? _cameraController;
// //   bool _cameraReady = false;
// //   bool _cameraInitialized = false;
// //   late AnimationController _animationController;
// //   int _selectedEffect = 0;
// //   bool _isRecording = false;
// //   XFile? _recordedFile;
  
// //   // Audio section
// //   AudioItem? _selectedAudio;
// //   String? _finalVideoPath;
// //   VideoPlayerController? _videoController;
// //   bool _isProcessingVideo = false;
// //   bool _videoReady = false;

// //   final List<EffectItem> effects = const [
// //     // EffectItem(name: 'None', type: 'none', icon: Icons.block),
// //     EffectItem(name: 'Hearts', type: 'hearts', icon: Icons.favorite),
// //     EffectItem(name: 'Rain', type: 'rain', icon: Icons.water_drop),
// //     EffectItem(name: 'Rainbow', type: 'rainbow', icon: Icons.gradient),
// //     EffectItem(name: 'Flowers', type: 'flowers', icon: Icons.local_florist),
// //     EffectItem(name: 'Stars', type: 'stars', icon: Icons.star),
// //     EffectItem(name: 'Sparkles', type: 'sparkles', icon: Icons.auto_awesome),
// //   ];

// //   // Audio Library - Add your audio files to assets folder
// //   final List<AudioItem> audioLibrary = const [
// //     AudioItem(
// //       id: 'audio_1',
// //       name: 'Happy Vibe',
// //       assetPath: 'assets/sounds/outgoing.mp3',
// //       icon: Icons.music_note,
// //       color: Colors.orange,
// //       durationSeconds: 5,
// //     ),
// //     AudioItem(
// //       id: 'audio_2',
// //       name: 'Chill Beat',
// //       assetPath: 'assets/sounds/outgoing.mp3',
// //       icon: Icons.music_note,
// //       color: Colors.blue,
// //       durationSeconds: 5,
// //     ),
// //     AudioItem(
// //       id: 'audio_3',
// //       name: 'Upbeat',
// //       assetPath: 'assets/sounds/outgoing.mp3',
// //       icon: Icons.music_note,
// //       color: Colors.green,
// //       durationSeconds: 5,
// //     ),
// //     AudioItem(
// //       id: 'audio_4',
// //       name: 'Romantic',
// //       assetPath: 'assets/sounds/outgoing.mp3',
// //       icon: Icons.favorite,
// //       color: Colors.pink,
// //       durationSeconds: 5,
// //     ),
// //     AudioItem(
// //       id: 'audio_5',
// //       name: 'Epic',
// //       assetPath: 'assets/sounds/outgoing.mp3',
// //       icon: Icons.whatshot,
// //       color: Colors.red,
// //       durationSeconds: 5,
// //     ),
// //     AudioItem(
// //       id: 'audio_6',
// //       name: 'Funky',
// //       assetPath: 'assets/sounds/outgoing.mp3',
// //       icon: Icons.music_note,
// //       color: Colors.purple,
// //       durationSeconds: 5,
// //     ),
// //   ];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _initCamera();
// //     _animationController = AnimationController(
// //       vsync: this,
// //       duration: const Duration(seconds: 3),
// //     )..repeat();
// //   }

// //   /// ---------- INIT FRONT CAMERA ----------
// //   Future<void> _initCamera() async {
// //     try {
// //       // Request camera permission first
// //       final cameraStatus = await Permission.camera.request();
// //       final microphoneStatus = await Permission.microphone.request();
      
// //       if (!cameraStatus.isGranted || !microphoneStatus.isGranted) {
// //         if (mounted) {
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             const SnackBar(
// //               content: Text('Camera and microphone permissions are required'),
// //               backgroundColor: Colors.red,
// //             ),
// //           );
// //         }
// //         return;
// //       }

// //       final cameras = await availableCameras();
      
// //       if (cameras.isEmpty) {
// //         if (mounted) {
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             const SnackBar(
// //               content: Text('No camera found'),
// //               backgroundColor: Colors.red,
// //             ),
// //           );
// //         }
// //         return;
// //       }
      
// //       final frontCamera = cameras.firstWhere(
// //         (c) => c.lensDirection == CameraLensDirection.front,
// //         orElse: () => cameras.first,
// //       );
      
// //       _cameraController = CameraController(
// //         frontCamera,
// //         ResolutionPreset.medium, // Changed to medium for better compatibility
// //         enableAudio: true,
// //         imageFormatGroup: ImageFormatGroup.yuv420, // Better compatibility
// //       );
      
// //       await _cameraController!.initialize();
      
// //       if (!mounted) return;
      
// //       setState(() {
// //         _cameraReady = true;
// //         _cameraInitialized = true;
// //       });
// //     } catch (e) {
// //       print('Camera initialization error: $e');
// //       if (mounted) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(
// //             content: Text('Camera error: $e'),
// //             backgroundColor: Colors.red,
// //           ),
// //         );
// //       }
// //     }
// //   }

// //   /// ---------- SHOW AUDIO LIBRARY ----------
// //   Future<void> _showAudioLibrary() async {
// //     final selected = await showModalBottomSheet<AudioItem>(
// //       context: context,
// //       backgroundColor: Colors.transparent,
// //       isScrollControlled: true,
// //       builder: (context) => Container(
// //         height: MediaQuery.of(context).size.height * 0.7,
// //         decoration: const BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.only(
// //             topLeft: Radius.circular(20),
// //             topRight: Radius.circular(20),
// //           ),
// //         ),
// //         child: Column(
// //           children: [
// //             // Handle bar
// //             Container(
// //               width: 40,
// //               height: 4,
// //               margin: const EdgeInsets.only(top: 12, bottom: 8),
// //               decoration: BoxDecoration(
// //                 color: Colors.grey[300],
// //                 borderRadius: BorderRadius.circular(2),
// //               ),
// //             ),
            
// //             // Title
// //             Padding(
// //               padding: const EdgeInsets.all(16),
// //               child: Row(
// //                 children: [
// //                   Icon(Icons.library_music, color: Colors.deepPurple, size: 28),
// //                   const SizedBox(width: 12),
// //                   const Text(
// //                     'Audio Library',
// //                     style: TextStyle(
// //                       fontSize: 22,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),

// //             // Audio List
// //             Expanded(
// //               child: ListView.builder(
// //                 padding: const EdgeInsets.symmetric(horizontal: 16),
// //                 itemCount: audioLibrary.length,
// //                 itemBuilder: (context, index) {
// //                   final audio = audioLibrary[index];
// //                   final isSelected = _selectedAudio?.id == audio.id;
                  
// //                   return Container(
// //                     margin: const EdgeInsets.only(bottom: 12),
// //                     decoration: BoxDecoration(
// //                       gradient: isSelected
// //                           ? LinearGradient(
// //                               colors: [
// //                                 audio.color.withOpacity(0.2),
// //                                 audio.color.withOpacity(0.1),
// //                               ],
// //                             )
// //                           : null,
// //                       border: Border.all(
// //                         color: isSelected ? audio.color : Colors.grey.shade300,
// //                         width: isSelected ? 2 : 1,
// //                       ),
// //                       borderRadius: BorderRadius.circular(12),
// //                     ),
// //                     child: ListTile(
// //                       leading: Container(
// //                         padding: const EdgeInsets.all(12),
// //                         decoration: BoxDecoration(
// //                           color: audio.color.withOpacity(0.2),
// //                           shape: BoxShape.circle,
// //                         ),
// //                         child: Icon(
// //                           audio.icon,
// //                           color: audio.color,
// //                           size: 24,
// //                         ),
// //                       ),
// //                       title: Text(
// //                         audio.name,
// //                         style: TextStyle(
// //                           fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
// //                           fontSize: 16,
// //                         ),
// //                       ),
// //                       subtitle: Text(
// //                         '${audio.durationSeconds}s duration',
// //                         style: TextStyle(
// //                           color: Colors.grey[600],
// //                           fontSize: 12,
// //                         ),
// //                       ),
// //                       trailing: isSelected
// //                           ? Icon(Icons.check_circle, color: audio.color, size: 28)
// //                           : Icon(Icons.circle_outlined, color: Colors.grey, size: 28),
// //                       onTap: () {
// //                         Navigator.pop(context, audio);
// //                       },
// //                     ),
// //                   );
// //                 },
// //               ),
// //             ),

// //             // Clear Selection Button
// //             if (_selectedAudio != null)
// //               Padding(
// //                 padding: const EdgeInsets.all(16),
// //                 child: ElevatedButton.icon(
// //                   onPressed: () {
// //                     Navigator.pop(context, null);
// //                   },
// //                   icon: const Icon(Icons.clear),
// //                   label: const Text('Clear Audio'),
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: Colors.grey[300],
// //                     foregroundColor: Colors.black87,
// //                     minimumSize: const Size(double.infinity, 50),
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(12),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //           ],
// //         ),
// //       ),
// //     );

// //     if (selected != null) {
// //       setState(() {
// //         _selectedAudio = selected;
// //         _finalVideoPath = null;
// //         _videoReady = false;
// //       });
      
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('🎵 Audio selected: ${selected.name}'),
// //           backgroundColor: selected.color,
// //           behavior: SnackBarBehavior.floating,
// //           duration: const Duration(seconds: 2),
// //         ),
// //       );
// //     } else if (selected == null && _selectedAudio != null) {
// //       // Clear selection
// //       setState(() {
// //         _selectedAudio = null;
// //       });
      
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(
// //           content: Text('Audio cleared'),
// //           backgroundColor: Colors.grey,
// //           behavior: SnackBarBehavior.floating,
// //           duration: const Duration(seconds: 2),
// //         ),
// //       );
// //     }
// //   }

// //   /// ---------- START RECORD ----------
// //   Future<void> _startRecording() async {
// //     if (_cameraController == null || _isRecording || !_cameraController!.value.isInitialized) return;

// //     try {
// //       await _cameraController!.startVideoRecording();
// //       setState(() => _isRecording = true);

// //       // Auto stop after 5 seconds (or selected audio duration)
// //       final duration = _selectedAudio?.durationSeconds ?? 5;
// //       await Future.delayed(Duration(seconds: duration));
// //       await _stopRecording();
// //     } catch (e) {
// //       print('Recording error: $e');
// //       setState(() => _isRecording = false);
      
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('Recording failed: $e'),
// //           backgroundColor: Colors.red,
// //         ),
// //       );
// //     }
// //   }

// //   /// ---------- STOP RECORD ----------
// //   Future<void> _stopRecording() async {
// //     if (!_isRecording || _cameraController == null) return;

// //     try {
// //       final file = await _cameraController!.stopVideoRecording();
// //       setState(() {
// //         _isRecording = false;
// //         _recordedFile = file;
// //       });

// //       // If audio is selected, merge it
// //       if (_selectedAudio != null) {
// //         await _mergeAudioWithVideo(file.path);
// //       } else {
// //         // No audio, just share the video
// //         await Share.shareXFiles(
// //           [XFile(file.path)],
// //           text: '🔥 Made with Flutter',
// //         );
// //       }
// //     } catch (e) {
// //       print('Stop recording error: $e');
// //       setState(() => _isRecording = false);
      
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('Failed to stop recording: $e'),
// //           backgroundColor: Colors.red,
// //         ),
// //       );
// //     }
// //   }

// //   /// ---------- MERGE AUDIO WITH VIDEO ----------
// //   // Future<void> _mergeAudioWithVideo(String videoPath) async {
// //   //   setState(() => _isProcessingVideo = true);

// //   //   try {
// //   //     print("1️⃣ Starting audio merge...");
      
// //   //     final tempDir = await getTemporaryDirectory();
// //   //     final outputPath = '${tempDir.path}/final_${DateTime.now().millisecondsSinceEpoch}.mp4';
      
// //   //     // Get audio file from assets
// //   //     final audioPath = await _getAudioPathFromAssets(_selectedAudio!.assetPath);
      
// //   //     print("2️⃣ Video: $videoPath");
// //   //     print("   Audio: $audioPath");
      
// //   //     // FFmpeg command to merge video and audio
// //   //     final command = '''
// //   //       -y 
// //   //       -i "$videoPath" 
// //   //       -i "$audioPath" 
// //   //       -c:v copy 
// //   //       -c:a aac 
// //   //       -map 0:v:0 
// //   //       -map 1:a:0 
// //   //       -shortest 
// //   //       "$outputPath"
// //   //     '''.replaceAll('\n', ' ').replaceAll(RegExp(r'\s+'), ' ').trim();
      
// //   //     print("3️⃣ Executing FFmpeg...");
// //   //     print("Command: $command");
      
// //   //     final session = await FFmpegKit.execute(command);
// //   //     final returnCode = await session.getReturnCode();
// //   //     final logs = await session.getAllLogs();
      
// //   //     // Print logs for debugging
// //   //     for (var log in logs) {
// //   //       print("FFmpeg: ${log.getMessage()}");
// //   //     }
      
// //   //     if (ReturnCode.isSuccess(returnCode)) {
// //   //       final outputFile = File(outputPath);
// //   //       if (await outputFile.exists()) {
// //   //         final fileSize = await outputFile.length();
// //   //         print("4️⃣ ✅ Success! File size: $fileSize bytes");
          
// //   //         setState(() {
// //   //           _finalVideoPath = outputPath;
// //   //           _isProcessingVideo = false;
// //   //         });
          
// //   //         // Initialize video player for preview
// //   //         await _initVideoPlayer(outputPath);
          
// //   //         // Show success message
// //   //         if (mounted) {
// //   //           ScaffoldMessenger.of(context).showSnackBar(
// //   //             SnackBar(
// //   //               content: Text('✨ Video with ${_selectedAudio!.name} ready!'),
// //   //               backgroundColor: Colors.green,
// //   //               behavior: SnackBarBehavior.floating,
// //   //               action: SnackBarAction(
// //   //                 label: 'Preview',
// //   //                 textColor: Colors.white,
// //   //                 onPressed: () {
// //   //                   setState(() => _videoReady = true);
// //   //                 },
// //   //               ),
// //   //             ),
// //   //           );
// //   //         }
// //   //       } else {
// //   //         throw Exception("Output file not created");
// //   //       }
// //   //     } else {
// //   //       throw Exception("FFmpeg failed with code: ${returnCode?.getValue()}");
// //   //     }
// //   //   } catch (e, stackTrace) {
// //   //     print("❌ Error: $e");
// //   //     print("Stack: $stackTrace");
      
// //   //     setState(() => _isProcessingVideo = false);
      
// //   //     if (mounted) {
// //   //       ScaffoldMessenger.of(context).showSnackBar(
// //   //         SnackBar(
// //   //           content: Text('Error: $e'),
// //   //           backgroundColor: Colors.red,
// //   //           duration: const Duration(seconds: 4),
// //   //         ),
// //   //       );
// //   //     }
// //   //   }
// //   // }


// //   /// ---------- MERGE AUDIO WITH VIDEO ----------
// // Future<void> _mergeAudioWithVideo(String videoPath) async {
// //   setState(() => _isProcessingVideo = true);

// //   try {
// //     print("1️⃣ Starting audio merge...");
    
// //     final tempDir = await getTemporaryDirectory();
// //     final outputPath = '${tempDir.path}/final_${DateTime.now().millisecondsSinceEpoch}.mp4';
    
// //     // Get audio file from assets
// //     final audioPath = await _getAudioPathFromAssets(_selectedAudio!.assetPath);
    
// //     // Verify audio file exists
// //     final audioFile = File(audioPath);
// //     if (!await audioFile.exists()) {
// //       throw Exception("Audio file does not exist at: $audioPath");
// //     }
    
// //     // Verify video file exists
// //     final videoFile = File(videoPath);
// //     if (!await videoFile.exists()) {
// //       throw Exception("Video file does not exist at: $videoPath");
// //     }
    
// //     print("2️⃣ Video: $videoPath (${await videoFile.length()} bytes)");
// //     print("   Audio: $audioPath (${await audioFile.length()} bytes)");
    
// //     // FFmpeg command to merge video and audio
// //     final command = '''
// //       -y 
// //       -i "$videoPath" 
// //       -i "$audioPath" 
// //       -c:v copy 
// //       -c:a aac 
// //       -map 0:v:0 
// //       -map 1:a:0 
// //       -shortest 
// //       "$outputPath"
// //     '''.replaceAll('\n', ' ').replaceAll(RegExp(r'\s+'), ' ').trim();
    
// //     print("3️⃣ Executing FFmpeg...");
// //     print("Command: $command");
    
// //     final session = await FFmpegKit.execute(command);
// //     final returnCode = await session.getReturnCode();
// //     final logs = await session.getAllLogs();
// //     final output = await session.getOutput();
    
// //     // Print logs for debugging
// //     print("=== FFMPEG LOGS START ===");
// //     for (var log in logs) {
// //       print("FFmpeg: ${log.getMessage()}");
// //     }
// //     if (output != null && output.isNotEmpty) {
// //       print("FFmpeg output: $output");
// //     }
// //     print("=== FFMPEG LOGS END ===");
    
// //     if (ReturnCode.isSuccess(returnCode)) {
// //       final outputFile = File(outputPath);
// //       if (await outputFile.exists()) {
// //         final fileSize = await outputFile.length();
// //         print("4️⃣ ✅ Success! Output: $outputPath, size: $fileSize bytes");
        
// //         setState(() {
// //           _finalVideoPath = outputPath;
// //           _isProcessingVideo = false;
// //         });
        
// //         // Initialize video player for preview
// //         await _initVideoPlayer(outputPath);
        
// //         // Show success message
// //         if (mounted) {
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             SnackBar(
// //               content: Text('✨ Video with ${_selectedAudio!.name} ready!'),
// //               backgroundColor: Colors.green,
// //               behavior: SnackBarBehavior.floating,
// //               action: SnackBarAction(
// //                 label: 'Preview',
// //                 textColor: Colors.white,
// //                 onPressed: () {
// //                   setState(() => _videoReady = true);
// //                 },
// //               ),
// //             ),
// //           );
// //         }
// //       } else {
// //         throw Exception("Output file was not created");
// //       }
// //     } else {
// //       throw Exception("FFmpeg failed with code: ${returnCode?.getValue()}");
// //     }
// //   } catch (e, stackTrace) {
// //     print("❌ Error: $e");
// //     print("Stack: $stackTrace");
    
// //     setState(() => _isProcessingVideo = false);
    
// //     if (mounted) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('Error: $e'),
// //           backgroundColor: Colors.red,
// //           duration: const Duration(seconds: 4),
// //         ),
// //       );
// //     }
// //   }
// // }

// //   /// ---------- GET AUDIO FROM ASSETS ----------
// // /// ---------- GET AUDIO FROM ASSETS ----------
// // Future<String> _getAudioPathFromAssets(String assetPath) async {
// //   try {
// //     final tempDir = await getTemporaryDirectory();
// //     final fileName = 'temp_audio_${DateTime.now().millisecondsSinceEpoch}.mp3';
// //     final audioFile = File('${tempDir.path}/$fileName');
    
// //     // Check if we need to copy from assets or create silent audio
// //     if (assetPath.startsWith('assets/')) {
// //       // Load from assets
// //       print("🔊 Loading audio from assets: $assetPath");
// //       final byteData = await rootBundle.load(assetPath);
// //       final buffer = byteData.buffer;
// //       await audioFile.writeAsBytes(
// //         buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes)
// //       );
      
// //       // Verify file was created
// //       if (await audioFile.exists()) {
// //         final fileSize = await audioFile.length();
// //         print("✅ Audio file created: ${audioFile.path}, size: $fileSize bytes");
// //       } else {
// //         throw Exception("Audio file was not created from assets");
// //       }
// //     } else {
// //       // Create silent audio as fallback
// //       print("🎵 Creating silent audio for duration: ${_selectedAudio!.durationSeconds}s");
// //       final silentCmd = '-y -f lavfi -i anullsrc=r=44100:cl=stereo -t ${_selectedAudio!.durationSeconds} "${audioFile.path}"';
// //       final session = await FFmpegKit.execute(silentCmd);
// //       final returnCode = await session.getReturnCode();
      
// //       if (!ReturnCode.isSuccess(returnCode)) {
// //         throw Exception("Failed to create silent audio");
// //       }
// //     }
    
// //     return audioFile.path;
// //   } catch (e) {
// //     print("❌ Audio loading error: $e");
// //     rethrow;
// //   }
// // }

// //   /// ---------- INIT VIDEO PLAYER ----------
// //   Future<void> _initVideoPlayer(String videoPath) async {
// //     if (_videoController != null) {
// //       await _videoController!.dispose();
// //     }
    
// //     try {
// //       _videoController = VideoPlayerController.file(File(videoPath));
// //       await _videoController!.initialize();
// //       await _videoController!.setLooping(true);
// //       await _videoController!.play();
// //       setState(() => _videoReady = true);
// //     } catch (e) {
// //       print('Video player error: $e');
// //       setState(() => _videoReady = false);
// //     }
// //   }

// //   /// ---------- DOWNLOAD VIDEO ----------
// //   Future<void> _downloadVideo() async {
// //     if (_finalVideoPath == null) return;

// //     final status = await Permission.storage.request();
// //     if (!status.isGranted) {
// //       if (mounted) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text("Storage permission required")),
// //         );
// //       }
// //       return;
// //     }

// //     try {
// //       await Gal.putVideo(
// //         _finalVideoPath!,
// //         album: "Camera Effects",
// //       );

// //       if (mounted) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(
// //             content: Text("Video saved to Gallery! 🎉"),
// //             backgroundColor: Colors.green,
// //           ),
// //         );
// //       }
// //     } catch (e) {
// //       if (mounted) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text("Failed to save: $e")),
// //         );
// //       }
// //     }
// //   }

// //   /// ---------- SHARE VIDEO ----------
// //   Future<void> _shareVideo() async {
// //     if (_finalVideoPath == null) return;

// //     try {
// //       await Share.shareXFiles(
// //         [XFile(_finalVideoPath!)],
// //         text: "✨ Created with Flutter Camera Effects 🎬🎵",
// //       );
// //     } catch (e) {
// //       if (mounted) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text("Error sharing: $e")),
// //         );
// //       }
// //     }
// //   }

// //   @override
// //   void dispose() {
// //     _animationController.dispose();
// //     _cameraController?.dispose();
// //     _videoController?.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     if (!_cameraReady) {
// //       return Scaffold(
// //         backgroundColor: Colors.black,
// //         body: Center(
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               const CircularProgressIndicator(color: Colors.pinkAccent),
// //               const SizedBox(height: 16),
// //               Text(
// //                 _cameraInitialized ? 'Camera Ready!' : 'Initializing Camera...',
// //                 style: const TextStyle(color: Colors.white),
// //               ),
// //               if (!_cameraInitialized)
// //                 const SizedBox(height: 16),
// //               if (!_cameraInitialized)
// //                 ElevatedButton(
// //                   onPressed: _initCamera,
// //                   child: const Text('Retry Camera'),
// //                 ),
// //             ],
// //           ),
// //         ),
// //       );
// //     }

// //     return Scaffold(
// //       backgroundColor: Colors.black,
// //       body: Stack(
// //         children: [
// //           /// Camera Preview - FIXED VERSION
// //           Positioned.fill(
// //             child: _videoReady && _videoController != null
// //                 ? VideoPlayer(_videoController!)
// //                 : _cameraController != null && _cameraController!.value.isInitialized
// //                     ? CameraPreview(_cameraController!)
// //                     : Container(
// //                         color: Colors.black,
// //                         child: const Center(
// //                           child: Text(
// //                             'Camera not available',
// //                             style: TextStyle(color: Colors.white),
// //                           ),
// //                         ),
// //                       ),
// //           ),

// //           /// Live Effects (only when not showing video)
// //           if (!_videoReady && effects[_selectedEffect].type != 'none')
// //             AnimatedBuilder(
// //               animation: _animationController,
// //               builder: (_, __) {
// //                 return CustomPaint(
// //                   size: MediaQuery.of(context).size,
// //                   painter: EffectsPainter(
// //                     progress: _animationController.value,
// //                     effect: effects[_selectedEffect].type,
// //                   ),
// //                 );
// //               },
// //             ),

// //           /// Processing Overlay
// //           if (_isProcessingVideo)
// //             Container(
// //               color: Colors.black87,
// //               child: Center(
// //                 child: Column(
// //                   mainAxisSize: MainAxisSize.min,
// //                   children: [
// //                     const CircularProgressIndicator(color: Colors.pinkAccent),
// //                     const SizedBox(height: 16),
// //                     Text(
// //                       'Adding ${_selectedAudio?.name ?? "audio"}...',
// //                       style: const TextStyle(color: Colors.white, fontSize: 16),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),

// //           /// Top Bar
// //           SafeArea(
// //             child: Padding(
// //               padding: const EdgeInsets.all(16),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   const Text(
// //                     'Live Camera Effects',
// //                     style: TextStyle(
// //                       color: Colors.white,
// //                       fontSize: 20,
// //                       fontWeight: FontWeight.bold,
// //                       shadows: [
// //                         Shadow(color: Colors.black54, blurRadius: 10),
// //                       ],
// //                     ),
// //                   ),
                  
// //                   // Audio Button
// //                   GestureDetector(
// //                     onTap: _showAudioLibrary,
// //                     child: Container(
// //                       padding: const EdgeInsets.symmetric(
// //                         horizontal: 16,
// //                         vertical: 8,
// //                       ),
// //                       decoration: BoxDecoration(
// //                         color: _selectedAudio != null
// //                             ? _selectedAudio!.color
// //                             : Colors.white.withOpacity(0.3),
// //                         borderRadius: BorderRadius.circular(20),
// //                         border: Border.all(
// //                           color: Colors.white,
// //                           width: 2,
// //                         ),
// //                       ),
// //                       child: Row(
// //                         mainAxisSize: MainAxisSize.min,
// //                         children: [
// //                           Icon(
// //                             _selectedAudio != null
// //                                 ? _selectedAudio!.icon
// //                                 : Icons.library_music,
// //                             color: Colors.white,
// //                             size: 20,
// //                           ),
// //                           const SizedBox(width: 8),
// //                           Text(
// //                             _selectedAudio?.name ?? 'Add Audio',
// //                             style: const TextStyle(
// //                               color: Colors.white,
// //                               fontWeight: FontWeight.bold,
// //                               fontSize: 14,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),

// //           /// Bottom Controls
// //           Positioned(
// //             bottom: 40,
// //             left: 0,
// //             right: 0,
// //             child: Column(
// //               children: [
// //                 /// Video Preview Controls
// //                 if (_videoReady && _videoController != null) ...[
// //                   Container(
// //                     margin: const EdgeInsets.symmetric(horizontal: 16),
// //                     padding: const EdgeInsets.all(16),
// //                     decoration: BoxDecoration(
// //                       color: Colors.black87,
// //                       borderRadius: BorderRadius.circular(16),
// //                     ),
// //                     child: Column(
// //                       children: [
// //                         Text(
// //                           '✨ Video Ready with ${_selectedAudio?.name ?? "audio"}!',
// //                           style: const TextStyle(
// //                             color: Colors.white,
// //                             fontSize: 16,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                         const SizedBox(height: 16),
                        
// //                         Row(
// //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                           children: [
// //                             // Play/Pause
// //                             IconButton(
// //                               icon: Icon(
// //                                 _videoController!.value.isPlaying
// //                                     ? Icons.pause_circle_filled
// //                                     : Icons.play_circle_filled,
// //                                 size: 48,
// //                                 color: Colors.white,
// //                               ),
// //                               onPressed: () {
// //                                 setState(() {
// //                                   if (_videoController!.value.isPlaying) {
// //                                     _videoController!.pause();
// //                                   } else {
// //                                     _videoController!.play();
// //                                   }
// //                                 });
// //                               },
// //                             ),
                            
// //                             // Download
// //                             ElevatedButton.icon(
// //                               onPressed: _downloadVideo,
// //                               icon: const Icon(Icons.download),
// //                               label: const Text('Save'),
// //                               style: ElevatedButton.styleFrom(
// //                                 backgroundColor: Colors.green,
// //                                 foregroundColor: Colors.white,
// //                               ),
// //                             ),
                            
// //                             // Share
// //                             ElevatedButton.icon(
// //                               onPressed: _shareVideo,
// //                               icon: const Icon(Icons.share),
// //                               label: const Text('Share'),
// //                               style: ElevatedButton.styleFrom(
// //                                 backgroundColor: Colors.pinkAccent,
// //                                 foregroundColor: Colors.white,
// //                               ),
// //                             ),
// //                           ],
// //                         ),
                        
// //                         const SizedBox(height: 16),
                        
// //                         // Record Again Button
// //                         ElevatedButton.icon(
// //                           onPressed: () {
// //                             setState(() {
// //                               _videoReady = false;
// //                               _finalVideoPath = null;
// //                               if (_videoController != null) {
// //                                 _videoController!.pause();
// //                               }
// //                             });
// //                             _videoController?.dispose();
// //                             _videoController = null;
// //                           },
// //                           icon: const Icon(Icons.refresh),
// //                           label: const Text('Record Again'),
// //                           style: ElevatedButton.styleFrom(
// //                             backgroundColor: Colors.white.withOpacity(0.3),
// //                             foregroundColor: Colors.white,
// //                             minimumSize: const Size(double.infinity, 48),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
                  
// //                   const SizedBox(height: 20),
// //                 ],

// //                 /// Record Button (only when not showing video)
// //                 if (!_videoReady) ...[
// //                   GestureDetector(
// //                     onTap: _isRecording || _isProcessingVideo
// //                         ? null
// //                         : _startRecording,
// //                     child: Container(
// //                       width: 70,
// //                       height: 70,
// //                       decoration: BoxDecoration(
// //                         shape: BoxShape.circle,
// //                         color: _isRecording ? Colors.red : Colors.white,
// //                         border: Border.all(color: Colors.white, width: 4),
// //                         boxShadow: [
// //                           BoxShadow(
// //                             color: (_isRecording ? Colors.red : Colors.pinkAccent)
// //                                 .withOpacity(0.5),
// //                             blurRadius: 15,
// //                             spreadRadius: 2,
// //                           ),
// //                         ],
// //                       ),
// //                       child: _isRecording
// //                           ? const Icon(Icons.stop, color: Colors.white, size: 32)
// //                           : const Icon(
// //                               Icons.fiber_manual_record,
// //                               color: Colors.red,
// //                               size: 32,
// //                             ),
// //                     ),
// //                   ),

// //                   const SizedBox(height: 20),

// //                   /// Effects Selector
// //                   SizedBox(
// //                     height: 100,
// //                     child: ListView.builder(
// //                       scrollDirection: Axis.horizontal,
// //                       padding: const EdgeInsets.symmetric(horizontal: 16),
// //                       itemCount: effects.length,
// //                       itemBuilder: (_, i) {
// //                         final selected = _selectedEffect == i;
// //                         return GestureDetector(
// //                           onTap: () => setState(() => _selectedEffect = i),
// //                           child: Column(
// //                             children: [
// //                               Container(
// //                                 margin: const EdgeInsets.symmetric(horizontal: 8),
// //                                 width: 60,
// //                                 height: 60,
// //                                 decoration: BoxDecoration(
// //                                   shape: BoxShape.circle,
// //                                   color: selected
// //                                       ? Colors.pinkAccent
// //                                       : Colors.white30,
// //                                   boxShadow: selected
// //                                       ? [
// //                                           BoxShadow(
// //                                             color: Colors.pinkAccent
// //                                                 .withOpacity(0.5),
// //                                             blurRadius: 15,
// //                                             spreadRadius: 2,
// //                                           ),
// //                                         ]
// //                                       : null,
// //                                 ),
// //                                 child: Icon(
// //                                   effects[i].icon,
// //                                   color: Colors.white,
// //                                   size: 28,
// //                                 ),
// //                               ),
// //                               const SizedBox(height: 8),
// //                               Text(
// //                                 effects[i].name,
// //                                 style: TextStyle(
// //                                   color: selected
// //                                       ? Colors.pinkAccent
// //                                       : Colors.white70,
// //                                   fontSize: 11,
// //                                   fontWeight: selected
// //                                       ? FontWeight.bold
// //                                       : FontWeight.normal,
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         );
// //                       },
// //                     ),
// //                   ),
// //                 ],
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // /// ================= PREVIEW EFFECTS PAINTER =================
// // class EffectsPainter extends CustomPainter {
// //   final double progress;
// //   final String effect;
// //   final Random random = Random(42);

// //   EffectsPainter({
// //     required this.progress,
// //     required this.effect,
// //   });

// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     switch (effect) {
// //       case 'hearts':
// //         _drawHearts(canvas, size);
// //         break;
// //       case 'rain':
// //         _drawRain(canvas, size);
// //         break;
// //       case 'rainbow':
// //         _drawRainbow(canvas, size);
// //         break;
// //       case 'flowers':
// //         _drawFlowers(canvas, size);
// //         break;
// //       case 'stars':
// //         _drawStars(canvas, size);
// //         break;
// //       case 'sparkles':
// //         _drawSparkles(canvas, size);
// //         break;
// //     }
// //   }

// //   void _drawHearts(Canvas canvas, Size size) {
// //     for (int i = 0; i < 25; i++) {
// //       final x = random.nextDouble() * size.width;
// //       final baseY = random.nextDouble() * size.height;
// //       final y = (baseY - progress * 200) % size.height;
// //       final opacity = (1 - (y / size.height)) * 0.6;

// //       // Draw heart shape
// //       final path = Path();
// //       final heartSize = random.nextDouble() * 15 + 10;
// //       path.moveTo(x, y + heartSize * 0.3);
// //       path.cubicTo(
// //         x - heartSize * 0.5,
// //         y - heartSize * 0.3,
// //         x - heartSize,
// //         y + heartSize * 0.3,
// //         x,
// //         y + heartSize,
// //       );
// //       path.cubicTo(
// //         x + heartSize,
// //         y + heartSize * 0.3,
// //         x + heartSize * 0.5,
// //         y - heartSize * 0.3,
// //         x,
// //         y + heartSize * 0.3,
// //       );

// //       canvas.drawPath(
// //         path,
// //         Paint()
// //           ..color = Colors.pinkAccent.withOpacity(opacity)
// //           ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2),
// //       );
// //     }
// //   }

// //   void _drawRain(Canvas canvas, Size size) {
// //     for (int i = 0; i < 120; i++) {
// //       final x = random.nextDouble() * size.width;
// //       final y = (progress * size.height * 2 + i * 30) % size.height;

// //       canvas.drawLine(
// //         Offset(x, y),
// //         Offset(x, y + 12),
// //         Paint()
// //           ..color = Colors.lightBlueAccent.withOpacity(0.6)
// //           ..strokeWidth = 2,
// //       );
// //     }
// //   }

// //   void _drawRainbow(Canvas canvas, Size size) {
// //     final rect = Offset.zero & size;
// //     canvas.drawRect(
// //       rect,
// //       Paint()
// //         ..shader = LinearGradient(
// //           colors: [
// //             Colors.red.withOpacity(0.3),
// //             Colors.orange.withOpacity(0.3),
// //             Colors.yellow.withOpacity(0.3),
// //             Colors.green.withOpacity(0.3),
// //             Colors.blue.withOpacity(0.3),
// //             Colors.purple.withOpacity(0.3),
// //           ],
// //         ).createShader(rect),
// //     );
// //   }

// //   void _drawFlowers(Canvas canvas, Size size) {
// //     for (int i = 0; i < 20; i++) {
// //       final x = random.nextDouble() * size.width;
// //       final baseY = random.nextDouble() * size.height;
// //       final y = (baseY - progress * 150) % size.height;
// //       final opacity = (1 - (y / size.height)) * 0.5;

// //       for (int p = 0; p < 5; p++) {
// //         final angle = (p * 2 * pi) / 5;
// //         canvas.drawCircle(
// //           Offset(x + cos(angle) * 10, y + sin(angle) * 10),
// //           4,
// //           Paint()..color = Colors.purpleAccent.withOpacity(opacity),
// //         );
// //       }
      
// //       // Center
// //       canvas.drawCircle(
// //         Offset(x, y),
// //         3,
// //         Paint()..color = Colors.yellowAccent.withOpacity(opacity),
// //       );
// //     }
// //   }

// //   void _drawStars(Canvas canvas, Size size) {
// //     for (int i = 0; i < 30; i++) {
// //       final x = random.nextDouble() * size.width;
// //       final y = random.nextDouble() * size.height;
// //       final twinkle = sin(progress * 2 * pi + i);
// //       final opacity = ((twinkle + 1) / 2) * 0.7;

// //       // Draw star
// //       final path = Path();
// //       final starSize = random.nextDouble() * 8 + 5;
// //       for (int p = 0; p < 5; p++) {
// //         final angle = (p * 4 * pi) / 5 - pi / 2;
// //         final radius = p % 2 == 0 ? starSize : starSize / 2;
// //         if (p == 0) {
// //           path.moveTo(x + cos(angle) * radius, y + sin(angle) * radius);
// //         } else {
// //           path.lineTo(x + cos(angle) * radius, y + sin(angle) * radius);
// //         }
// //       }
// //       path.close();

// //       canvas.drawPath(
// //         path,
// //         Paint()
// //           ..color = Colors.yellowAccent.withOpacity(opacity)
// //           ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
// //       );
// //     }
// //   }

// //   void _drawSparkles(Canvas canvas, Size size) {
// //     for (int i = 0; i < 40; i++) {
// //       final x = random.nextDouble() * size.width;
// //       final y = random.nextDouble() * size.height;
// //       final sparkle = sin(progress * 4 * pi + i * 0.5);
// //       final opacity = ((sparkle + 1) / 2) * 0.8;
// //       final sparkleSize = (sparkle + 1) * 2 + 2;

// //       // Cross sparkle
// //       canvas.drawLine(
// //         Offset(x - sparkleSize, y),
// //         Offset(x + sparkleSize, y),
// //         Paint()
// //           ..color = Colors.white.withOpacity(opacity)
// //           ..strokeWidth = 2
// //           ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2),
// //       );
      
// //       canvas.drawLine(
// //         Offset(x, y - sparkleSize),
// //         Offset(x, y + sparkleSize),
// //         Paint()
// //           ..color = Colors.white.withOpacity(opacity)
// //           ..strokeWidth = 2
// //           ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2),
// //       );
// //     }
// //   }

// //   @override
// //   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// // }




























// ///////////////////////////////////////////////////////




// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:gal/gal.dart';

// // Import the models from the main file
// import 'camera_video_effects_screen.dart';

// class VideoPreviewScreen extends StatefulWidget {
//   final String videoPath;
//   final AudioItem? audioItem;
//   final EffectItem? effectItem;
  
//   const VideoPreviewScreen({
//     super.key,
//     required this.videoPath,
//     this.audioItem,
//     this.effectItem,
//   });

//   @override
//   State<VideoPreviewScreen> createState() => _VideoPreviewScreenState();
// }

// class _VideoPreviewScreenState extends State<VideoPreviewScreen> {
//   late VideoPlayerController _videoController;
//   bool _isPlaying = true;
//   bool _isLoading = true;
//   bool _showControls = true;
//   bool _isSaving = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializeVideoPlayer();
    
//     Future.delayed(const Duration(seconds: 3), () {
//       if (mounted && _isPlaying) {
//         setState(() => _showControls = false);
//       }
//     });
//   }

//   Future<void> _initializeVideoPlayer() async {
//     try {
//       _videoController = VideoPlayerController.file(File(widget.videoPath));
//       await _videoController.initialize();
//       await _videoController.setLooping(true);
//       await _videoController.play();
      
//       setState(() {
//         _isLoading = false;
//       });
//     } catch (e) {
//       print('Video player error: $e');
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to load video: $e'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     }
//   }

//   Future<void> _togglePlayPause() async {
//     setState(() {
//       _showControls = true;
//     });
    
//     if (_videoController.value.isPlaying) {
//       await _videoController.pause();
//       setState(() => _isPlaying = false);
//     } else {
//       await _videoController.play();
//       setState(() => _isPlaying = true);
      
//       Future.delayed(const Duration(seconds: 3), () {
//         if (mounted && _isPlaying) {
//           setState(() => _showControls = false);
//         }
//       });
//     }
//   }

//   Future<void> _saveToGallery() async {
//     setState(() => _isSaving = true);
    
//     try {
//       final status = await Permission.storage.request();
//       if (!status.isGranted) {
//         throw Exception('Storage permission denied');
//       }
      
//       await Gal.putVideo(
//         widget.videoPath,
//         album: "Camera Effects",
//       );
      
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Video saved to Gallery! 🎉'),
//             backgroundColor: Colors.green,
//             duration: Duration(seconds: 2),
//           ),
//         );
//       }
//     } catch (e) {
//       print('Save error: $e');
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to save: $e'),
//             backgroundColor: Colors.red,
//             duration: const Duration(seconds: 2),
//           ),
//         );
//       }
//     } finally {
//       setState(() => _isSaving = false);
//     }
//   }

//   Future<void> _shareVideo() async {
//     try {
//       await Share.shareXFiles(
//         [XFile(widget.videoPath)],
//         text: '✨ Created with Flutter Camera Effects 🎬🎵',
//       );
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Error sharing: $e'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _videoController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             /// Video Player (Full Screen)
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _showControls = !_showControls;
//                 });
                
//                 if (_isPlaying) {
//                   Future.delayed(const Duration(seconds: 3), () {
//                     if (mounted && _isPlaying) {
//                       setState(() => _showControls = false);
//                     }
//                   });
//                 }
//               },
//               child: Center(
//                 child: _isLoading
//                     ? Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const CircularProgressIndicator(color: Colors.pinkAccent),
//                           const SizedBox(height: 16),
//                           const Text(
//                             'Loading video...',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           const SizedBox(height: 8),
//                           if (widget.effectItem != null)
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   widget.effectItem!.icon,
//                                   color: widget.effectItem!.color,
//                                   size: 20,
//                                 ),
//                                 const SizedBox(width: 8),
//                                 Text(
//                                   'With ${widget.effectItem!.name} effects',
//                                   style: TextStyle(
//                                     color: widget.effectItem!.color,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                         ],
//                       )
//                     : AspectRatio(
//                         aspectRatio: _videoController.value.aspectRatio,
//                         child: VideoPlayer(_videoController),
//                       ),
//               ),
//             ),

//             /// Back Button
//             Positioned(
//               top: 16,
//               left: 16,
//               child: GestureDetector(
//                 onTap: () => Navigator.pop(context),
//                 child: Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: Colors.black54,
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(
//                     Icons.arrow_back,
//                     color: Colors.white,
//                     size: 24,
//                   ),
//                 ),
//               ),
//             ),

//             /// Effects & Audio Info
//             if (_showControls && (widget.audioItem != null || widget.effectItem != null))
//               Positioned(
//                 top: 16,
//                 left: 0,
//                 right: 0,
//                 child: Column(
//                   children: [
//                     if (widget.effectItem != null)
//                       Container(
//                         margin: const EdgeInsets.only(bottom: 8),
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 8,
//                         ),
//                         decoration: BoxDecoration(
//                           color: widget.effectItem!.color.withOpacity(0.8),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Icon(
//                               widget.effectItem!.icon,
//                               color: Colors.white,
//                               size: 18,
//                             ),
//                             const SizedBox(width: 8),
//                             Text(
//                               widget.effectItem!.name,
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
                    
//                     if (widget.audioItem != null)
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 8,
//                         ),
//                         decoration: BoxDecoration(
//                           color: widget.audioItem!.color.withOpacity(0.8),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Icon(
//                               widget.audioItem!.icon,
//                               color: Colors.white,
//                               size: 18,
//                             ),
//                             const SizedBox(width: 8),
//                             Text(
//                               widget.audioItem!.name,
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                   ],
//                 ),
//               ),

//             /// Controls Overlay
//             if (_showControls)
//               Positioned(
//                 bottom: 0,
//                 left: 0,
//                 right: 0,
//                 child: Container(
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.bottomCenter,
//                       end: Alignment.topCenter,
//                       colors: [
//                         Colors.black.withOpacity(0.9),
//                         Colors.black.withOpacity(0.5),
//                         Colors.transparent,
//                       ],
//                     ),
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           IconButton(
//                             onPressed: () async {
//                               final position = await _videoController.position;
//                               await _videoController.seekTo(
//                                 Duration(
//                                   seconds: (position!.inSeconds - 10).clamp(0, _videoController.value.duration.inSeconds),
//                                 ),
//                               );
//                             },
//                             icon: const Icon(
//                               Icons.replay_10,
//                               color: Colors.white,
//                               size: 32,
//                             ),
//                           ),
                          
//                           const SizedBox(width: 20),
                          
//                           IconButton(
//                             onPressed: _togglePlayPause,
//                             icon: Icon(
//                               _isPlaying
//                                   ? Icons.pause_circle_filled
//                                   : Icons.play_circle_filled,
//                               color: Colors.white,
//                               size: 56,
//                             ),
//                           ),
                          
//                           const SizedBox(width: 20),
                          
//                           IconButton(
//                             onPressed: () async {
//                               final position = await _videoController.position;
//                               await _videoController.seekTo(
//                                 Duration(
//                                   seconds: (position!.inSeconds + 10).clamp(0, _videoController.value.duration.inSeconds),
//                                 ),
//                               );
//                             },
//                             icon: const Icon(
//                               Icons.forward_10,
//                               color: Colors.white,
//                               size: 32,
//                             ),
//                           ),
//                         ],
//                       ),
                      
//                       const SizedBox(height: 20),
                      
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           ElevatedButton.icon(
//                             onPressed: _isSaving ? null : _saveToGallery,
//                             icon: _isSaving
//                                 ? const SizedBox(
//                                     width: 16,
//                                     height: 16,
//                                     child: CircularProgressIndicator(
//                                       strokeWidth: 2,
//                                       color: Colors.white,
//                                     ),
//                                   )
//                                 : const Icon(Icons.download),
//                             label: Text(_isSaving ? 'Saving...' : 'Save'),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.green,
//                               foregroundColor: Colors.white,
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 20,
//                                 vertical: 12,
//                               ),
//                             ),
//                           ),
                          
//                           ElevatedButton.icon(
//                             onPressed: _shareVideo,
//                             icon: const Icon(Icons.share),
//                             label: const Text('Share'),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.pinkAccent,
//                               foregroundColor: Colors.white,
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 20,
//                                 vertical: 12,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
                      
//                       const SizedBox(height: 10),
                      
//                       ElevatedButton.icon(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         icon: const Icon(Icons.refresh),
//                         label: const Text('Record Again'),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white.withOpacity(0.2),
//                           foregroundColor: Colors.white,
//                           minimumSize: const Size(double.infinity, 48),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//             /// Play/Pause Overlay
//             if (!_showControls && !_isPlaying)
//               Center(
//                 child: GestureDetector(
//                   onTap: _togglePlayPause,
//                   child: Container(
//                     padding: const EdgeInsets.all(24),
//                     decoration: BoxDecoration(
//                       color: Colors.black54,
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(
//                       Icons.play_arrow,
//                       color: Colors.white,
//                       size: 48,
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }












// import 'dart:io';
// import 'dart:math';
// import 'package:dating_app/views/home/video_preview_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:ffmpeg_kit_flutter_new_min_gpl/ffmpeg_kit.dart';
// import 'package:ffmpeg_kit_flutter_new_min_gpl/return_code.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter/services.dart';

// /// ================= AUDIO MODEL =================
// class AudioItem {
//   final String id;
//   final String name;
//   final String assetPath;
//   final IconData icon;
//   final Color color;
//   final int durationSeconds;

//   const AudioItem({
//     required this.id,
//     required this.name,
//     required this.assetPath,
//     required this.icon,
//     this.color = Colors.purple,
//     this.durationSeconds = 5,
//   });
// }

// /// ================= EFFECT MODEL =================
// class EffectItem {
//   final String name;
//   final String type;
//   final IconData icon;
//   final Color color;
//   const EffectItem({
//     required this.name,
//     required this.type,
//     required this.icon,
//     this.color = Colors.pinkAccent,
//   });
// }

// /// ================= MAIN SCREEN =================
// class CameraVideoEffectsScreen extends StatefulWidget {
//   const CameraVideoEffectsScreen({super.key});

//   @override
//   State<CameraVideoEffectsScreen> createState() => _CameraVideoEffectsScreenState();
// }

// class _CameraVideoEffectsScreenState extends State<CameraVideoEffectsScreen>
//     with SingleTickerProviderStateMixin {
//   CameraController? _cameraController;
//   bool _cameraReady = false;
//   bool _cameraInitialized = false;
//   late AnimationController _animationController;
//   int _selectedEffect = 0;
//   bool _isRecording = false;
//   XFile? _recordedFile;
  
//   // Audio section
//   AudioItem? _selectedAudio;
//   bool _isProcessingVideo = false;

//   final List<EffectItem> effects = [
//     EffectItem(name: 'Hearts', type: 'hearts', icon: Icons.favorite, color: Colors.pinkAccent),
//     EffectItem(name: 'Rain', type: 'rain', icon: Icons.water_drop, color: Colors.lightBlueAccent),
//     EffectItem(name: 'Rainbow', type: 'rainbow', icon: Icons.gradient, color: Colors.deepPurpleAccent),
//     EffectItem(name: 'Flowers', type: 'flowers', icon: Icons.local_florist, color: Colors.purpleAccent),
//     EffectItem(name: 'Stars', type: 'stars', icon: Icons.star, color: Colors.yellowAccent),
//     EffectItem(name: 'Sparkles', type: 'sparkles', icon: Icons.auto_awesome, color: Colors.white),
//   ];

//   // Audio Library
//   final List<AudioItem> audioLibrary = const [
//     AudioItem(
//       id: 'audio_1',
//       name: 'Happy Vibe',
//       assetPath: 'assets/sounds/outgoing.mp3',
//       icon: Icons.music_note,
//       color: Colors.orange,
//       durationSeconds: 5,
//     ),
//     AudioItem(
//       id: 'audio_2',
//       name: 'Chill Beat',
//       assetPath: 'assets/sounds/outgoing.mp3',
//       icon: Icons.music_note,
//       color: Colors.blue,
//       durationSeconds: 5,
//     ),
//     AudioItem(
//       id: 'audio_3',
//       name: 'Upbeat',
//       assetPath: 'assets/sounds/outgoing.mp3',
//       icon: Icons.music_note,
//       color: Colors.green,
//       durationSeconds: 5,
//     ),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _initCamera();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 3),
//     );
//     // Start animation after a small delay to ensure widget is mounted
//     Future.delayed(const Duration(milliseconds: 100), () {
//       if (mounted) {
//         _animationController.repeat();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     // Stop animation before disposing
//     if (_animationController.isAnimating) {
//       _animationController.stop();
//     }
//     _animationController.dispose();
//     _cameraController?.dispose();
//     super.dispose();
//   }

//   /// ---------- INIT FRONT CAMERA ----------
//   Future<void> _initCamera() async {
//     try {
//       final cameraStatus = await Permission.camera.request();
//       final microphoneStatus = await Permission.microphone.request();
      
//       if (!cameraStatus.isGranted || !microphoneStatus.isGranted) {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Camera and microphone permissions are required'),
//               backgroundColor: Colors.red,
//             ),
//           );
//         }
//         return;
//       }

//       final cameras = await availableCameras();
      
//       if (cameras.isEmpty) {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('No camera found'),
//               backgroundColor: Colors.red,
//             ),
//           );
//         }
//         return;
//       }
      
//       final frontCamera = cameras.firstWhere(
//         (c) => c.lensDirection == CameraLensDirection.front,
//         orElse: () => cameras.first,
//       );
      
//       _cameraController = CameraController(
//         frontCamera,
//         ResolutionPreset.medium,
//         enableAudio: true,
//         imageFormatGroup: ImageFormatGroup.yuv420,
//       );
      
//       await _cameraController!.initialize();
      
//       if (!mounted) return;
      
//       setState(() {
//         _cameraReady = true;
//         _cameraInitialized = true;
//       });
//     } catch (e) {
//       print('Camera initialization error: $e');
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Camera error: $e'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     }
//   }

//   /// ---------- SHOW AUDIO LIBRARY ----------
//   Future<void> _showAudioLibrary() async {
//     final selected = await showModalBottomSheet<AudioItem>(
//       context: context,
//       backgroundColor: Colors.transparent,
//       builder: (context) => Container(
//         height: MediaQuery.of(context).size.height * 0.6,
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: Column(
//           children: [
//             Container(
//               width: 40,
//               height: 4,
//               margin: const EdgeInsets.only(top: 12, bottom: 8),
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),
            
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Row(
//                 children: [
//                   Icon(Icons.library_music, color: Colors.deepPurple, size: 28),
//                   const SizedBox(width: 12),
//                   const Text(
//                     'Audio Library',
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             Expanded(
//               child: ListView.builder(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 itemCount: audioLibrary.length,
//                 itemBuilder: (context, index) {
//                   final audio = audioLibrary[index];
//                   final isSelected = _selectedAudio?.id == audio.id;
                  
//                   return Container(
//                     margin: const EdgeInsets.only(bottom: 12),
//                     decoration: BoxDecoration(
//                       gradient: isSelected
//                           ? LinearGradient(
//                               colors: [
//                                 audio.color.withOpacity(0.2),
//                                 audio.color.withOpacity(0.1),
//                               ],
//                             )
//                           : null,
//                       border: Border.all(
//                         color: isSelected ? audio.color : Colors.grey.shade300,
//                         width: isSelected ? 2 : 1,
//                       ),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: ListTile(
//                       leading: Container(
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: audio.color.withOpacity(0.2),
//                           shape: BoxShape.circle,
//                         ),
//                         child: Icon(
//                           audio.icon,
//                           color: audio.color,
//                           size: 24,
//                         ),
//                       ),
//                       title: Text(
//                         audio.name,
//                         style: TextStyle(
//                           fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
//                           fontSize: 16,
//                         ),
//                       ),
//                       subtitle: Text(
//                         '${audio.durationSeconds}s duration',
//                         style: TextStyle(
//                           color: Colors.grey[600],
//                           fontSize: 12,
//                         ),
//                       ),
//                       trailing: isSelected
//                           ? Icon(Icons.check_circle, color: audio.color, size: 28)
//                           : Icon(Icons.circle_outlined, color: Colors.grey, size: 28),
//                       onTap: () {
//                         Navigator.pop(context, audio);
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),

//             if (_selectedAudio != null)
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: ElevatedButton.icon(
//                   onPressed: () {
//                     Navigator.pop(context, null);
//                   },
//                   icon: const Icon(Icons.clear),
//                   label: const Text('Clear Audio'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.grey[300],
//                     foregroundColor: Colors.black87,
//                     minimumSize: const Size(double.infinity, 50),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );

//     if (selected != null) {
//       setState(() {
//         _selectedAudio = selected;
//       });
      
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('🎵 Audio selected: ${selected.name}'),
//           backgroundColor: selected.color,
//           behavior: SnackBarBehavior.floating,
//           duration: const Duration(seconds: 2),
//         ),
//       );
//     } else if (selected == null && _selectedAudio != null) {
//       setState(() {
//         _selectedAudio = null;
//       });
      
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Audio cleared'),
//           backgroundColor: Colors.grey,
//           behavior: SnackBarBehavior.floating,
//           duration: Duration(seconds: 2),
//         ),
//       );
//     }
//   }

//   /// ---------- START RECORD ----------
//   Future<void> _startRecording() async {
//     if (_cameraController == null || _isRecording || !_cameraController!.value.isInitialized) return;

//     try {
//       // Stop animation during recording
//       if (_animationController.isAnimating) {
//         _animationController.stop();
//       }
      
//       await _cameraController!.startVideoRecording();
//       setState(() => _isRecording = true);

//       final duration = _selectedAudio?.durationSeconds ?? 5;
//       await Future.delayed(Duration(seconds: duration));
//       await _stopRecording();
//     } catch (e) {
//       print('Recording error: $e');
//       setState(() => _isRecording = false);
      
//       // Restart animation
//       if (mounted && !_animationController.isAnimating) {
//         _animationController.repeat();
//       }
      
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Recording failed: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   /// ---------- STOP RECORD ----------
//   Future<void> _stopRecording() async {
//     if (!_isRecording || _cameraController == null) return;

//     try {
//       final file = await _cameraController!.stopVideoRecording();
//       setState(() {
//         _isRecording = false;
//         _recordedFile = file;
//       });

//       // Process video (simpler version without complex effects generation)
//       await _processVideoSimple(file.path);
      
//     } catch (e) {
//       print('Stop recording error: $e');
//       setState(() => _isRecording = false);
      
//       // Restart animation
//       if (mounted && !_animationController.isAnimating) {
//         _animationController.repeat();
//       }
      
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to stop recording: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   /// ---------- SIMPLE VIDEO PROCESSING ----------
//   Future<void> _processVideoSimple(String videoPath) async {
//     setState(() => _isProcessingVideo = true);

//     try {
//       print("1️⃣ Starting simple video processing...");
      
//       final tempDir = await getTemporaryDirectory();
//       final outputPath = '${tempDir.path}/final_${DateTime.now().millisecondsSinceEpoch}.mp4';
      
//       if (_selectedAudio != null) {
//         // Get audio file from assets
//         final audioPath = await _getAudioPathFromAssets(_selectedAudio!.assetPath);
        
//         // Verify files exist
//         final videoFile = File(videoPath);
//         final audioFile = File(audioPath);
        
//         if (!await videoFile.exists() || !await audioFile.exists()) {
//           throw Exception("Video or audio file doesn't exist");
//         }
        
//         // Simple FFmpeg command to merge audio with video
//         final command = '''
//           -y 
//           -i "$videoPath" 
//           -i "$audioPath" 
//           -c:v copy 
//           -c:a aac 
//           -map 0:v:0 
//           -map 1:a:0 
//           -shortest 
//           "$outputPath"
//         '''.replaceAll('\n', ' ').replaceAll(RegExp(r'\s+'), ' ').trim();
        
//         print("2️⃣ Executing FFmpeg command: $command");
        
//         final session = await FFmpegKit.execute(command);
//         final returnCode = await session.getReturnCode();
        
//         if (ReturnCode.isSuccess(returnCode)) {
//           final outputFile = File(outputPath);
//           if (await outputFile.exists()) {
//             print("3️⃣ ✅ Success! Output file created");
            
//             // Navigate to preview screen
//             if (mounted) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => VideoPreviewScreen(
//                     videoPath: outputPath,
//                     audioItem: _selectedAudio,
//                     effectItem: effects[_selectedEffect],
//                   ),
//                 ),
//               );
//             }
//           } else {
//             throw Exception("Output file was not created");
//           }
//         } else {
//           throw Exception("FFmpeg failed");
//         }
//       } else {
//         // No audio, just use the original video
//         if (mounted) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => VideoPreviewScreen(
//                 videoPath: videoPath,
//                 audioItem: null,
//                 effectItem: effects[_selectedEffect],
//               ),
//             ),
//           );
//         }
//       }
//     } catch (e, stackTrace) {
//       print("❌ Error: $e");
//       print("Stack: $stackTrace");
      
//       // Restart animation
//       if (mounted && !_animationController.isAnimating) {
//         _animationController.repeat();
//       }
      
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Error: ${e.toString()}'),
//             backgroundColor: Colors.red,
//             duration: const Duration(seconds: 4),
//           ),
//         );
//       }
//     } finally {
//       if (mounted) {
//         setState(() => _isProcessingVideo = false);
//       }
//     }
//   }

//   /// ---------- GET AUDIO FROM ASSETS ----------
//   Future<String> _getAudioPathFromAssets(String assetPath) async {
//     try {
//       final tempDir = await getTemporaryDirectory();
//       final fileName = 'temp_audio_${DateTime.now().millisecondsSinceEpoch}.mp3';
//       final audioFile = File('${tempDir.path}/$fileName');
      
//       if (assetPath.startsWith('assets/')) {
//         // Load from assets
//         print("🔊 Loading audio from assets: $assetPath");
//         final byteData = await rootBundle.load(assetPath);
//         final buffer = byteData.buffer;
//         await audioFile.writeAsBytes(
//           buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes)
//         );
        
//         if (await audioFile.exists()) {
//           final fileSize = await audioFile.length();
//           print("✅ Audio file created: ${audioFile.path}, size: $fileSize bytes");
//         } else {
//           throw Exception("Audio file was not created from assets");
//         }
//       } else {
//         // Create silent audio as fallback
//         print("🎵 Creating silent audio");
//         final silentCmd = '-y -f lavfi -i anullsrc=r=44100:cl=stereo -t ${_selectedAudio!.durationSeconds} "${audioFile.path}"';
//         final session = await FFmpegKit.execute(silentCmd);
//         final returnCode = await session.getReturnCode();
        
//         if (!ReturnCode.isSuccess(returnCode)) {
//           throw Exception("Failed to create silent audio");
//         }
//       }
      
//       return audioFile.path;
//     } catch (e) {
//       print("❌ Audio loading error: $e");
//       rethrow;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!_cameraReady) {
//       return Scaffold(
//         backgroundColor: Colors.black,
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const CircularProgressIndicator(color: Colors.pinkAccent),
//               const SizedBox(height: 16),
//               Text(
//                 _cameraInitialized ? 'Camera Ready!' : 'Initializing Camera...',
//                 style: const TextStyle(color: Colors.white),
//               ),
//               if (!_cameraInitialized)
//                 const SizedBox(height: 16),
//               if (!_cameraInitialized)
//                 ElevatedButton(
//                   onPressed: _initCamera,
//                   child: const Text('Retry Camera'),
//                 ),
//             ],
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           /// Camera Preview
//           Positioned.fill(
//             child: _cameraController != null && _cameraController!.value.isInitialized
//                 ? CameraPreview(_cameraController!)
//                 : Container(
//                     color: Colors.black,
//                     child: const Center(
//                       child: Text(
//                         'Camera not available',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//           ),

//           /// Live Effects (Only visible during preview, not recording)
//           if (!_isRecording && !_isProcessingVideo)
//             AnimatedBuilder(
//               animation: _animationController,
//               builder: (_, __) {
//                 return CustomPaint(
//                   size: MediaQuery.of(context).size,
//                   painter: EffectsPainter(
//                     progress: _animationController.value,
//                     effect: effects[_selectedEffect].type,
//                   ),
//                 );
//               },
//             ),

//           /// Processing Overlay
//           if (_isProcessingVideo)
//             Container(
//               color: Colors.black87,
//               child: Center(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const CircularProgressIndicator(color: Colors.pinkAccent),
//                     const SizedBox(height: 16),
//                     Text(
//                       'Processing video...',
//                       style: const TextStyle(color: Colors.white, fontSize: 16),
//                     ),
//                     if (_selectedAudio != null)
//                       Text(
//                         'with ${_selectedAudio!.name}',
//                         style: const TextStyle(color: Colors.white70, fontSize: 14),
//                       ),
//                   ],
//                 ),
//               ),
//             ),

//           /// Top Bar
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'Live Camera Effects',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       shadows: [
//                         Shadow(color: Colors.black54, blurRadius: 10),
//                       ],
//                     ),
//                   ),
                  
//                   // Audio Button
//                   GestureDetector(
//                     onTap: _showAudioLibrary,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 8,
//                       ),
//                       decoration: BoxDecoration(
//                         color: _selectedAudio != null
//                             ? _selectedAudio!.color
//                             : Colors.white.withOpacity(0.3),
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(
//                           color: Colors.white,
//                           width: 2,
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(
//                             _selectedAudio != null
//                                 ? _selectedAudio!.icon
//                                 : Icons.library_music,
//                             color: Colors.white,
//                             size: 20,
//                           ),
//                           const SizedBox(width: 8),
//                           Text(
//                             _selectedAudio?.name ?? 'Add Audio',
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 14,
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

//           /// Bottom Controls
//           Positioned(
//             bottom: 40,
//             left: 0,
//             right: 0,
//             child: Column(
//               children: [
//                 /// Record Button
//                 GestureDetector(
//                   onTap: _isRecording || _isProcessingVideo
//                       ? null
//                       : _startRecording,
//                   child: Container(
//                     width: 70,
//                     height: 70,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: _isRecording ? Colors.red : Colors.white,
//                       border: Border.all(color: Colors.white, width: 4),
//                       boxShadow: [
//                         BoxShadow(
//                           color: (_isRecording ? Colors.red : effects[_selectedEffect].color)
//                               .withOpacity(0.5),
//                           blurRadius: 15,
//                           spreadRadius: 2,
//                         ),
//                       ],
//                     ),
//                     child: _isRecording
//                         ? const Icon(Icons.stop, color: Colors.white, size: 32)
//                         : const Icon(
//                             Icons.fiber_manual_record,
//                             color: Colors.red,
//                             size: 32,
//                           ),
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 /// Effects Selector
//                 SizedBox(
//                   height: 100,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     itemCount: effects.length,
//                     itemBuilder: (_, i) {
//                       final selected = _selectedEffect == i;
//                       return GestureDetector(
//                         onTap: () => setState(() => _selectedEffect = i),
//                         child: Column(
//                           children: [
//                             Container(
//                               margin: const EdgeInsets.symmetric(horizontal: 8),
//                               width: 60,
//                               height: 60,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: selected
//                                     ? effects[i].color
//                                     : Colors.white30,
//                                 boxShadow: selected
//                                     ? [
//                                         BoxShadow(
//                                           color: effects[i].color
//                                               .withOpacity(0.5),
//                                           blurRadius: 15,
//                                           spreadRadius: 2,
//                                         ),
//                                       ]
//                                     : null,
//                               ),
//                               child: Icon(
//                                 effects[i].icon,
//                                 color: Colors.white,
//                                 size: 28,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               effects[i].name,
//                               style: TextStyle(
//                                 color: selected
//                                     ? effects[i].color
//                                     : Colors.white70,
//                                 fontSize: 11,
//                                 fontWeight: selected
//                                     ? FontWeight.bold
//                                     : FontWeight.normal,
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// /// ================= EFFECTS PAINTER FOR PREVIEW =================
// class EffectsPainter extends CustomPainter {
//   final double progress;
//   final String effect;
//   final Random random = Random(42);

//   EffectsPainter({
//     required this.progress,
//     required this.effect,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     switch (effect) {
//       case 'hearts':
//         _drawHearts(canvas, size);
//         break;
//       case 'rain':
//         _drawRain(canvas, size);
//         break;
//       case 'rainbow':
//         _drawRainbow(canvas, size);
//         break;
//       case 'flowers':
//         _drawFlowers(canvas, size);
//         break;
//       case 'stars':
//         _drawStars(canvas, size);
//         break;
//       case 'sparkles':
//         _drawSparkles(canvas, size);
//         break;
//       default:
//         // No effect
//         break;
//     }
//   }

//   void _drawHearts(Canvas canvas, Size size) {
//     for (int i = 0; i < 15; i++) {
//       final x = random.nextDouble() * size.width;
//       final baseY = random.nextDouble() * size.height;
//       final y = (baseY - progress * 200) % size.height;
//       final opacity = (1 - (y / size.height)) * 0.6;

//       final path = Path();
//       final heartSize = random.nextDouble() * 10 + 8;
//       path.moveTo(x, y + heartSize * 0.3);
//       path.cubicTo(
//         x - heartSize * 0.5,
//         y - heartSize * 0.3,
//         x - heartSize,
//         y + heartSize * 0.3,
//         x,
//         y + heartSize,
//       );
//       path.cubicTo(
//         x + heartSize,
//         y + heartSize * 0.3,
//         x + heartSize * 0.5,
//         y - heartSize * 0.3,
//         x,
//         y + heartSize * 0.3,
//       );

//       canvas.drawPath(
//         path,
//         Paint()
//           ..color = Colors.pinkAccent.withOpacity(opacity)
//           ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2),
//       );
//     }
//   }

//   void _drawRain(Canvas canvas, Size size) {
//     for (int i = 0; i < 80; i++) {
//       final x = random.nextDouble() * size.width;
//       final y = (progress * size.height * 2 + i * 30) % size.height;

//       canvas.drawLine(
//         Offset(x, y),
//         Offset(x, y + 12),
//         Paint()
//           ..color = Colors.lightBlueAccent.withOpacity(0.6)
//           ..strokeWidth = 2,
//       );
//     }
//   }

//   void _drawRainbow(Canvas canvas, Size size) {
//     final rect = Offset.zero & size;
//     canvas.drawRect(
//       rect,
//       Paint()
//         ..shader = LinearGradient(
//           colors: [
//             Colors.red.withOpacity(0.2),
//             Colors.orange.withOpacity(0.2),
//             Colors.yellow.withOpacity(0.2),
//             Colors.green.withOpacity(0.2),
//             Colors.blue.withOpacity(0.2),
//             Colors.purple.withOpacity(0.2),
//           ],
//         ).createShader(rect),
//     );
//   }

//   void _drawFlowers(Canvas canvas, Size size) {
//     for (int i = 0; i < 15; i++) {
//       final x = random.nextDouble() * size.width;
//       final baseY = random.nextDouble() * size.height;
//       final y = (baseY - progress * 150) % size.height;
//       final opacity = (1 - (y / size.height)) * 0.5;

//       for (int p = 0; p < 5; p++) {
//         final angle = (p * 2 * pi) / 5;
//         canvas.drawCircle(
//           Offset(x + cos(angle) * 8, y + sin(angle) * 8),
//           3,
//           Paint()..color = Colors.purpleAccent.withOpacity(opacity),
//         );
//       }
      
//       canvas.drawCircle(
//         Offset(x, y),
//         2,
//         Paint()..color = Colors.yellowAccent.withOpacity(opacity),
//       );
//     }
//   }

//   void _drawStars(Canvas canvas, Size size) {
//     for (int i = 0; i < 20; i++) {
//       final x = random.nextDouble() * size.width;
//       final y = random.nextDouble() * size.height;
//       final twinkle = sin(progress * 2 * pi + i);
//       final opacity = ((twinkle + 1) / 2) * 0.7;

//       final path = Path();
//       final starSize = random.nextDouble() * 6 + 4;
//       for (int p = 0; p < 5; p++) {
//         final angle = (p * 4 * pi) / 5 - pi / 2;
//         final radius = p % 2 == 0 ? starSize : starSize / 2;
//         if (p == 0) {
//           path.moveTo(x + cos(angle) * radius, y + sin(angle) * radius);
//         } else {
//           path.lineTo(x + cos(angle) * radius, y + sin(angle) * radius);
//         }
//       }
//       path.close();

//       canvas.drawPath(
//         path,
//         Paint()
//           ..color = Colors.yellowAccent.withOpacity(opacity)
//           ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2),
//       );
//     }
//   }

//   void _drawSparkles(Canvas canvas, Size size) {
//     for (int i = 0; i < 30; i++) {
//       final x = random.nextDouble() * size.width;
//       final y = random.nextDouble() * size.height;
//       final sparkle = sin(progress * 4 * pi + i * 0.5);
//       final opacity = ((sparkle + 1) / 2) * 0.8;
//       final sparkleSize = (sparkle + 1) * 1.5 + 1.5;

//       canvas.drawLine(
//         Offset(x - sparkleSize, y),
//         Offset(x + sparkleSize, y),
//         Paint()
//           ..color = Colors.white.withOpacity(opacity)
//           ..strokeWidth = 2
//           ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.5),
//       );
      
//       canvas.drawLine(
//         Offset(x, y - sparkleSize),
//         Offset(x, y + sparkleSize),
//         Paint()
//           ..color = Colors.white.withOpacity(opacity)
//           ..strokeWidth = 2
//           ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.5),
//       );
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }