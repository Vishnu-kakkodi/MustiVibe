import 'package:dating_app/views/navbar/navbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationItem> notifications = [];
  bool isLoading = true;
  String? errorMessage;
  String? _userId;

  final String baseUrl = "http://31.97.206.144:4055/api";

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  /// ✅ FETCH NOTIFICATIONS
  Future<void> _fetchNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    
    setState(() {
      _userId = userId;
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/getnotification/$userId'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] == true) {
          final List notifList = data['notifications'] ?? [];
          setState(() {
            notifications = notifList
                .map((json) => NotificationItem.fromJson(json))
                .toList();
            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = data['message'] ?? 'Failed to load notifications';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = 'Server error: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Network error: $e';
        isLoading = false;
      });
    }
  }

  /// ✅ DELETE SINGLE NOTIFICATION
  Future<void> _deleteSingleNotification(String notificationId) async {
    if (_userId == null) return;

    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/users/userdltnot/$_userId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'notificationIds': [notificationId]
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          notifications.removeWhere((n) => n.id == notificationId);
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Notification deleted'),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        throw Exception('Failed to delete');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error deleting notification: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// ✅ DELETE ALL NOTIFICATIONS
  Future<void> _deleteAllNotifications() async {
    if (_userId == null || notifications.isEmpty) return;

    // Show confirmation dialog
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete All Notifications'),
        content: const Text(
          'Are you sure you want to delete all notifications? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete All'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      // Get all notification IDs
      final allNotificationIds = notifications.map((n) => n.id).toList();

      final response = await http.delete(
        Uri.parse('$baseUrl/users/userdltnot/$_userId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'notificationIds': allNotificationIds
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          notifications.clear();
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('All notifications deleted'),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        throw Exception('Failed to delete all');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error deleting notifications: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// ✅ HANDLE BACK NAVIGATION
  Future<bool> _handleBack() async {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
      );
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleBack,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,

        /// ✅ APPBAR
        appBar: AppBar(
          title: const Text("Notifications"),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _handleBack,
          ),
          actions: [
            if (notifications.isNotEmpty)
              TextButton.icon(
                onPressed: _deleteAllNotifications,
                icon: const Icon(Icons.delete_sweep, color: Colors.red),
                label: const Text(
                  'Clear All',
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),

        /// ✅ BODY
        body: _buildBody(),
      ),
    );
  }

  /// ✅ BUILD BODY CONTENT
  Widget _buildBody() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _fetchNotifications,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_off_outlined,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No notifications yet',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _fetchNotifications,
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return _buildNotificationTile(notification);
        },
      ),
    );
  }

  /// ✅ BUILD SWIPEABLE NOTIFICATION TILE
  Widget _buildNotificationTile(NotificationItem notification) {
    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.startToEnd,
      confirmDismiss: (direction) async {
        // Show confirmation dialog for swipe delete
        return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Notification'),
            content: const Text('Are you sure you want to delete this notification?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        _deleteSingleNotification(notification.id);
      },
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(14),
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
      ),
      child: _notificationTile(notification),
    );
  }

  /// ✅ NOTIFICATION TILE UI
  Widget _notificationTile(NotificationItem notification) {
    final icon = _getNotificationIcon(notification.type);
    final timeAgo = _getTimeAgo(notification.createdAt);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: _getNotificationColor(notification.type),
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          notification.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(notification.body),
        trailing: Text(
          timeAgo,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        onTap: () {
          // 👉 Handle notification click if needed
        },
      ),
    );
  }

  /// ✅ GET NOTIFICATION ICON
  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'follow':
        return Icons.person_add;
      case 'unfollow':
        return Icons.person_remove;
      case 'message':
        return Icons.message;
      case 'like':
        return Icons.favorite;
      default:
        return Icons.notifications;
    }
  }

  /// ✅ GET NOTIFICATION COLOR
  Color _getNotificationColor(String type) {
    switch (type) {
      case 'follow':
        return Colors.green;
      case 'unfollow':
        return Colors.orange;
      case 'message':
        return Colors.blue;
      case 'like':
        return Colors.pink;
      default:
        return Colors.grey;
    }
  }

  /// ✅ GET TIME AGO
  String _getTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

/// ✅ NOTIFICATION MODEL
class NotificationItem {
  final String id;
  final String title;
  final String body;
  final String type;
  final DateTime createdAt;

  NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.createdAt,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      type: json['type'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}