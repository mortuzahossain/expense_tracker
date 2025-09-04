import 'package:floor/floor.dart';
import '../../models/transaction.dart';

@dao
abstract class TransactionDao {
  @Query('SELECT * FROM `Transaction` ORDER BY date DESC')
  Stream<List<Transaction>> findAllTransactions();

  @Query('SELECT * FROM `Transaction` WHERE date BETWEEN :start AND :end ORDER BY date DESC')
  Stream<List<Transaction>> findTransactionsByDateRange(DateTime start, DateTime end);

  @insert
  Future<void> insertTransaction(Transaction transaction);

  @update
  Future<void> updateTransaction(Transaction transaction);

  @delete
  Future<void> deleteTransaction(Transaction transaction);
}
