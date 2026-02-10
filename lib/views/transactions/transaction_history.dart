import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class Transaction {
  final String type;
  final int coins;
  final int amount;
  final String createdAt;

  Transaction({
    required this.type,
    required this.coins,
    required this.amount,
    required this.createdAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      type: json['type'],
      coins: json['coins'],
      amount: json['amount'],
      createdAt: json['createdAt'],
    );
  }
}

class _TransactionHistoryState extends State<TransactionHistory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Transaction> creditedList = [];
  List<Transaction> debitedList = [];

  bool loading = true;
  bool loadingUserGender = true;
  String? userGender;

  String? userId;

  @override
  void initState() {
    super.initState();
    _initializeScreen();
  }

  Future<void> _initializeScreen() async {
    await _loadUserData();
    
    // Initialize TabController based on gender
    if (userGender?.toLowerCase() == 'female') {
      _tabController = TabController(length: 2, vsync: this);
    } else {
      _tabController = TabController(length: 1, vsync: this);
    }
    
    await fetchTransactions();
  }

  Future<void> _loadUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getString('userId');
      final gender = prefs.getString('userGender'); // Assuming you store gender in SharedPreferences
      
      setState(() {
        userId = id;
        userGender = gender;
        loadingUserGender = false;
      });

      // If gender is not in SharedPreferences, fetch from API
      if (gender == null && id != null) {
        await _fetchUserGender(id);
      }
    } catch (e) {
      debugPrint("Error loading user data: $e");
      setState(() {
        loadingUserGender = false;
      });
    }
  }

  Future<void> _fetchUserGender(String uid) async {
    try {
      final response = await http.get(
        Uri.parse("http://31.97.206.144:4055/api/users/profile/$uid"),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final gender = data['user']?['gender'];
        
        setState(() {
          userGender = gender;
        });

        // Save to SharedPreferences for future use
        final prefs = await SharedPreferences.getInstance();
        if (gender != null) {
          await prefs.setString('userGender', gender);
        }
      }
    } catch (e) {
      debugPrint("Error fetching user gender: $e");
    }
  }

  Future<void> fetchTransactions() async {
    if (userId == null) return;

    try {
      print(userId);
      final creditedRes = await http.get(
        Uri.parse(
            "http://31.97.206.144:4055/api/users/gettransactionhistory/$userId?type=credited"),
      );

      if (creditedRes.statusCode == 200) {
        final creditedData = jsonDecode(creditedRes.body);

        creditedList = (creditedData['transactionhistyry'] as List)
            .map((e) => Transaction.fromJson(e))
            .toList();
      }

      // Only fetch debited transactions for female users
      if (userGender?.toLowerCase() == 'female') {
        final debitedRes = await http.get(
          Uri.parse(
              "http://31.97.206.144:4055/api/users/gettransactionhistory/$userId?type=debited"),
        );

        if (debitedRes.statusCode == 200) {
          final debitedData = jsonDecode(debitedRes.body);

          debitedList = (debitedData['transactionhistyry'] as List)
              .map((e) => Transaction.fromJson(e))
              .toList();
        }
      }
    } catch (e) {
      debugPrint("Error: $e");
    }

    setState(() => loading = false);
  }

  String formatDate(String date) {
    final dt = DateTime.parse(date).toLocal();
    return DateFormat('MMM dd HH:mm').format(dt);
  }

  @override
  Widget build(BuildContext context) {
    if (loadingUserGender) {
      return const Scaffold(
        backgroundColor: Color(0xffFFEFF5),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final isFemale = userGender?.toLowerCase() == 'female';

    return Scaffold(
      backgroundColor: const Color(0xffFFEFF5),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                const Text(
                  'Transaction History',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Show TabBar only for female users
            if (isFemale)
              Container(
                height: 48,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 3)],
                ),
                child: TabBar(
                  controller: _tabController,
                  labelPadding: EdgeInsets.zero,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: const Color(0xFFFE0A62),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  tabs: const [
                    Tab(child: Text('Top Up History')),
                    Tab(child: Text('Credits History')),
                  ],
                ),
              ),

            const SizedBox(height: 20),

            Expanded(
              child: loading
                  ? const Center(child: CircularProgressIndicator())
                  : isFemale
                      ? TabBarView(
                          controller: _tabController,
                          children: [
                            /// TOP UP (CREDITED)
                            ListView(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              children: creditedList
                                  .map((e) => _topUpItem(e))
                                  .toList(),
                            ),

                            /// DEBIT / CREDIT MIX
                            ListView(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              children: [
                                ...debitedList.map((e) => _debitItem(e)),
                                ...creditedList.map((e) => _creditItem(e)),
                              ],
                            ),
                          ],
                        )
                      : ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          children: creditedList
                              .map((e) => _topUpItem(e))
                              .toList(),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topUpItem(Transaction t) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: const Color(0xffEDE7FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.upload, color: Colors.black),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Top up ₹${t.amount}",
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(formatDate(t.createdAt),
                  style: const TextStyle(color: Colors.grey)),
            ],
          ),
          const Spacer(),
          Text(
            "+${t.coins} coins",
            style: const TextStyle(
                color: Color(0xff0FA958),
                fontSize: 15,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _debitItem(Transaction t) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: const Color(0xffEDE7FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.download, color: Colors.black),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Debited",
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600)),
              Text(formatDate(t.createdAt),
                  style: const TextStyle(color: Colors.grey)),
            ],
          ),
          const Spacer(),
          Text(
            "-${t.coins} Coins",
            style: const TextStyle(
                color: Color(0xffE70000),
                fontSize: 15,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget _creditItem(Transaction t) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: const Color(0xffEDE7FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.upload, color: Colors.black),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Added",
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600)),
              Text(formatDate(t.createdAt),
                  style: const TextStyle(color: Colors.grey)),
            ],
          ),
          const Spacer(),
          Text(
            "+${t.coins} coins",
            style: const TextStyle(
                color: Color(0xff0FA958),
                fontSize: 15,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}