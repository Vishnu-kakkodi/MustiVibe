import 'package:dating_app/utils/screen_size.dart';
import 'package:flutter/material.dart';

class RedeemScreen extends StatelessWidget {
  const RedeemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      backgroundColor: const Color(0xffFFEFF5),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffFFEFF5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Redeem",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: SizeConfig.blockWidth * 5.9,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Top Card
            Container(
              padding: EdgeInsets.all(SizeConfig.blockWidth * 4),
              margin: EdgeInsets.only(top: SizeConfig.blockHeight * 1.5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/heart.png',
                    height: SizeConfig.blockHeight * 4.5,
                  ),
                  SizedBox(width: SizeConfig.blockWidth * 4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Received Gift   1 Gift = ₹1",
                        style: TextStyle(
                          fontSize: SizeConfig.blockWidth * 3.2,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: SizeConfig.blockHeight * 0.5),
                      Text(
                        "₹100",
                        style: TextStyle(
                          fontSize: SizeConfig.blockWidth * 7,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: SizeConfig.blockHeight * 2.5),

            // UPI Input
            TextField(
              decoration: InputDecoration(
                hintText: "Enter your UPI ID",
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockWidth * 4,
                  vertical: SizeConfig.blockHeight * 1.7,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            SizedBox(height: SizeConfig.blockHeight * 2),

            // Redeem Button
            SizedBox(
              width: double.infinity,
              height: SizeConfig.blockHeight * 7,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFE0A62),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Redeem Now",
                  style: TextStyle(
                    fontSize: SizeConfig.blockWidth * 4,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            SizedBox(height: SizeConfig.blockHeight * 3),

            Text(
              "Transaction History",
              style: TextStyle(
                fontSize: SizeConfig.blockWidth * 4,
                fontWeight: FontWeight.w700,
              ),
            ),

            SizedBox(height: SizeConfig.blockHeight * 1.5),

            Container(
              padding: EdgeInsets.symmetric(
                vertical: SizeConfig.blockHeight * 1,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Amount",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.blockWidth * 3.4,
                      )),
                  Text("Status",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.blockWidth * 3.4,
                      )),
                  Text("Date",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.blockWidth * 3.4,
                      )),
                ],
              ),
            ),

            Divider(color: Colors.grey.shade300),

            _buildTransactionRow("₹100", "Completed", Colors.green, "25-08-2025"),
            _buildTransactionRow("₹100", "Pending", Colors.orange, "25-08-2025"),

            SizedBox(height: SizeConfig.blockHeight * 4),

            Row(
              children: [
                SizedBox(height: 300,),
                Icon(
                  Icons.info_outline,
                  size: SizeConfig.blockWidth * 3.8,
                  color: Colors.grey,
                ),
                SizedBox(width: SizeConfig.blockWidth * 2),
                Expanded(
                  child: Text(
                    "Rewards will be processed within 1-2 business days.",
                    style: TextStyle(
                      fontSize: SizeConfig.blockWidth * 3.2,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),

            SizedBox(height: SizeConfig.blockHeight * 3),
          ],
        ),
      ),
    );
  }

  static Widget _buildTransactionRow(
      String amount, String status, Color color, String date) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.blockHeight * 1.3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            amount,
            style: TextStyle(fontSize: SizeConfig.blockWidth * 3.4),
          ),
          Text(
            status,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w500,
              fontSize: SizeConfig.blockWidth * 4.4,
            ),
          ),
          Text(
            date,
            style: TextStyle(fontSize: SizeConfig.blockWidth * 3.4),
          ),
        ],
      ),
    );
  }
}
 