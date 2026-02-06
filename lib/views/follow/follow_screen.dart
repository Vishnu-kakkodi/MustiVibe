// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class FollowScreen extends StatelessWidget {
//   const FollowScreen({super.key});

//   final String userId = "692836f779b0889d7ae988f0";

//   Future<Map<String, dynamic>> fetchFollowData() async {
//     final response = await http.get(
//       Uri.parse(
//         "http://31.97.206.144:4055/api/users/followers-following/$userId",
//       ),
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception("Failed to load follow data");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<Map<String, dynamic>>(
//       future: fetchFollowData(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Scaffold(
//             backgroundColor: Color(0xffFFEFF5),
//             body: Center(child: CircularProgressIndicator()),
//           );
//         }

//         if (snapshot.hasError) {
//           return Scaffold(
//             backgroundColor: const Color(0xffFFEFF5),
//             body: Center(child: Text(snapshot.error.toString())),
//           );
//         }

//         final data = snapshot.data!;
//         final followers = data['followers'] as List;
//         final following = data['following'] as List;
//         final followersCount = data['followersCount'];
//         final followingCount = data['followingCount'];

//         return DefaultTabController(
//           length: 2,
//           child: Scaffold(
//             backgroundColor: const Color(0xffFFEFF5),
//             body: Column(
//               children: [
//                 const SizedBox(height: 50),

//                 /// TAB BAR (UNCHANGED UI)
//                 Container(
//                   height: 50,
//                   margin:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(30),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.05),
//                         blurRadius: 4,
//                       ),
//                     ],
//                   ),
//                   child: TabBar(
//                     indicatorSize: TabBarIndicatorSize.tab,
//                     dividerColor: Colors.transparent,
//                     labelPadding: EdgeInsets.zero,
//                     indicator: BoxDecoration(
//                       color: const Color(0xffFE0A62),
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     labelColor: Colors.white,
//                     unselectedLabelColor: Colors.black,
//                     tabs: [
//                       Tab(
//                         child: Text(
//                           "$followingCount Following",
//                           style: const TextStyle(
//                               fontWeight: FontWeight.w600, fontSize: 15),
//                         ),
//                       ),
//                       Tab(
//                         child: Text(
//                           "$followersCount Followers",
//                           style: const TextStyle(
//                               fontWeight: FontWeight.w600, fontSize: 15),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 10),

//                 Expanded(
//                   child: TabBarView(
//                     children: [
//                       _buildUserList(context, following),
//                       _buildUserList(context, followers),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   /// USER LIST (API DATA)
//   Widget _buildUserList(BuildContext context, List users) {
//     if (users.isEmpty) {
//       return const Center(child: Text("No users found"));
//     }

//     return ListView.builder(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       itemCount: users.length,
//       itemBuilder: (context, index) {
//         final user = users[index];

//         return InkWell(
//           onTap: () => _showProfilePopup(context, user),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//             margin: const EdgeInsets.only(bottom: 8),
//             color: Colors.white,
//             child: Row(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(50),
//                   child: Image.network(
//                     user['profileImage'] ?? '',
//                     width: 55,
//                     height: 55,
//                     fit: BoxFit.cover,
//                     errorBuilder: (_, __, ___) => const Icon(Icons.person),
//                   ),
//                 ),

//                 const SizedBox(width: 15),

//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       user['name'] ?? '',
//                       style: const TextStyle(
//                           fontSize: 17, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       user['language'] ?? '',
//                       style:
//                           const TextStyle(fontSize: 14, color: Colors.grey),
//                     ),
//                   ],
//                 ),

//                 const Spacer(),

//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: const Color(0xffF1F1F1),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Text(
//                     user['status'] ?? '',
//                     style:
//                         const TextStyle(fontSize: 13, color: Colors.grey),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   /// PROFILE POPUP (API DATA)
//   void _showProfilePopup(BuildContext context, Map user) {
//     showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (context) {
//         return Dialog(
//           backgroundColor: Colors.transparent,
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               Container(
//                 width: double.infinity,
//                 margin: const EdgeInsets.only(top: 50),
//                 padding: const EdgeInsets.symmetric(vertical: 25),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const SizedBox(height: 40),
//                     Text(
//                       user['name'] ?? '',
//                       style: const TextStyle(
//                           fontSize: 20, fontWeight: FontWeight.w700),
//                     ),
//                     const SizedBox(height: 20),

//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 35, vertical: 10),
//                       decoration: BoxDecoration(
//                         color: const Color(0xffFE0A62),
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: const Text(
//                         "Following",
//                         style:
//                             TextStyle(color: Colors.white, fontSize: 15),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               Positioned(
//                 top: 0,
//                 child: CircleAvatar(
//                   radius: 45,
//                   backgroundImage:
//                       NetworkImage(user['profileImage'] ?? ''),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }












import 'dart:convert';
import 'package:dating_app/providers/Follow/follow_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FollowScreen extends StatefulWidget {
  const FollowScreen({super.key});

  @override
  State<FollowScreen> createState() => _FollowScreenState();
}

class _FollowScreenState extends State<FollowScreen> {
  String? userId;
  late Future<Map<String, dynamic>> followFuture;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  /// LOAD USER ID FROM SHARED PREF
  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');

    if (userId != null && userId!.isNotEmpty) {
      setState(() {
        followFuture = fetchFollowData();
      });
    }
  }

  /// FETCH FOLLOW DATA
  Future<Map<String, dynamic>> fetchFollowData() async {
    final response = await http.get(
      Uri.parse(
        "http://31.97.206.144:4055/api/users/followers-following/$userId",
      ),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load follow data");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return const Scaffold(
        backgroundColor: Color(0xffFFEFF5),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return FutureBuilder<Map<String, dynamic>>(
      future: followFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Color(0xffFFEFF5),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: const Color(0xffFFEFF5),
            body: Center(child: Text(snapshot.error.toString())),
          );
        }

        final data = snapshot.data!;
        final followers = data['followers'] as List;
        final following = data['following'] as List;
        final followersCount = data['followersCount'];
        final followingCount = data['followingCount'];

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: const Color(0xffFFEFF5),
            body: Column(
              children: [
                const SizedBox(height: 50),

                /// TAB BAR
                Container(
                  height: 50,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: const Color(0xffFE0A62),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Tab(
                        child: Text(
                          "$followingCount Following",
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "$followersCount Followers",
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                Expanded(
                  child: TabBarView(
                    children: [
                      _buildUserList(context, following),
                      _buildUserList(context, followers),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// USER LIST
  Widget _buildUserList(BuildContext context, List users) {
    if (users.isEmpty) {
      return const Center(child: Text("No users found"));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];

        return InkWell(
         onTap: () => _showProfilePopup(
  context,
  user,
  onRefresh: () {
    setState(() {
      followFuture = fetchFollowData();
    });
  },
),

          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            margin: const EdgeInsets.only(bottom: 8),
            color: Colors.white,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    user['profileImage'] ?? '',
                    width: 55,
                    height: 55,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.person),
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['name'] ?? '',
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user['language'] ?? '',
                      style: const TextStyle(
                          fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xffF1F1F1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    user['status'] ?? '',
                    style: const TextStyle(
                        fontSize: 13, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// PROFILE POPUP
void _showProfilePopup(
  BuildContext context,
  Map user, {
  required VoidCallback onRefresh,
}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 55),
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// NAME
                  Text(
                    user['name'] ?? '',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// LOCATION (STATIC)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.location_on,
                          size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        "Hyderabad",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// FOLLOW COUNTS (STATIC 0 / 0)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _countItem("0", "Followers"),
                        Container(
                          height: 30,
                          width: 1,
                          color: Colors.grey.shade300,
                        ),
                        _countItem("0", "Following"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// FOLLOWING + UNFOLLOW BUTTONS
                  Consumer<FollowProvider>(
                    builder: (context, followProvider, _) {
                      return Column(
                        children: [
                          /// FOLLOWING (DISPLAY)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 35, vertical: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xffFE0A62)),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.check,
                                    size: 16,
                                    color: Color(0xffFE0A62)),
                                SizedBox(width: 6),
                                Text(
                                  "Following",
                                  style: TextStyle(
                                    color: Color(0xffFE0A62),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 12),

                          /// UNFOLLOW BUTTON
                          TextButton(
                            onPressed: followProvider.isLoading
                                ? null
                                : () async {
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    final currentUserId =
                                        prefs.getString('userId');

                                    if (currentUserId == null) return;

                                    final success =
                                        await followProvider.unfollow(
                                      userId: currentUserId,
                                      unfollowId: user['_id'],
                                    );

                                    if (success) {
                                      Navigator.pop(context); // close popup
                                      onRefresh(); // refresh parent
                                    }
                                  },
                            child: followProvider.isLoading
                                ? const CircularProgressIndicator(
                                    strokeWidth: 2,
                                  )
                                : const Text(
                                    "Unfollow",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),

            /// PROFILE IMAGE
            CircleAvatar(
              radius: 45,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 42,
                backgroundImage:
                    NetworkImage(user['profileImage'] ?? ''),
              ),
            ),
          ],
        ),
      );
    },
  );
}
Widget _countItem(String count, String label) {
  return Column(
    children: [
      Text(
        count,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          color: Colors.grey,
        ),
      ),
    ],
  );
}

}
