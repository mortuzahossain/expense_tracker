import 'package:expense_tracker/src/data/providers/db_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:expense_tracker/src/data/local/app_db.dart';
import 'package:expense_tracker/src/features/settings/providers/settings_providers.dart';
import 'package:expense_tracker/src/features/auth/pin_service.dart';

Future<ProviderContainer> bootstrap() async {
  final container = ProviderContainer();
  final appDocDir = await getApplicationDocumentsDirectory();
  final dbPath = '${appDocDir.path}/expense_tracker.db';
  final db = await $FloorAppDatabase.databaseBuilder(dbPath).build();

  container.read(appDatabaseProvider.notifier).state = db;

  // ensure default settings
  await container.read(settingsControllerProvider.notifier).ensureDefaults();

  // ensure PIN storage initialized (no-op if exists)
  await container.read(pinServiceProvider).init();

  return container;
}
