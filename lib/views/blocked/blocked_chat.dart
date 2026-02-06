import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dating_app/providers/moderation/blocked_users_provider.dart';
import 'package:dating_app/models/moderation/blocked_user_model.dart';

class BlockedChat extends StatefulWidget {
  const BlockedChat({super.key});

  @override
  State<BlockedChat> createState() => _BlockedChatState();
}

class _BlockedChatState extends State<BlockedChat>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? currentUserId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index = 1; // Default → Blocked you
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    currentUserId = prefs.getString('userId');

    if (currentUserId != null && mounted) {
      context
          .read<BlockedUsersProvider>()
          .loadBlockedUsers(currentUserId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFEFF5),
      body: SafeArea(
        child: Consumer<BlockedUsersProvider>(
          builder: (context, provider, _) {
            final blockedByYou = provider.users
                .where((u) => u.blockedByMe == true)
                .toList();

            final blockedYou = provider.users
                .where((u) => u.blockedByMe == false)
                .toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),

                /// HEADER
                Row(
                  children: [
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, size: 20),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Blocked Chats",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// 🔴 CUSTOM TAB BAR (EXACT UI)
                _buildCustomTabBar(),

                const SizedBox(height: 16),

                /// CONTENT
                Expanded(
                  child: provider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : TabBarView(
                          controller: _tabController,
                          children: [
                            _buildList(blockedByYou, canUnblock: true),
                            _buildList(blockedYou, canUnblock: false),
                          ],
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// ================= CUSTOM TAB BAR =================
  Widget _buildCustomTabBar() {
    return Container(
      height: 42,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TabBar(
        controller: _tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        overlayColor: MaterialStateProperty.all(Colors.transparent),

        indicator: BoxDecoration(
          color: const Color(0xFFFE0A62),
          borderRadius: BorderRadius.circular(22),
        ),

        labelColor: Colors.white,
        unselectedLabelColor: Colors.black54,

        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),

        tabs: const [
          Tab(text: 'Blocked by you'),
          Tab(text: 'Blocked you'),
        ],
      ),
    );
  }

  /// ================= LIST =================
  Widget _buildList(
    List<BlockedUserModel> users, {
    required bool canUnblock,
  }) {
    if (users.isEmpty) {
      return Center(
        child: Text(
          'No users',
          style: TextStyle(color: Colors.black.withOpacity(0.5)),
        ),
      );
    }

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              /// AVATAR
              CircleAvatar(
                radius: 26,
                backgroundImage: NetworkImage(user.profileImage),
              ),

              const SizedBox(width: 12),

              /// NAME
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Blocked',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              /// THREE DOTS → UNBLOCK
              if (canUnblock)
                PopupMenuButton<String>(
                  onSelected: (_) => _confirmUnblock(user.userId),
                  itemBuilder: (_) => const [
                    PopupMenuItem(
                      value: 'unblock',
                      child: Text('Unblock'),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  /// ================= UNBLOCK CONFIRM =================
  void _confirmUnblock(String toUserId) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Unblock user?'),
        content: const Text(
          'You will be able to chat with this user again.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await context.read<BlockedUsersProvider>().unblock(
                    fromUser: currentUserId!,
                    toUser: toUserId,
                  );
              if (mounted) Navigator.pop(context);
            },
            child: const Text(
              'Unblock',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
