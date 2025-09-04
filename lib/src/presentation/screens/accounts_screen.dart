import 'package:flutter/cupertino.dart';
import 'add_edit_account_screen.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({super.key});

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Accounts'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (context) => const AddEditAccountScreen(),
              ),
            );
          },
          child: const Icon(CupertinoIcons.add),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildFilterChips(),
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Placeholder
                itemBuilder: (context, index) {
                  // Placeholder data
                  final account = {
                    'name': 'Bank Account ${index + 1}',
                    'balance': '\$${1500 + index * 500}.00',
                    'icon': CupertinoIcons.creditcard,
                  };
                  return _buildAccountItem(
                    context,
                    account['name'] as String,
                    account['balance'] as String,
                    account['icon'] as IconData,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = ['All', 'Bank', 'Cash', 'Wallet', 'Savings'];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: filters.map((filter) {
            final isSelected = _selectedFilter == filter;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: CupertinoButton(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: isSelected ? CupertinoTheme.of(context).primaryColor : CupertinoColors.systemGrey5,
                onPressed: () {
                  setState(() {
                    _selectedFilter = filter;
                  });
                },
                child: Text(
                  filter,
                  style: TextStyle(
                    color: isSelected ? CupertinoColors.white : CupertinoColors.black,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildAccountItem(BuildContext context, String name, String balance, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: CupertinoColors.systemGrey4)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 28, color: CupertinoColors.secondaryLabel),
          const SizedBox(width: 16),
          Expanded(
            child: Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
          Text(balance, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
