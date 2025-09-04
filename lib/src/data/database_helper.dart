import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'app_database.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static AppDatabase? _database;

  Future<AppDatabase> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<AppDatabase> _initDatabase() async {
    // The following code requires the generated 'app_database.g.dart' file.
    // It will be uncommented after running the build_runner.
    /*
    return await $FloorAppDatabase
        .databaseBuilder('app_database.db')
        .addCallback(
          Callback(
            onCreate: (database, version) async {
              await _seedDatabase(database);
            },
          ),
        )
        .build();
    */
    throw UnimplementedError('Database initialization requires code generation.');
  }

  Future<void> _seedDatabase(sqflite.Database database) async {
    // Seed expense categories (type 1)
    await database.execute(
        "INSERT INTO Category (name, type, icon) VALUES ('Food', 1, 'food')");
    await database.execute(
        "INSERT INTO Category (name, type, icon) VALUES ('Transport', 1, 'trainCar')");
    await database.execute(
        "INSERT INTO Category (name, type, icon) VALUES ('Shopping', 1, 'shopping')");
    await database.execute(
        "INSERT INTO Category (name, type, icon) VALUES ('Bills', 1, 'fileDocument')");
    await database.execute(
        "INSERT INTO Category (name, type, icon) VALUES ('Entertainment', 1, 'movie')");
    await database.execute(
        "INSERT INTO Category (name, type, icon) VALUES ('Health', 1, 'heartPulse')");

    // Seed income categories (type 0)
    await database.execute(
        "INSERT INTO Category (name, type, icon) VALUES ('Salary', 0, 'cash')");
    await database.execute(
        "INSERT INTO Category (name, type, icon) VALUES ('Freelance', 0, 'briefcase')");
    await database.execute(
        "INSERT INTO Category (name, type, icon) VALUES ('Investment', 0, 'chartLine')");
    await database.execute(
        "INSERT INTO Category (name, type, icon) VALUES ('Gift', 0, 'gift')");
  }
}
