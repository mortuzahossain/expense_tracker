import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: const Text('This month'),
              subtitle: const Text('Income / Expense summary'),
              trailing: FilledButton(onPressed: () => context.push('/tx/new'), child: const Text('Add')),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _Tile(icon: Icons.account_balance_wallet, label: 'Accounts', onTap: () => context.push('/accounts')),
              _Tile(icon: Icons.category, label: 'Categories', onTap: () => context.push('/categories')),
              _Tile(icon: Icons.flag_outlined, label: 'Budget', onTap: () => context.push('/budget')),
              _Tile(icon: Icons.pie_chart, label: 'Reports', onTap: () => context.push('/reports')),
              _Tile(icon: Icons.settings, label: 'Settings', onTap: () => context.push('/settings')),
            ],
          ),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _Tile({required this.icon, required this.label, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        width: 160,
        height: 100,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Theme.of(context).colorScheme.surfaceContainer),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(icon), const SizedBox(height: 8), Text(label)],
        ),
      ),
    );
  }
}
