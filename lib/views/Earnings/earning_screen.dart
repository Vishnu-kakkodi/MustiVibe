import 'package:dating_app/utils/screen_size.dart';
import 'package:dating_app/views/Earnings/redeem_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EarningScreen extends StatefulWidget {
  final String userId;

  const EarningScreen({super.key, required this.userId});

  @override
  State<EarningScreen> createState() => _EarningScreenState();
}

class _EarningScreenState extends State<EarningScreen> {
  bool isLoading = true;
  int myReferredRewarded = 0; // Referral Rewards (bottom card)
  int totalCoins = 0; // Received Gift amount (top card inside pink)
  int referralRewardCoins = 0; // Earn ₹ (big text at top)
  int coinsPerRupee = 10;
  int rupeesPerCoin = 1;

  @override
  void initState() {
    super.initState();
    fetchEarningsData();
  }

  Future<void> fetchEarningsData() async {
    try {
      print("ppppppppppppppppppppppppppp${widget.userId}");

      final response = await http.get(
        Uri.parse(
          'http://31.97.206.144:4055/api/users/myreferred-reward/${widget.userId}',
        ),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
print("ppppppppppppppppppppppppppp${response.body}");
        if (data['success'] == true) {
          setState(() {
            myReferredRewarded = data['myreferredrewarded'] ?? 0;
            totalCoins = data['totalCoins'] ?? 0;
            referralRewardCoins = data['referralRewardCoins'] ?? 0;
            coinsPerRupee = data['coinToRupee']['coins'] ?? 10;
            rupeesPerCoin = data['coinToRupee']['rupees'] ?? 1;
            isLoading = false;
          });
        }
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching earnings data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: const Color(0xffFFEFF5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffFFEFF5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "My Earnings",
          style: TextStyle(
            color: Colors.black,
            fontSize: SizeConfig.blockWidth * 5.9,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xffFE0A62)),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockWidth * 4,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Refer Your Friends - Combined Card with Rewards
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(SizeConfig.blockWidth * 4.5),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFE0A62), Color(0xFFFE0A62)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Refer Your Friends",
                              style: TextStyle(
                                fontSize: SizeConfig.blockWidth * 4.5,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/coinsimage.png",
                                  height: SizeConfig.blockHeight * 8,
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: SizeConfig.blockHeight * 0.8),
                        // ✅ "Earn ₹100" → referralRewardCoins
                        Text(
                          "Earn ₹$referralRewardCoins",
                          style: TextStyle(
                            fontSize: SizeConfig.blockWidth * 9,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: SizeConfig.blockHeight * 2.5),
                        // Reward Card 1 - Received Gift
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.blockWidth * 3.5,
                            vertical: SizeConfig.blockHeight * 1.5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(
                                  SizeConfig.blockWidth * 2,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFE0A62).withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Image.asset(
                                  "assets/heart.png",
                                  height: SizeConfig.blockHeight * 3.5,
                                  width: SizeConfig.blockHeight * 3.5,
                                ),
                              ),
                              SizedBox(width: SizeConfig.blockWidth * 3),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // ✅ "Received Gift 1 Gift = ₹1"
                                    Text(
                                      "Received Gift $coinsPerRupee Coins = ₹$rupeesPerCoin",
                                      style: TextStyle(
                                        fontSize: SizeConfig.blockWidth * 3.3,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockHeight * 0.3,
                                    ),
                                    // ✅ "₹100" → totalCoins
                                    Text(
                                      "₹$totalCoins",
                                      style: TextStyle(
                                        fontSize: SizeConfig.blockWidth * 6,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => RedeemScreen(userId: widget.userId),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.blockWidth * 5,
                                    vertical: SizeConfig.blockHeight * 1.2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffFE0A62),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    "Redeem",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: SizeConfig.blockWidth * 3.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 2),
                  // Reward Card 2 - Referral Rewards
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockWidth * 3.5,
                      vertical: SizeConfig.blockHeight * 1.5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(SizeConfig.blockWidth * 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFA726).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.asset(
                            "assets/singlecoin.png",
                            height: SizeConfig.blockHeight * 3.5,
                            width: SizeConfig.blockHeight * 3.5,
                          ),
                        ),
                        SizedBox(width: SizeConfig.blockWidth * 3),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Referral Rewards",
                                style: TextStyle(
                                  fontSize: SizeConfig.blockWidth * 3.3,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: SizeConfig.blockHeight * 0.3),
                              // ✅ "₹100" → myReferredRewarded
                              Text(
                                "₹$myReferredRewarded",
                                style: TextStyle(
                                  fontSize: SizeConfig.blockWidth * 6,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>  RedeemScreen(userId: widget.userId),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.blockWidth * 5,
                              vertical: SizeConfig.blockHeight * 1.2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xffFE0A62),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "Redeem",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.blockWidth * 3.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
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

  // Reward Card Widget
  Widget _rewardCard({
    required BuildContext context,
    required String title,
    required String amount,
    required String icon,
    required Color iconColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockWidth * 4,
        vertical: SizeConfig.blockHeight * 1.8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(SizeConfig.blockWidth * 2.5),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              icon,
              height: SizeConfig.blockHeight * 3.5,
              width: SizeConfig.blockHeight * 3.5,
            ),
          ),
          SizedBox(width: SizeConfig.blockWidth * 3),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: SizeConfig.blockWidth * 3.5,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: SizeConfig.blockWidth * 5,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(width: SizeConfig.blockWidth * 3),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => RedeemScreen(userId: widget.userId)),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockWidth * 4,
                vertical: SizeConfig.blockHeight * 1.1,
              ),
              decoration: BoxDecoration(
                color: const Color(0xffFE0A62),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Redeem",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.blockWidth * 3.3,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stepItem({
    required IconData icon,
    required String title,
    required int stepNumber,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(SizeConfig.blockWidth * 2.5),
          decoration: BoxDecoration(
            color: const Color(0xffFE0A62).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: const Color(0xffFE0A62),
            size: SizeConfig.blockWidth * 5.5,
          ),
        ),
        SizedBox(width: SizeConfig.blockWidth * 3.5),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: SizeConfig.blockHeight * 0.8),
            child: Text(
              title,
              style: TextStyle(
                fontSize: SizeConfig.blockWidth * 3.6,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _connector() {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.blockWidth * 5,
        top: SizeConfig.blockHeight * 0.5,
        bottom: SizeConfig.blockHeight * 0.5,
      ),
      child: Container(
        width: 2,
        height: SizeConfig.blockHeight * 3,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xffFE0A62).withOpacity(0.3),
              const Color(0xffFE0A62).withOpacity(0.1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }

  Widget _faqTile(String title) {
    return Container(
      margin: EdgeInsets.only(bottom: SizeConfig.blockHeight * 1.2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.1), width: 1),
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockWidth * 4,
          vertical: SizeConfig.blockHeight * 0.3,
        ),
        childrenPadding: EdgeInsets.fromLTRB(
          SizeConfig.blockWidth * 4,
          0,
          SizeConfig.blockWidth * 4,
          SizeConfig.blockHeight * 1.5,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: SizeConfig.blockWidth * 3.6,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        iconColor: const Color(0xffFE0A62),
        collapsedIconColor: Colors.grey[600],
        children: [
          Text(
            "Answer placeholder text goes here.",
            style: TextStyle(
              fontSize: SizeConfig.blockWidth * 3.3,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}