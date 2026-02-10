import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ReferAndEarnScreen extends StatefulWidget {
  const ReferAndEarnScreen({super.key});

  @override
  State<ReferAndEarnScreen> createState() => _ReferAndEarnScreenState();
}

class _ReferAndEarnScreenState extends State<ReferAndEarnScreen> {

  String referralCode = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchReferralCode();
  }

  /// 🔹 Fetch referral code from API
  Future<void> fetchReferralCode() async {
        final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('userId');
    final response = await http.get(
      Uri.parse(
        "http://31.97.206.144:4055/api/users/getmyreffralcode/$id",
      ),
      // Add headers if needed
      // headers: {"Authorization": "Bearer TOKEN"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      setState(() {
        referralCode = data["myReferralCode"];
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
    }
  }

  /// Copy video from assets to temp so it can be shared
  Future<File> _getVideoFile() async {
    final byteData = await rootBundle.load('assets/demo.mp4');
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/mustivibes_promo.mp4');
    await file.writeAsBytes(byteData.buffer.asUint8List());
    return file;
  }

  Future<void> _shareApp() async {
    final videoFile = await _getVideoFile();

    await Share.shareXFiles(
      [XFile(videoFile.path)],
      text: '''
💖 Join MustiVibe – where real connections begin!

✨ Meet genuine people
💬 Chat, call & connect
🔒 100% safe & verified profiles

🎁 Use my referral code: $referralCode

📲 Download now & start your journey to love ❤️
''',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        title: const Text("Refer & Earn"),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),

            /// 🎁 Top Illustration
            Container(
              height: 180,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFE91E63), Color(0xFF9C27B0)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Icon(
                  Icons.card_giftcard,
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// Title
            const Text(
              "Invite Friends & Earn Rewards",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Share your referral code and earn exciting rewards when your friends join MustiVibe.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            /// Referral Code Box (UNCHANGED UI)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isLoading ? "Loading..." : referralCode,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: isLoading
                        ? null
                        : () {
                            Clipboard.setData(
                              ClipboardData(text: referralCode),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Referral code copied")),
                            );
                          },
                  ),
                ],
              ),
            ),

            const Spacer(),

            /// Refer Button (UNCHANGED)
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton.icon(
                onPressed: isLoading ? null : _shareApp,
                icon: const Icon(Icons.share),
                label: const Text(
                  "Refer & Earn",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE91E63),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
