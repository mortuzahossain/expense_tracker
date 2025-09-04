import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/src/features/splash/splash_screen.dart';
import 'package:expense_tracker/src/features/auth/pin_lock_screen.dart';
import 'package:expense_tracker/src/features/dashboard/dashboard_screen.dart';
import 'package:expense_tracker/src/features/transactions/add_transaction_screen.dart';
import 'package:expense_tracker/src/features/accounts/accounts_screen.dart';
import 'package:expense_tracker/src/features/categories/categories_screen.dart';
import 'package:expense_tracker/src/features/budget/budget_screen.dart';
import 'package:expense_tracker/src/features/reports/reports_screen.dart';
import 'package:expense_tracker/src/features/settings/settings_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
      GoRoute(path: '/pin', builder: (_, __) => const PinLockScreen()),
      GoRoute(path: '/', builder: (_, __) => const DashboardScreen()),
      GoRoute(path: '/tx/new', builder: (_, __) => const AddTransactionScreen()),
      GoRoute(path: '/accounts', builder: (_, __) => const AccountsScreen()),
      GoRoute(path: '/categories', builder: (_, __) => const CategoriesScreen()),
      GoRoute(path: '/budget', builder: (_, __) => const BudgetScreen()),
      GoRoute(path: '/reports', builder: (_, __) => const ReportsScreen()),
      GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
    ],
  );
});
