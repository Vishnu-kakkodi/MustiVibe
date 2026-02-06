import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WarningInfo extends StatefulWidget {
  const WarningInfo({super.key});

  @override
  State<WarningInfo> createState() => _WarningInfoState();
}

class _WarningInfoState extends State<WarningInfo> {
  static const int maxWarnings = 5;

  bool isLoading = true;
  int currentWarnings = 0;

  @override
  void initState() {
    super.initState();
    _loadWarnings();
  }

  /// 🔹 Load userId + warnings and calculate count
  Future<void> _loadWarnings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');

      if (userId == null || userId.isEmpty) {
        setState(() => isLoading = false);
        return;
      }

      final response = await http.get(
        Uri.parse('http://31.97.206.144:4055/api/admin/warnings'),
      );
print("llllllllllllll$userId");
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final List warnings = body['warnings'] ?? [];

        /// 🔴 Count only THIS USER approved warnings
        final count = warnings.where((w) {
          final reportedUser = w['reportedUser'];
          return reportedUser != null &&
              reportedUser['_id'] == userId &&
              w['status'] == 'approved' &&
              w['isWarning'] == true;
        }).length;

        setState(() {
          currentWarnings = count;
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (_) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final progressRatio =
        (currentWarnings / maxWarnings).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Warning",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),

                  Center(
                    child: const Text(
                      "Continued violation of our terms\n"
                      "    may result in a permanent\n"
                      "               account block.",
                      style: TextStyle(
                        fontSize: 20,
                        height: 1.4,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// 🔴 COUNT TEXT (Dynamic)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${currentWarnings.toString().padLeft(2, '0')}/$maxWarnings",
                        style: const TextStyle(
                          color: Color(0xFFFF0000),
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  /// 🔴 PROGRESS BAR
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: LinearProgressIndicator(
                          value: progressRatio,
                          minHeight: 8,
                          backgroundColor: const Color(0xFFE0E0E0),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFFFF0000),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Current warnings",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "To avoid warnings",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 15),
                  const Divider(),
                  const SizedBox(height: 15),

                  _ruleItem(
                    number: 1,
                    text: "Talk to everyone with respect",
                  ),
                  _ruleItem(
                    number: 2,
                    text:
                        "Do not ask anyone for Instagram or WhatsApp details",
                  ),
                  _ruleItem(
                    number: 3,
                    text:
                        "Do not use abusive language and be polite",
                  ),
                  _ruleItem(
                    number: 4,
                    text: "Do not report anyone incorrectly",
                  ),
                ],
              ),
            ),
    );
  }

  Widget _ruleItem({required int number, required String text}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12),
        ),
      ),
      child: Text(
        "$number. $text",
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
      ),
    );
  }
}
