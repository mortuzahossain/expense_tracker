import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // For LinearProgressIndicator
import 'set_edit_budget_screen.dart';

enum BudgetListType { weekly, monthly }

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  BudgetListType _selectedType = BudgetListType.monthly;

  // Placeholder data
  final List<Map<String, dynamic>> _budgets = [
    {'name': 'Food', 'icon': CupertinoIcons.shopping_cart, 'spent': 250.50, 'total': 500.0},
    {'name': 'Shopping', 'icon': CupertinoIcons.bag, 'spent': 150.0, 'total': 300.0},
    {'name': 'Entertainment', 'icon': CupertinoIcons.film, 'spent': 80.0, 'total': 150.0},
    {'name': 'Transport', 'icon': CupertinoIcons.bus, 'spent': 120.0, 'total': 120.0},
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Budget'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (context) => const SetEditBudgetScreen(),
              ),
            );
          },
          child: const Icon(CupertinoIcons.add),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildTypeSelector(),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _budgets.length,
                itemBuilder: (context, index) {
                  final budget = _budgets[index];
                  return _buildBudgetItem(
                    context,
                    budget['name'] as String,
                    budget['icon'] as IconData,
                    budget['spent'] as double,
                    budget['total'] as double,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeSelector() {
    return CupertinoSlidingSegmentedControl<BudgetListType>(
      groupValue: _selectedType,
      onValueChanged: (BudgetListType? newValue) {
        if (newValue != null) {
          setState(() {
            _selectedType = newValue;
          });
        }
      },
      children: const <BudgetListType, Widget>{
        BudgetListType.weekly: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('Weekly'),
        ),
        BudgetListType.monthly: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('Monthly'),
        ),
      },
    );
  }

  Widget _buildBudgetItem(BuildContext context, String name, IconData icon, double spent, double total) {
    final double progress = total > 0 ? spent / total : 0;
    final double remaining = total - spent;
    final Color progressColor = progress > 0.8 ? CupertinoColors.systemRed : (progress > 0.5 ? CupertinoColors.systemYellow : CupertinoColors.systemGreen);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            fullscreenDialog: true,
            builder: (context) => const SetEditBudgetScreen(), // Should pass budget data
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: CupertinoTheme.of(context).barBackgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemGrey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 24, color: CupertinoColors.secondaryLabel),
                const SizedBox(width: 12),
                Text(name, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                const Spacer(),
                Text(
                  'Remaining: \$${remaining.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 14, color: CupertinoColors.secondaryLabel),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: CupertinoColors.systemGrey5,
                valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                minHeight: 12,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${spent.toStringAsFixed(2)} spent',
                  style: const TextStyle(fontSize: 14, color: CupertinoColors.secondaryLabel),
                ),
                Text(
                  'of \$${total.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 14, color: CupertinoColors.secondaryLabel),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
