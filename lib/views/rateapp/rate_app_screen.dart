import 'package:flutter/material.dart';

class RateAppScreen extends StatefulWidget {
  const RateAppScreen({super.key});

  @override
  State<RateAppScreen> createState() => _RateAppScreenState();
}

class _RateAppScreenState extends State<RateAppScreen> {
  int selectedStars = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFEFF5),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFEFF5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Rate App",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            const Text(
              "Your Feedback on App",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 15),
            Row(
              children: List.generate(5, (index) {
                final filled = index < selectedStars;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedStars = index + 1;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(
                      filled ? Icons.star : Icons.star_border,
                      size: 35,
                      color: const Color.fromARGB(255, 140, 140, 140),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),

            Container(
              height: 250,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  TextField(
                    maxLines: 10,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Tell Us About Experience..",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),

                  Positioned(
                    right: 0,
                    top: 0,
                    child: Icon(
                      Icons.edit_outlined,
                      size: 20,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
