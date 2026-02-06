// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({super.key});

//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }

// class _SettingsScreenState extends State<SettingsScreen> {
//   PermissionStatus? _locationStatus;
//   bool _loadingPermission = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadLocationStatus();
//   }

//   /// 📍 LOAD LOCATION STATUS
//   Future<void> _loadLocationStatus() async {
//     final status = await Permission.location.status;
//     if (!mounted) return;
//     setState(() => _locationStatus = status);
//   }

//   /// 📍 STATUS TEXT
//   String get _statusText {
//     if (_locationStatus == null) return 'Checking...';
//     if (_locationStatus!.isGranted) return 'Allowed';
//     if (_locationStatus!.isPermanentlyDenied) return 'Permanently denied';
//     return 'Denied';
//   }

//   Color get _statusColor {
//     if (_locationStatus == null) return Colors.grey;
//     if (_locationStatus!.isGranted) return Colors.green;
//     if (_locationStatus!.isPermanentlyDenied) return Colors.red;
//     return Colors.orange;
//   }

//   /// ✅ ALLOW LOCATION
//   Future<void> _allowLocation() async {
//     setState(() => _loadingPermission = true);

//     final status = await Permission.location.request();

//     if (!mounted) return;
//     setState(() {
//       _locationStatus = status;
//       _loadingPermission = false;
//     });
//   }

//   /// ❌ DISABLE LOCATION (SYSTEM SETTINGS)
//   Future<void> _disableLocation() async {
//     await openAppSettings();
//     await _loadLocationStatus();
//   }

//   /// 🗑 DELETE CONFIRM
//   void _showDeleteConfirmDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         title: const Text("Delete Account?"),
//         content: const Text(
//           "This action is permanent and cannot be undone.",
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("Cancel"),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//             onPressed: () {
//               Navigator.pop(context);
//               _deleteAccount(context);
//             },
//             child: const Text("Delete"),
//           ),
//         ],
//       ),
//     );
//   }

//   /// 🔥 DELETE ACCOUNT API
//   Future<void> _deleteAccount(BuildContext context) async {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) => const Center(child: CircularProgressIndicator()),
//     );

//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final userId = prefs.getString('userId');

//       final response = await http.delete(
//         Uri.parse(
//           'http://31.97.206.144:4055/api/users/delete-account/$userId',
//         ),
//       );

//       Navigator.pop(context);

//       if (response.statusCode == 200) {
//         await prefs.clear();
//         Navigator.pushNamedAndRemoveUntil(
//           context,
//           '/login',
//           (route) => false,
//         );
//       } else {
//         throw Exception('Failed to delete account');
//       }
//     } catch (e) {
//       Navigator.pop(context);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(e.toString())),
//       );
//     }
//   }

//   /// 🚪 LOGOUT
//   Future<void> _logout(BuildContext context) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//     Navigator.pushNamedAndRemoveUntil(
//       context,
//       '/login',
//       (route) => false,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffFFEFF5),
//       appBar: AppBar(
//         backgroundColor: const Color(0xffFFEFF5),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           "Settings",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//         ),
//       ),
//       body: Column(
//         children: [
//           const SizedBox(height: 20),

//           /// 📍 LOCATION ACCESS
//           Container(
//             margin: const EdgeInsets.symmetric(horizontal: 16),
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: Colors.black.withOpacity(0.1)),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Location Access",
//                   style: TextStyle(fontWeight: FontWeight.w600),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   _statusText,
//                   style: TextStyle(color: _statusColor),
//                 ),
//                 const SizedBox(height: 12),
//                 if (_loadingPermission)
//                   const Center(child: CircularProgressIndicator())
//                 else
//                   Row(
//                     children: [
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: _allowLocation,
//                           child: const Text("Allow"),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: OutlinedButton(
//                           onPressed: _disableLocation,
//                           child: const Text("Disable"),
//                         ),
//                       ),
//                     ],
//                   ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 20),

//           /// 🗑 DELETE ACCOUNT
//           GestureDetector(
//             onTap: () => _showDeleteConfirmDialog(context),
//             child: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 16),
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: Colors.black.withOpacity(0.1)),
//               ),
//               child: Row(
//                 children: const [
//                   Icon(Icons.delete_outline, color: Colors.red),
//                   SizedBox(width: 10),
//                   Text(
//                     "Delete Account Permanently",
//                     style: TextStyle(fontWeight: FontWeight.w500),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           const Spacer(),

//           /// 🚪 LOGOUT
//           Container(
//             margin: const EdgeInsets.only(bottom: 40),
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: SizedBox(
//               width: double.infinity,
//               height: 55,
//               child: OutlinedButton(
//                 style: OutlinedButton.styleFrom(
//                   side: const BorderSide(color: Color(0xFFFE0A62), width: 1.8),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(35),
//                   ),
//                 ),
//                 onPressed: () => _logout(context),
//                 child: const Text(
//                   "Logout",
//                   style: TextStyle(
//                     color: Color(0xFFFE0A62),
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


















import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  PermissionStatus? _locationStatus;
  PermissionStatus? _cameraStatus;

  bool _loadingLocation = false;
  bool _loadingCamera = false;

  @override
  void initState() {
    super.initState();
    _loadPermissions();
  }

  /// 🔄 LOAD PERMISSIONS
  Future<void> _loadPermissions() async {
    _locationStatus = await Permission.location.status;
    _cameraStatus = await Permission.camera.status;
    if (mounted) setState(() {});
  }

  /// 🟢 STATUS TEXT
  String _statusText(PermissionStatus? status) {
    if (status == null) return 'Checking...';
    if (status.isGranted) return 'Allowed';
    if (status.isPermanentlyDenied) return 'Permanently denied';
    return 'Denied';
  }

  Color _statusColor(PermissionStatus? status) {
    if (status == null) return Colors.grey;
    if (status.isGranted) return Colors.green;
    if (status.isPermanentlyDenied) return Colors.red;
    return Colors.orange;
  }

  /// 📍 LOCATION
  Future<void> _allowLocation() async {
    setState(() => _loadingLocation = true);
    _locationStatus = await Permission.location.request();
    setState(() => _loadingLocation = false);
  }

  Future<void> _disableLocation() async {
    await openAppSettings();
    _locationStatus = await Permission.location.status;
    setState(() {});
  }

  /// 📷 CAMERA
  Future<void> _allowCamera() async {
    setState(() => _loadingCamera = true);
    _cameraStatus = await Permission.camera.request();
    setState(() => _loadingCamera = false);
  }

  Future<void> _disableCamera() async {
    await openAppSettings();
    _cameraStatus = await Permission.camera.status;
    setState(() {});
  }

  /// 🗑 DELETE CONFIRM
  void _showDeleteConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Delete Account?"),
        content: const Text(
          "This action is permanent and cannot be undone.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              _deleteAccount(context);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  /// 🔥 DELETE ACCOUNT
  Future<void> _deleteAccount(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');

      final response = await http.delete(
        Uri.parse('http://31.97.206.144:4055/api/users/delete-account/$userId'),
      );

      Navigator.pop(context);

      if (response.statusCode == 200) {
        await prefs.clear();
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/login',
          (route) => false,
        );
      } else {
        throw Exception('Failed to delete account');
      }
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  /// 🚪 LOGOUT
  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
      (route) => false,
    );
  }

  /// 🧩 PERMISSION TILE
  Widget _permissionTile({
    required String title,
    required PermissionStatus? status,
    required bool loading,
    required VoidCallback onAllow,
    required VoidCallback onDisable,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(
            _statusText(status),
            style: TextStyle(color: _statusColor(status)),
          ),
          const SizedBox(height: 12),
          if (loading)
            const Center(child: CircularProgressIndicator())
          else
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onAllow,
                    child: const Text("Allow"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: onDisable,
                    child: const Text("Disable"),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFEFF5),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFEFF5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Settings",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          /// 📍 LOCATION
          _permissionTile(
            title: "Location Access",
            status: _locationStatus,
            loading: _loadingLocation,
            onAllow: _allowLocation,
            onDisable: _disableLocation,
          ),

          const SizedBox(height: 20),

          /// 📷 CAMERA
          _permissionTile(
            title: "Camera Access",
            status: _cameraStatus,
            loading: _loadingCamera,
            onAllow: _allowCamera,
            onDisable: _disableCamera,
          ),

          const SizedBox(height: 20),

          /// 🗑 DELETE ACCOUNT
          GestureDetector(
            onTap: () => _showDeleteConfirmDialog(context),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black.withOpacity(0.1)),
              ),
              child: Row(
                children: const [
                  Icon(Icons.delete_outline, color: Colors.red),
                  SizedBox(width: 10),
                  Text(
                    "Delete Account Permanently",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),

          const Spacer(),

          /// 🚪 LOGOUT
          Container(
            margin: const EdgeInsets.only(bottom: 40),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side:
                      const BorderSide(color: Color(0xFFFE0A62), width: 1.8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),
                onPressed: () => _logout(context),
                child: const Text(
                  "Logout",
                  style: TextStyle(
                    color: Color(0xFFFE0A62),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
