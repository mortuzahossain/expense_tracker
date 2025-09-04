import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expense_tracker/src/core/theme/app_theme.dart';
import 'package:expense_tracker/src/data/local/app_db.dart';
import 'package:expense_tracker/src/data/providers/db_provider.dart';
import 'package:expense_tracker/src/data/local/entities.dart';

final settingsControllerProvider = StateNotifierProvider<SettingsController, AsyncValue<Map<String, String>>>((ref) {
  final db = ref.watch(appDatabaseProvider); // AppDatabase?
  return SettingsController(db!);
});

class SettingsController extends StateNotifier<AsyncValue<Map<String, String>>> {
  final AppDatabase db;
  SettingsController(this.db) : super(const AsyncLoading());

  Future<void> ensureDefaults() async {
    final defaults = <String, String>{'theme': 'system', 'currency': 'BDT'};
    final out = <String, String>{};
    for (final e in defaults.entries) {
      final existing = await db.settingDao.byKey(e.key);
      if (existing == null) {
        await db.settingDao.put(SettingEntity(key: e.key, value: e.value));
        out[e.key] = e.value;
      } else {
        out[e.key] = existing.value;
      }
    }
    state = AsyncData(out);
  }

  Future<void> setThemeMode(WidgetRef ref, String mode) async {
    await db.settingDao.update('theme', mode);
    switch (mode) {
      case 'light':
        ref.read(themeModeProvider.notifier).state = ThemeMode.light;
        break;
      case 'dark':
        ref.read(themeModeProvider.notifier).state = ThemeMode.dark;
        break;
      default:
        ref.read(themeModeProvider.notifier).state = ThemeMode.system;
    }
  }
}
