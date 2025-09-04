import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorSchemeSeed: const Color(0xFF2563EB),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: const Color(0xFF60A5FA),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

final themeModeProvider = StateProvider<ThemeMode>((_) => ThemeMode.system);
