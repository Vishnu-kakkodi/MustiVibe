import 'package:flutter/material.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
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
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [SizedBox(width: 6), Text('Top Up History')],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [SizedBox(width: 6), Text('Credits History')],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  /// TOP UP HISTORY
                  ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      const Text(
                        "Top Up History",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...List.generate(4, (index) => _topUpItem()),
                    ],
                  ),

                  /// CREDITS HISTORY
                  ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      const Text(
                        "Top Up History",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _debitItem(),
                      _creditItem(),
                      _debitItem(),
                      _creditItem(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topUpItem() {
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
            children: const [
              Text(
                "Top up ₹400",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 3),
              Text("Yesterday 02:12", style: TextStyle(color: Colors.grey)),
            ],
          ),
          const Spacer(),
          const Text(
            "+500 coins",
            style: TextStyle(
              color: Color(0xff0FA958),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _debitItem() {
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
            children: const [
              Text(
                "Debited",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 3),
              Text("Today 12:32", style: TextStyle(color: Colors.grey)),
            ],
          ),
          const Spacer(),
          const Text(
            "-30 Coins",
            style: TextStyle(
              color: Color(0xffE70000),
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _creditItem() {
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
            children: const [
              Text(
                "Added",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 3),
              Text("Dec 24 13:53", style: TextStyle(color: Colors.grey)),
            ],
          ),
          const Spacer(),
          const Text(
            "+ 500 coins",
            style: TextStyle(
              color: Color(0xff0FA958),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
