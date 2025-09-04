import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
import 'entities.dart';
import 'daos.dart';

part 'app_db.g.dart';

class DateTimeConverter extends TypeConverter<DateTime, int> {
  @override
  DateTime decode(int databaseValue) => DateTime.fromMillisecondsSinceEpoch(databaseValue);

  @override
  int encode(DateTime value) => value.millisecondsSinceEpoch;
}

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [AccountEntity, CategoryEntity, TransactionEntity, BudgetEntity, SettingEntity])
abstract class AppDatabase extends FloorDatabase {
  AccountDao get accountDao;
  CategoryDao get categoryDao;
  TransactionDao get transactionDao;
  BudgetDao get budgetDao;
  SettingDao get settingDao;
}
