import 'package:floor/floor.dart';

@entity
class Account {
  @primaryKey(autoGenerate: true)
  final int? id;

  final String name;

  final double balance;

  Account({this.id, required this.name, required this.balance});
}
