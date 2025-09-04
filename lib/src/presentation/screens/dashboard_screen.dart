import 'package:flutter/cupertino.dart';
import 'add_edit_transaction_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Dashboard'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (context) => const AddEditTransactionScreen(),
              ),
            );
          },
          child: const Icon(CupertinoIcons.add),
        ),
      ),
      child: SafeArea(
        child: ListView(
          children: [
            _buildSummaryCard(context),
            _buildRecentTransactionsHeader(),
            _buildRecentTransactionItem(context, 'Salary', 'Income', '+\$5,000.00', CupertinoIcons.money_dollar_circle),
            _buildRecentTransactionItem(context, 'Groceries', 'Expense', '-\$75.50', CupertinoIcons.shopping_cart),
            _buildRecentTransactionItem(context, 'Freelance Project', 'Income', '+\$1,200.00', CupertinoIcons.briefcase),
            _buildRecentTransactionItem(context, 'Dinner with friends', 'Expense', '-\$42.00', CupertinoIcons.group),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: CupertinoTheme.of(context).barBackgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemGrey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildSummaryItem('Income', '+\$6,200.00', CupertinoColors.systemGreen),
            Container(
              height: 50,
              width: 1,
              color: CupertinoColors.systemGrey4,
            ),
            _buildSummaryItem('Expense', '-\$117.50', CupertinoColors.systemRed),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String title, String amount, Color color) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: CupertinoColors.secondaryLabel, fontSize: 16)),
        const SizedBox(height: 8),
        Text(amount, style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildRecentTransactionsHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        'Recent Transactions',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: CupertinoColors.label),
      ),
    );
  }

  Widget _buildRecentTransactionItem(BuildContext context, String title, String category, String amount, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: CupertinoTheme.of(context).barBackgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(category, style: const TextStyle(color: CupertinoColors.secondaryLabel)),
              ],
            ),
          ),
          Text(amount, style: TextStyle(
              fontWeight: FontWeight.bold,
              color: amount.startsWith('+') ? CupertinoColors.systemGreen : CupertinoColors.systemRed)),
        ],
      ),
    );
  }
}
