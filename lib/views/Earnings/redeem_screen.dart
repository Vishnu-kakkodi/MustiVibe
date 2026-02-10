import 'package:dating_app/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RedeemScreen extends StatefulWidget {
  final String userId;
  
  const RedeemScreen({super.key, required this.userId});

  @override
  State<RedeemScreen> createState() => _RedeemScreenState();
}

class _RedeemScreenState extends State<RedeemScreen> {
  final TextEditingController _upiController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  bool _isLoading = false;
  bool _isFetchingHistory = true;
  bool _isFetchingReward = true;
  int _totalCoins = 0;
  int _coinsPerRupee = 10;
  int _rupeesPerCoin = 1;
  List<dynamic> _transactions = [];

  @override
  void initState() {
    super.initState();
    _fetchRedeemHistory();
    _fetchReferredReward();
  }

  @override
  void dispose() {
    _upiController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _fetchReferredReward() async {
    setState(() {
      _isFetchingReward = true;
    });

    try {
      final response = await http.get(
        Uri.parse('http://31.97.206.144:4055/api/users/myreferred-reward/${widget.userId}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          setState(() {
            _totalCoins = data['totalCoins'] ?? 0;
            if (data['coinToRupee'] != null) {
              _coinsPerRupee = data['coinToRupee']['coins'] ?? 10;
              _rupeesPerCoin = data['coinToRupee']['rupees'] ?? 1;
            }
          });
        }
      }
    } catch (e) {
      print('Error fetching referred reward: $e');
    } finally {
      setState(() {
        _isFetchingReward = false;
      });
    }
  }

  Future<void> _fetchRedeemHistory() async {
    setState(() {
      _isFetchingHistory = true;
    });

    try {
      final response = await http.get(
        Uri.parse('http://31.97.206.144:4055/api/users/getmyredeemrequest/${widget.userId}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          setState(() {
            _transactions = data['requests'] ?? [];
          });
        }
      }
    } catch (e) {
      print('Error fetching redeem history: $e');
    } finally {
      setState(() {
        _isFetchingHistory = false;
      });
    }
  }

  Future<void> _redeemCoins() async {
    if (_upiController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your UPI ID')),
      );
      return;
    }

    if (_amountController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter redeem amount')),
      );
      return;
    }

    final redeemAmount = int.tryParse(_amountController.text.trim()) ?? 0;
    
    if (redeemAmount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount')),
      );
      return;
    }

    // Calculate required coins based on the conversion rate
    final requiredCoins = redeemAmount * _coinsPerRupee ~/ _rupeesPerCoin;

    if (requiredCoins > _totalCoins) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Insufficient coins. You need $requiredCoins coins to redeem ₹$redeemAmount')),
      );
      return;
    }

    if (requiredCoins < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Minimum 10 coins required to redeem')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://31.97.206.144:4055/api/users/sendredeemrequest'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'userId': widget.userId,
          'coins': requiredCoins,
          'upiId': _upiController.text.trim(),
        }),
      );
        print("kkkkkkkkkkkkkkkkkkkkkkk${response.body}");
                print("kkkkkkkkkkkkkkkkkkkkkkk${response.statusCode}");


      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        print("kkkkkkkkkkkkkkkkkkkkkkk${response.body}");
        if (data['success']) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Redeem request submitted successfully!')),
          );
          _upiController.clear();
          _amountController.clear();
          await _fetchRedeemHistory();
          await _fetchReferredReward();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'] ?? 'Failed to submit redeem request')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to submit redeem request')),
        );
      }
    } catch (e) {
      print('Error redeeming coins: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred. Please try again.')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
    } catch (e) {
      return dateStr;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'success':
        return Colors.green;
      case 'pending':
      case 'process':
        return Colors.orange;
      case 'rejected':
      case 'failed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'process':
        return 'Pending';
      case 'success':
        return 'Completed';
      default:
        return status[0].toUpperCase() + status.substring(1);
    }
  }

  double _calculateRupees(int coins) {
    return coins * _rupeesPerCoin / _coinsPerRupee;
  }

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
              child: _isFetchingReward
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Row(
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
                              "$_coinsPerRupee Coins = ₹$_rupeesPerCoin",
                              style: TextStyle(
                                fontSize: SizeConfig.blockWidth * 3.2,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: SizeConfig.blockHeight * 0.5),
                            Text(
                              "₹${_calculateRupees(_totalCoins).toStringAsFixed(0)}",
                              style: TextStyle(
                                fontSize: SizeConfig.blockWidth * 7,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: SizeConfig.blockHeight * 0.3),
                            Text(
                              "Total Coins: $_totalCoins",
                              style: TextStyle(
                                fontSize: SizeConfig.blockWidth * 3.2,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
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
              controller: _upiController,
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

            // Amount Input
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                hintText: "Enter amount in ₹",
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: SizeConfig.blockWidth * 4),
                  child: Icon(
                    Icons.currency_rupee,
                    size: SizeConfig.blockWidth * 5,
                  ),
                ),
                prefixIconConstraints: BoxConstraints(
                  minWidth: SizeConfig.blockWidth * 12,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockWidth * 4,
                  vertical: SizeConfig.blockHeight * 1.7,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {}); // Rebuild to show calculated coins
              },
            ),

            if (_amountController.text.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(
                  top: SizeConfig.blockHeight * 1,
                  left: SizeConfig.blockWidth * 2,
                ),
                child: Text(
                  "Required coins: ${(int.tryParse(_amountController.text) ?? 0) * _coinsPerRupee ~/ _rupeesPerCoin}",
                  style: TextStyle(
                    fontSize: SizeConfig.blockWidth * 3.2,
                    color: Colors.grey.shade600,
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
                onPressed: _isLoading ? null : _redeemCoins,
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
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

            _isFetchingHistory
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: CircularProgressIndicator(),
                    ),
                  )
                : _transactions.isEmpty
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.all(SizeConfig.blockHeight * 3),
                          child: Text(
                            "No transactions yet",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: SizeConfig.blockWidth * 3.5,
                            ),
                          ),
                        ),
                      )
                    : Column(
                        children: _transactions.map((transaction) {
                          return _buildTransactionRow(
                            "₹${(transaction['amount'] ?? 0).toString()}",
                            _getStatusText(transaction['status'] ?? 'pending'),
                            _getStatusColor(transaction['status'] ?? 'pending'),
                            _formatDate(transaction['createdAt'] ?? ''),
                          );
                        }).toList(),
                      ),

            SizedBox(height: SizeConfig.blockHeight * 4),

            Row(
              children: [
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

  Widget _buildTransactionRow(
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