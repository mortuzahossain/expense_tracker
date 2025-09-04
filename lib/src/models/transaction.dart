import 'package:floor/floor.dart';
import 'account.dart';
import 'category.dart';

enum TransactionType {
  income,
  expense,
  transfer,
}

@Entity(
  tableName: 'Transaction',
  foreignKeys: [
    ForeignKey(
      childColumns: ['account_id'],
      parentColumns: ['id'],
      entity: Account,
    ),
    ForeignKey(
      childColumns: ['category_id'],
      parentColumns: ['id'],
      entity: Category,
    ),
    ForeignKey(
      childColumns: ['transfer_to_account_id'],
      parentColumns: ['id'],
      entity: Account,
    ),
  ],
)
class Transaction {
  @primaryKey(autoGenerate: true)
  final int? id;

  final double amount;

  final DateTime date;

  @ColumnInfo(name: 'account_id')
  final int accountId;

  @ColumnInfo(name: 'category_id')
  final int? categoryId; // Nullable for transfers

  final TransactionType type;

  final String? note;

  @ColumnInfo(name: 'transfer_to_account_id')
  final int? transferToAccountId; // Nullable for non-transfer transactions

  Transaction({
    this.id,
    required this.amount,
    required this.date,
    required this.accountId,
    this.categoryId,
    required this.type,
    this.note,
    this.transferToAccountId,
  });
}
