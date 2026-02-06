import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// ================= MODEL =================

class MyRoom {
  final String id;
  final String type;
  final String tag;
  final String startDateTime;

  MyRoom({
    required this.id,
    required this.type,
    required this.tag,
    required this.startDateTime,
  });

  factory MyRoom.fromJson(Map<String, dynamic> json) {
    return MyRoom(
      id: json['_id'],
      type: json['type'],
      tag: json['tag'],
      startDateTime: json['startDateTime'],
    );
  }
}

/// ================= SCREEN =================

class MyRoomsScreen extends StatefulWidget {
  const MyRoomsScreen({super.key});

  @override
  State<MyRoomsScreen> createState() => _MyRoomsScreenState();
}

class _MyRoomsScreenState extends State<MyRoomsScreen> {
  static const baseUrl = 'http://31.97.206.144:4055/api/users';

  List<MyRoom> rooms = [];
  bool isLoading = true;
  String? userId;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
    if (userId != null) {
      await _loadRooms();
    }
  }

  Future<void> _loadRooms() async {
    setState(() => isLoading = true);

    final res =
        await http.get(Uri.parse('$baseUrl/myrooms/$userId'));

    final data = jsonDecode(res.body);
    rooms = (data['rooms'] as List)
        .map((e) => MyRoom.fromJson(e))
        .toList();

    setState(() => isLoading = false);
  }

  /// ================= UI =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Rooms'),
        backgroundColor: const Color(0xFFFE0A62),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : rooms.isEmpty
              ? const Center(child: Text('No rooms found'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: rooms.length,
                  itemBuilder: (_, i) => _roomCard(rooms[i]),
                ),
    );
  }

  Widget _roomCard(MyRoom room) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black.withOpacity(0.05),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            room.tag,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text('Type: ${room.type}'),
          Text('Start: ${room.startDateTime}'),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                icon: const Icon(Icons.edit),
                label: const Text('Edit'),
                onPressed: () => _editRoom(room),
              ),
              TextButton.icon(
                icon: const Icon(Icons.delete, color: Colors.red),
                label: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () => _deleteRoom(room),
              ),
            ],
          )
        ],
      ),
    );
  }

  /// ================= EDIT =================

  Future<void> _editRoom(MyRoom room) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2027),
    );
    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return;

    final formatted =
        '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year} '
        '${time.hourOfPeriod.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} '
        '${time.period == DayPeriod.am ? 'AM' : 'PM'}';

    final res = await http.put(
      Uri.parse('$baseUrl/updatemyroom/$userId/${room.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "type": room.type,
        "tag": room.tag,
        "startDateTime": formatted,
      }),
    );

    final data = jsonDecode(res.body);
    if (data['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Room updated')),
      );
      _loadRooms();
    }
  }

  /// ================= DELETE =================

  Future<void> _deleteRoom(MyRoom room) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete room?'),
        content: const Text('This action cannot be undone'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child:
                const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    final res = await http.delete(
      Uri.parse('$baseUrl/deletemyroom/$userId/${room.id}'),
    );

    final data = jsonDecode(res.body);
    if (data['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Room deleted')),
      );
      _loadRooms();
    }
  }
}
