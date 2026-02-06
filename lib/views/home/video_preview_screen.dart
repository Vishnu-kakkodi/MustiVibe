// import 'dart:io';
// import 'package:dating_app/views/home/connect_friends_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:gal/gal.dart';

// // Import the models from the main file

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