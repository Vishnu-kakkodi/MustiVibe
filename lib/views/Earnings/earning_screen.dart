import 'package:dating_app/utils/screen_size.dart';
import 'package:dating_app/views/Earnings/redeem_screen.dart';
import 'package:flutter/material.dart';

class EarningScreen extends StatelessWidget {
  const EarningScreen({super.key});

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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockWidth * 4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Referral Link
            Container(
              height: SizeConfig.blockHeight * 5.5,
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 3),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "ghesiurhushrfisijsmkjbjhsbzliaoasihkd",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: SizeConfig.blockWidth * 3.8,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(SizeConfig.blockWidth * 1.5),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      Icons.copy,
                      size: SizeConfig.blockWidth * 4.5,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: SizeConfig.blockHeight * 2),

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
                  Text(
                    "Earn ₹100",
                    style: TextStyle(
                      fontSize: SizeConfig.blockWidth * 9,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 2.5),
                  
                  // Reward Card 1 - Inside Pink Container
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
                          padding: EdgeInsets.all(SizeConfig.blockWidth * 2),
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
                              Text(
                                "Received Gift 1 Gift = ₹1",
                                style: TextStyle(
                                  fontSize: SizeConfig.blockWidth * 3.3,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: SizeConfig.blockHeight * 0.3),
                              Text(
                                "₹100",
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
                              MaterialPageRoute(builder: (_) => const RedeemScreen()),
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

            // Reward Card 2 - Outside (White Background)
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
                  )
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
                        Text(
                          "₹100",
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
                        MaterialPageRoute(builder: (_) => const RedeemScreen()),
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

            SizedBox(height: SizeConfig.blockHeight * 3),

            // Steps with icons
            _stepItem(
              icon: Icons.link,
              title: "Invite your friend to install the app with the link",
              stepNumber: 1,
            ),
            _connector(),
            _stepItem(
              icon: Icons.phone_android,
              title: "Use this App",
              stepNumber: 2,
            ),
            _connector(),
            _stepItem(
              icon: Icons.card_giftcard,
              title: "You get ₹100 once they complete this process",
              stepNumber: 3,
            ),

            SizedBox(height: SizeConfig.blockHeight * 3.5),

            // FAQ
            Text(
              "Frequently asked question",
              style: TextStyle(
                fontSize: SizeConfig.blockWidth * 4.2,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: SizeConfig.blockHeight * 1.5),

            _faqTile("What is the Refer & Earn program?"),
            _faqTile("How do I refer someone?"),
            _faqTile("How much can I earn per referral?"),
            _faqTile("What counts as a valid referral?"),

            SizedBox(height: SizeConfig.blockHeight * 3),
          ],
        ),
      ),
    );
  }

  // Reward Card
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
          )
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
                MaterialPageRoute(builder: (_) => const RedeemScreen()),
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
        border: Border.all(
          color: Colors.grey.withOpacity(0.1),
          width: 1,
        ),
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