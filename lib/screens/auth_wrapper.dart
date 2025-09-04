import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_youtube/services/auth_service.dart';
import 'package:flutter_youtube/screens/login_screen.dart';
import 'package:flutter_youtube/screens/main_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    if (authService.appUser == null) {
      return const LoginScreen();
    } else {
      return const MainScreen();
    }
  }
}
