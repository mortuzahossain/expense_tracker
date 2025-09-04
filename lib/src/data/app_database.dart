import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../models/account.dart';
import '../models/category.dart';
import '../models/transaction.dart';
import 'daos/account_dao.dart';
import 'daos/category_dao.dart';
import 'daos/transaction_dao.dart';

part 'app_database.g.dart'; // the generated file

class CategoryTypeConverter extends TypeConverter<CategoryType, int> {
  @override
  CategoryType decode(int databaseValue) {
    return CategoryType.values[databaseValue];
  }

  @override
  int encode(CategoryType value) {
    return value.index;
  }
}

class TransactionTypeConverter extends TypeConverter<TransactionType, int> {
  @override
  TransactionType decode(int databaseValue) {
    return TransactionType.values[databaseValue];
  }

  @override
  int encode(TransactionType value) {
    return value.index;
  }
}

class DateTimeConverter extends TypeConverter<DateTime, int> {
  @override
  DateTime decode(int databaseValue) {
    return DateTime.fromMillisecondsSinceEpoch(databaseValue);
  }

  @override
  int encode(DateTime value) {
    return value.millisecondsSinceEpoch;
  }
}


@TypeConverters([CategoryTypeConverter, TransactionTypeConverter, DateTimeConverter])
@Database(version: 1, entities: [Account, Category, Transaction])
abstract class AppDatabase extends FloorDatabase {
  AccountDao get accountDao;
  CategoryDao get categoryDao;
  TransactionDao get transactionDao;
}
