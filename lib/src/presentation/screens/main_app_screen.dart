import 'package:flutter/cupertino.dart';
import 'dashboard_screen.dart';
import 'transactions_screen.dart';
import 'accounts_screen.dart';
import 'categories_screen.dart';
import 'budget_screen.dart';
import 'reports_screen.dart'; // Import the new screen
import 'settings_screen.dart';

class MainAppScreen extends StatelessWidget {
  const MainAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.list_bullet),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.creditcard),
            label: 'Accounts',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.tag),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chart_pie),
            label: 'Budget',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chart_bar_square), // Add reports icon
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label: 'Settings',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) {
              return const DashboardScreen();
            });
          case 1:
            return CupertinoTabView(builder: (context) {
              return const TransactionsScreen();
            });
          case 2:
            return CupertinoTabView(builder: (context) {
              return const AccountsScreen();
            });
          case 3:
            return CupertinoTabView(builder: (context) {
              return const CategoriesScreen();
            });
          case 4:
            return CupertinoTabView(builder: (context) {
              return const BudgetScreen();
            });
          case 5:
            return CupertinoTabView(builder: (context) {
              return const ReportsScreen(); // Add reports screen
            });
          case 6:
            return CupertinoTabView(builder: (context) {
              return const SettingsScreen();
            });
          default:
            return CupertinoTabView(builder: (context) {
              return const DashboardScreen();
            });
        }
      },
    );
  }
}
