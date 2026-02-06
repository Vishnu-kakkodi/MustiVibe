import 'package:dating_app/views/warning/warning_screen.dart';
import 'package:flutter/material.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  String selectedLanguage = 'English';

  final List<Map<String, String>> languages = [
    {"symbol": "En", "name": "English"},
    {"symbol": "हि", "name": "Hindi"},
    {"symbol": "తె", "name": "Telugu"},
    {"symbol": "ಕ", "name": "Kannada"},
    {"symbol": "മ", "name": "Malayalam"},
    {"symbol": "தமிழ்", "name": "Tamil"},
  ];

  @override
  Widget build(BuildContext context) {
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
          'Select your language',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,           // ⭐ 2 columns
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 2.7,       // adjust height
                ),
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  return _buildLanguageButton(
                    symbol: languages[index]["symbol"]!,
                    language: languages[index]["name"]!,
                    isSelected: selectedLanguage == languages[index]["name"],
                    onTap: () {
                      setState(() {
                        selectedLanguage = languages[index]["name"]!;
                      });
                    },
                  );
                },
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const WarningScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFE0A62),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageButton({
    required String symbol,
    required String language,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFFFF0066) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    symbol,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? const Color(0xFFFF0066) : Colors.black,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    language,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? const Color(0xFFFF0066) : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF0066),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, size: 14, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
