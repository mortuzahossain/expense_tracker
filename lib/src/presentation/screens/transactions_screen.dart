import 'package:flutter/cupertino.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Transactions'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            _showFilterOptions(context);
          },
          child: const Icon(CupertinoIcons.sort_down),
        ),
      ),
      child: SafeArea(
        child: ListView.builder(
          itemCount: 10, // Placeholder count
          itemBuilder: (context, index) {
            // Placeholder data
            final isIncome = index % 3 == 0;
            final transaction = {
              'title': isIncome ? 'Salary' : 'Coffee Shop',
              'category': isIncome ? 'Income' : 'Food',
              'amount': isIncome ? '+\$2,500.00' : '-\$4.50',
              'date': '2023-10-2${9 - index}',
              'icon': isIncome ? CupertinoIcons.money_dollar_circle : CupertinoIcons.shopping_cart,
            };
            return _buildTransactionItem(
              context,
              transaction['title'] as String,
              transaction['category'] as String,
              transaction['amount'] as String,
              transaction['date'] as String,
              transaction['icon'] as IconData,
            );
          },
        ),
      ),
    );
  }

  Widget _buildTransactionItem(BuildContext context, String title, String category, String amount, String date, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: CupertinoTheme.of(context).barBackgroundColor.withOpacity(0.7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                const SizedBox(height: 4),
                Text(category, style: const TextStyle(color: CupertinoColors.secondaryLabel, fontSize: 14)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: amount.startsWith('+') ? CupertinoColors.systemGreen : CupertinoColors.systemRed,
                ),
              ),
              const SizedBox(height: 4),
              Text(date, style: const TextStyle(color: CupertinoColors.secondaryLabel, fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }

  void _showFilterOptions(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Filter Transactions'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: const Text('By Date Range'),
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement date range filter
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('By Category'),
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement category filter
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('By Account'),
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement account filter
            },
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ),
    );
  }
}
