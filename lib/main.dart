import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'src/presentation/screens/splash_screen.dart';
import 'src/presentation/providers/settings_provider.dart';
import 'src/presentation/providers/add_edit_transaction_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => AddEditTransactionProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Expense Tracker',
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.systemBlue,
      ),
      home: SplashScreen(),
    );
  }
}
