import 'package:floor/floor.dart';
import 'entities.dart';

@dao
abstract class AccountDao {
  @Query('SELECT * FROM accounts ORDER BY createdAt DESC')
  Future<List<AccountEntity>> all();

  @Query('SELECT * FROM accounts WHERE id = :id')
  Future<AccountEntity?> byId(int id);

  @insert
  Future<int> insertOne(AccountEntity entity);

  @update
  Future<void> updateOne(AccountEntity entity);

  @delete
  Future<void> deleteOne(AccountEntity entity);

  @Query('UPDATE accounts SET balance = balance + :delta WHERE id = :id')
  Future<void> updateBalance(int id, double delta);
}

@dao
abstract class CategoryDao {
  @Query('SELECT * FROM categories WHERE type = :type ORDER BY name')
  Future<List<CategoryEntity>> byType(String type);

  @Query('SELECT * FROM categories ORDER BY name')
  Future<List<CategoryEntity>> all();

  @insert
  Future<int> insertOne(CategoryEntity entity);

  @update
  Future<void> updateOne(CategoryEntity entity);

  @delete
  Future<void> deleteOne(CategoryEntity entity);
}

@dao
abstract class TransactionDao {
  @Query('SELECT * FROM transactions WHERE date BETWEEN :from AND :to ORDER BY date DESC, id DESC')
  Future<List<TransactionEntity>> between(DateTime from, DateTime to);

  @Query('SELECT * FROM transactions ORDER BY date DESC, id DESC LIMIT :limit OFFSET :offset')
  Future<List<TransactionEntity>> page(int limit, int offset);

  @insert
  Future<int> insertOne(TransactionEntity entity);

  @update
  Future<void> updateOne(TransactionEntity entity);

  @delete
  Future<void> deleteOne(TransactionEntity entity);

  @transaction
  Future<void> insertIncomeExpenseAndAdjustBalance(TransactionEntity tx, AccountDao accountDao) async {
    final id = await insertOne(tx);
    final sign = tx.type == 'income' ? 1.0 : -1.0;
    await accountDao.updateBalance(tx.accountId, sign * tx.amount);
  }

  @transaction
  Future<void> insertTransferPair(
    AccountDao accountDao,
    int fromAccountId,
    int toAccountId,
    double amount,
    DateTime date,
    String note,
  ) async {
    // Leg 1: outflow
    final outTx = TransactionEntity(
      accountId: fromAccountId,
      categoryId: null,
      amount: amount,
      date: date,
      type: 'transfer',
      note: note,
      createdAt: DateTime.now(),
    );
    final outId = await insertOne(outTx);

    // Leg 2: inflow
    final inTx = TransactionEntity(
      accountId: toAccountId,
      categoryId: null,
      amount: amount,
      date: date,
      type: 'transfer',
      note: note,
      createdAt: DateTime.now(),
      transferPairId: outId,
    );
    final inId = await insertOne(inTx);

    // Link back-pair
    await updateOne(
      TransactionEntity(
        id: outId,
        accountId: fromAccountId,
        categoryId: null,
        amount: amount,
        date: date,
        type: 'transfer',
        note: note,
        createdAt: outTx.createdAt,
        transferPairId: inId,
      ),
    );

    // Adjust balances
    await accountDao.updateBalance(fromAccountId, -amount);
    await accountDao.updateBalance(toAccountId, amount);
  }
}

@dao
abstract class BudgetDao {
  @Query('SELECT * FROM budgets WHERE (startDate <= :date AND endDate >= :date)')
  Future<List<BudgetEntity>> activeOn(DateTime date);

  @insert
  Future<int> insertOne(BudgetEntity entity);

  @update
  Future<void> updateOne(BudgetEntity entity);

  @delete
  Future<void> deleteOne(BudgetEntity entity);
}

@dao
abstract class SettingDao {
  @Query('SELECT * FROM settings WHERE key = :key')
  Future<SettingEntity?> byKey(String key);

  @insert
  Future<void> put(SettingEntity entity);

  @Query('UPDATE settings SET value = :value WHERE key = :key')
  Future<void> update(String key, String value);
}
