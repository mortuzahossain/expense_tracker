import 'package:floor/floor.dart';

enum CategoryType {
  income,
  expense,
}

@entity
class Category {
  @primaryKey(autoGenerate: true)
  final int? id;

  final String name;

  final CategoryType type;

  final String icon;

  Category({this.id, required this.name, required this.type, required this.icon});
}
