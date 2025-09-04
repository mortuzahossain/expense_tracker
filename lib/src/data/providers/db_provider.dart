import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expense_tracker/src/data/local/app_db.dart';

final appDatabaseProvider = StateProvider<AppDatabase?>((_) => null);
