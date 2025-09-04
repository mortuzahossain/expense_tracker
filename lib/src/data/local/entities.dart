import 'package:floor/floor.dart';

@Entity(tableName: 'accounts')
class AccountEntity {
  @primaryKey
  final int? id;
  final String name;

  /// cash/bank/wallet string label
  final String kind;

  /// derived balance (kept for quick reads; always updated in @transaction ops)
  final double balance;
  final DateTime createdAt;

  AccountEntity({this.id, required this.name, required this.kind, required this.balance, required this.createdAt});

  AccountEntity copyWith({int? id, String? name, String? kind, double? balance, DateTime? createdAt}) => AccountEntity(
    id: id ?? this.id,
    name: name ?? this.name,
    kind: kind ?? this.kind,
    balance: balance ?? this.balance,
    createdAt: createdAt ?? this.createdAt,
  );
}

@Entity(tableName: 'categories')
class CategoryEntity {
  @primaryKey
  final int? id;
  final String name;
  final String icon; // store material icon name or svg asset key
  final String type; // 'income' | 'expense'
  final DateTime createdAt;

  CategoryEntity({this.id, required this.name, required this.icon, required this.type, required this.createdAt});
}

@Entity(
  tableName: 'transactions',
  foreignKeys: [
    ForeignKey(childColumns: ['accountId'], parentColumns: ['id'], entity: AccountEntity, onDelete: ForeignKeyAction.cascade),
    ForeignKey(childColumns: ['categoryId'], parentColumns: ['id'], entity: CategoryEntity, onDelete: ForeignKeyAction.setNull),
  ],
)
class TransactionEntity {
  @primaryKey
  final int? id;
  final int accountId;
  final int? categoryId; // null for transfer legs
  final double amount;
  final DateTime date;
  final String type; // 'income' | 'expense' | 'transfer'
  final String note;
  final DateTime createdAt;
  // For transfers: if not null, link the paired leg id
  final int? transferPairId;

  TransactionEntity({
    this.id,
    required this.accountId,
    this.categoryId,
    required this.amount,
    required this.date,
    required this.type,
    this.note = '',
    required this.createdAt,
    this.transferPairId,
  });
}

@Entity(
  tableName: 'budgets',
  foreignKeys: [
    ForeignKey(childColumns: ['categoryId'], parentColumns: ['id'], entity: CategoryEntity, onDelete: ForeignKeyAction.cascade),
  ],
)
class BudgetEntity {
  @primaryKey
  final int? id;
  final int categoryId;
  final double limitAmount;
  final DateTime startDate;
  final DateTime endDate;

  BudgetEntity({this.id, required this.categoryId, required this.limitAmount, required this.startDate, required this.endDate});
}

@Entity(tableName: 'settings')
class SettingEntity {
  @primaryKey
  final String key;
  final String value;

  SettingEntity({required this.key, required this.value});
}
