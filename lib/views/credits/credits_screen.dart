

import 'dart:convert';
import 'package:dating_app/core/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreditsScreen extends StatefulWidget {
  const CreditsScreen({super.key});

  @override
  State<CreditsScreen> createState() => _CreditsScreenState();
}

class _CreditsScreenState extends State<CreditsScreen> {
  late Razorpay _razorpay;

  bool _isProcessing = false;
  String? _selectedPackageId;
  int _selectedAmount = 0;

    String? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
    _initRazorpay();
  }


    Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId') ?? '';
    });
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _initRazorpay() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _onPaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _onPaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _onExternalWallet);
  }

  /// 🔹 Fetch credit packs
  Future<List<Map<String, dynamic>>> fetchCreditPacks() async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/api/packages'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List data = body['data'];

      return data.map<Map<String, dynamic>>((item) {
        return {
          "id": item['_id'],
          "coins": item['coins'],
          "price": item['price'],
        };
      }).toList();
    } else {
      throw Exception('Failed to load packages');
    }
  }

  /// 🔹 Open Razorpay
  void _startPayment({
    required String packageId,
    required int amount,
  }) {
    setState(() {
      _isProcessing = true;
      _selectedPackageId = packageId;
      _selectedAmount = amount;
    });

    final options = {
      'key': 'rzp_test_BxtRNvflG06PTV',
      'amount': amount * 100,
      'name': 'Dating App',
      'description': 'Credit Purchase',
      'retry': {'enabled': true, 'max_count': 1},
      'prefill': {'contact': '9999999999'},
      'external': {
        'wallets': ['paytm', 'phonepe', 'gpay'],
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      _stopLoading();
      _showToast('Unable to start payment', Colors.red);
    }
  }

  /// 🔹 Razorpay Success
  void _onPaymentSuccess(PaymentSuccessResponse response) async {
    await _createCreditOrder(response.paymentId);
  }

  /// 🔹 Razorpay Failure
  void _onPaymentError(PaymentFailureResponse response) {
    _stopLoading();
    _showToast('Payment cancelled', Colors.red);
  }

  void _onExternalWallet(ExternalWalletResponse response) {}

  /// 🔹 Create order API
  Future<void> _createCreditOrder(String? transactionId) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/api/create-order'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "userId": userId,
          "packageId": _selectedPackageId,
          "transactionId": transactionId,
        }),
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200 && body['success'] == true) {
        _showToast('Credits added successfully 🎉', Colors.green);
      } else {
        _showToast(body['message'] ?? 'Order failed', Colors.red);
      }
    } catch (e) {
      _showToast('Something went wrong', Colors.red);
    } finally {
      _stopLoading();
    }
  }

  void _stopLoading() {
    if (mounted) {
      setState(() => _isProcessing = false);
    }
  }

  void _showToast(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isProcessing,
      child: Scaffold(
        backgroundColor: const Color(0xffFFF3F8),
        appBar: AppBar(
          backgroundColor: const Color(0xffFFF3F8),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: _isProcessing ? null : () => Navigator.pop(context),
          ),
          title: const Text(
            "Add Credits",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: fetchCreditPacks(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  final packs = snapshot.data ?? [];

                  return GridView.builder(
                    itemCount: packs.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.78,
                    ),
                    itemBuilder: (context, index) {
                      final pack = packs[index];

                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border:
                              Border.all(color: const Color(0xffFF9ECF)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${pack['coins']} Coins",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "₹ ${pack['price']}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: _isProcessing
                                  ? null
                                  : () => _startPayment(
                                        packageId: pack['id'],
                                        amount: pack['price'],
                                      ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(0xFFFE0A62),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text("Buy"),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            /// 🔹 Loading Overlay
            if (_isProcessing)
              Container(
                color: Colors.black.withOpacity(0.7),
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
