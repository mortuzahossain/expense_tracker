import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'pin_lock_screen.dart';
import 'main_app_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a delay for the splash screen
    Timer(const Duration(seconds: 2), () {
      _checkPinAndNavigate();
    });
  }

  Future<void> _checkPinAndNavigate() async {
    // For now, let's assume a PIN exists and navigate to the PIN lock screen.
    // In the future, this will check flutter_secure_storage.
    const bool pinExists = true; // Placeholder

    if (!mounted) return;

    if (pinExists) {
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute(builder: (context) => const PinLockScreen()),
      );
    } else {
      // If no PIN, go to the main app screen
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute(builder: (context) => const MainAppScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoActivityIndicator(radius: 20.0),
            SizedBox(height: 20),
            Text('Expense Tracker'),
          ],
        ),
      ),
    );
  }
}
