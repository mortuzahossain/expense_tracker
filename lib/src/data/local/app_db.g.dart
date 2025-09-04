// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  AccountDao? _accountDaoInstance;

  CategoryDao? _categoryDaoInstance;

  TransactionDao? _transactionDaoInstance;

  BudgetDao? _budgetDaoInstance;

  SettingDao? _settingDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `accounts` (`id` INTEGER, `name` TEXT NOT NULL, `kind` TEXT NOT NULL, `balance` REAL NOT NULL, `createdAt` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `categories` (`id` INTEGER, `name` TEXT NOT NULL, `icon` TEXT NOT NULL, `type` TEXT NOT NULL, `createdAt` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `transactions` (`id` INTEGER, `accountId` INTEGER NOT NULL, `categoryId` INTEGER, `amount` REAL NOT NULL, `date` INTEGER NOT NULL, `type` TEXT NOT NULL, `note` TEXT NOT NULL, `createdAt` INTEGER NOT NULL, `transferPairId` INTEGER, FOREIGN KEY (`accountId`) REFERENCES `accounts` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, FOREIGN KEY (`categoryId`) REFERENCES `categories` (`id`) ON UPDATE NO ACTION ON DELETE SET NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `budgets` (`id` INTEGER, `categoryId` INTEGER NOT NULL, `limitAmount` REAL NOT NULL, `startDate` INTEGER NOT NULL, `endDate` INTEGER NOT NULL, FOREIGN KEY (`categoryId`) REFERENCES `categories` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `settings` (`key` TEXT NOT NULL, `value` TEXT NOT NULL, PRIMARY KEY (`key`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  AccountDao get accountDao {
    return _accountDaoInstance ??= _$AccountDao(database, changeListener);
  }

  @override
  CategoryDao get categoryDao {
    return _categoryDaoInstance ??= _$CategoryDao(database, changeListener);
  }

  @override
  TransactionDao get transactionDao {
    return _transactionDaoInstance ??=
        _$TransactionDao(database, changeListener);
  }

  @override
  BudgetDao get budgetDao {
    return _budgetDaoInstance ??= _$BudgetDao(database, changeListener);
  }

  @override
  SettingDao get settingDao {
    return _settingDaoInstance ??= _$SettingDao(database, changeListener);
  }
}

class _$AccountDao extends AccountDao {
  _$AccountDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _accountEntityInsertionAdapter = InsertionAdapter(
            database,
            'accounts',
            (AccountEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'kind': item.kind,
                  'balance': item.balance,
                  'createdAt': _dateTimeConverter.encode(item.createdAt)
                }),
        _accountEntityUpdateAdapter = UpdateAdapter(
            database,
            'accounts',
            ['id'],
            (AccountEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'kind': item.kind,
                  'balance': item.balance,
                  'createdAt': _dateTimeConverter.encode(item.createdAt)
                }),
        _accountEntityDeletionAdapter = DeletionAdapter(
            database,
            'accounts',
            ['id'],
            (AccountEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'kind': item.kind,
                  'balance': item.balance,
                  'createdAt': _dateTimeConverter.encode(item.createdAt)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AccountEntity> _accountEntityInsertionAdapter;

  final UpdateAdapter<AccountEntity> _accountEntityUpdateAdapter;

  final DeletionAdapter<AccountEntity> _accountEntityDeletionAdapter;

  @override
  Future<List<AccountEntity>> all() async {
    return _queryAdapter.queryList(
        'SELECT * FROM accounts ORDER BY createdAt DESC',
        mapper: (Map<String, Object?> row) => AccountEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            kind: row['kind'] as String,
            balance: row['balance'] as double,
            createdAt: _dateTimeConverter.decode(row['createdAt'] as int)));
  }

  @override
  Future<AccountEntity?> byId(int id) async {
    return _queryAdapter.query('SELECT * FROM accounts WHERE id = ?1',
        mapper: (Map<String, Object?> row) => AccountEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            kind: row['kind'] as String,
            balance: row['balance'] as double,
            createdAt: _dateTimeConverter.decode(row['createdAt'] as int)),
        arguments: [id]);
  }

  @override
  Future<void> updateBalance(
    int id,
    double delta,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE accounts SET balance = balance + ?2 WHERE id = ?1',
        arguments: [id, delta]);
  }

  @override
  Future<int> insertOne(AccountEntity entity) {
    return _accountEntityInsertionAdapter.insertAndReturnId(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateOne(AccountEntity entity) async {
    await _accountEntityUpdateAdapter.update(entity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteOne(AccountEntity entity) async {
    await _accountEntityDeletionAdapter.delete(entity);
  }
}

class _$CategoryDao extends CategoryDao {
  _$CategoryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _categoryEntityInsertionAdapter = InsertionAdapter(
            database,
            'categories',
            (CategoryEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'icon': item.icon,
                  'type': item.type,
                  'createdAt': _dateTimeConverter.encode(item.createdAt)
                }),
        _categoryEntityUpdateAdapter = UpdateAdapter(
            database,
            'categories',
            ['id'],
            (CategoryEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'icon': item.icon,
                  'type': item.type,
                  'createdAt': _dateTimeConverter.encode(item.createdAt)
                }),
        _categoryEntityDeletionAdapter = DeletionAdapter(
            database,
            'categories',
            ['id'],
            (CategoryEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'icon': item.icon,
                  'type': item.type,
                  'createdAt': _dateTimeConverter.encode(item.createdAt)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CategoryEntity> _categoryEntityInsertionAdapter;

  final UpdateAdapter<CategoryEntity> _categoryEntityUpdateAdapter;

  final DeletionAdapter<CategoryEntity> _categoryEntityDeletionAdapter;

  @override
  Future<List<CategoryEntity>> byType(String type) async {
    return _queryAdapter.queryList(
        'SELECT * FROM categories WHERE type = ?1 ORDER BY name',
        mapper: (Map<String, Object?> row) => CategoryEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            icon: row['icon'] as String,
            type: row['type'] as String,
            createdAt: _dateTimeConverter.decode(row['createdAt'] as int)),
        arguments: [type]);
  }

  @override
  Future<List<CategoryEntity>> all() async {
    return _queryAdapter.queryList('SELECT * FROM categories ORDER BY name',
        mapper: (Map<String, Object?> row) => CategoryEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            icon: row['icon'] as String,
            type: row['type'] as String,
            createdAt: _dateTimeConverter.decode(row['createdAt'] as int)));
  }

  @override
  Future<int> insertOne(CategoryEntity entity) {
    return _categoryEntityInsertionAdapter.insertAndReturnId(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateOne(CategoryEntity entity) async {
    await _categoryEntityUpdateAdapter.update(entity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteOne(CategoryEntity entity) async {
    await _categoryEntityDeletionAdapter.delete(entity);
  }
}

class _$TransactionDao extends TransactionDao {
  _$TransactionDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _transactionEntityInsertionAdapter = InsertionAdapter(
            database,
            'transactions',
            (TransactionEntity item) => <String, Object?>{
                  'id': item.id,
                  'accountId': item.accountId,
                  'categoryId': item.categoryId,
                  'amount': item.amount,
                  'date': _dateTimeConverter.encode(item.date),
                  'type': item.type,
                  'note': item.note,
                  'createdAt': _dateTimeConverter.encode(item.createdAt),
                  'transferPairId': item.transferPairId
                }),
        _transactionEntityUpdateAdapter = UpdateAdapter(
            database,
            'transactions',
            ['id'],
            (TransactionEntity item) => <String, Object?>{
                  'id': item.id,
                  'accountId': item.accountId,
                  'categoryId': item.categoryId,
                  'amount': item.amount,
                  'date': _dateTimeConverter.encode(item.date),
                  'type': item.type,
                  'note': item.note,
                  'createdAt': _dateTimeConverter.encode(item.createdAt),
                  'transferPairId': item.transferPairId
                }),
        _transactionEntityDeletionAdapter = DeletionAdapter(
            database,
            'transactions',
            ['id'],
            (TransactionEntity item) => <String, Object?>{
                  'id': item.id,
                  'accountId': item.accountId,
                  'categoryId': item.categoryId,
                  'amount': item.amount,
                  'date': _dateTimeConverter.encode(item.date),
                  'type': item.type,
                  'note': item.note,
                  'createdAt': _dateTimeConverter.encode(item.createdAt),
                  'transferPairId': item.transferPairId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TransactionEntity> _transactionEntityInsertionAdapter;

  final UpdateAdapter<TransactionEntity> _transactionEntityUpdateAdapter;

  final DeletionAdapter<TransactionEntity> _transactionEntityDeletionAdapter;

  @override
  Future<List<TransactionEntity>> between(
    DateTime from,
    DateTime to,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM transactions WHERE date BETWEEN ?1 AND ?2 ORDER BY date DESC, id DESC',
        mapper: (Map<String, Object?> row) => TransactionEntity(id: row['id'] as int?, accountId: row['accountId'] as int, categoryId: row['categoryId'] as int?, amount: row['amount'] as double, date: _dateTimeConverter.decode(row['date'] as int), type: row['type'] as String, note: row['note'] as String, createdAt: _dateTimeConverter.decode(row['createdAt'] as int), transferPairId: row['transferPairId'] as int?),
        arguments: [
          _dateTimeConverter.encode(from),
          _dateTimeConverter.encode(to)
        ]);
  }

  @override
  Future<List<TransactionEntity>> page(
    int limit,
    int offset,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM transactions ORDER BY date DESC, id DESC LIMIT ?1 OFFSET ?2',
        mapper: (Map<String, Object?> row) => TransactionEntity(id: row['id'] as int?, accountId: row['accountId'] as int, categoryId: row['categoryId'] as int?, amount: row['amount'] as double, date: _dateTimeConverter.decode(row['date'] as int), type: row['type'] as String, note: row['note'] as String, createdAt: _dateTimeConverter.decode(row['createdAt'] as int), transferPairId: row['transferPairId'] as int?),
        arguments: [limit, offset]);
  }

  @override
  Future<int> insertOne(TransactionEntity entity) {
    return _transactionEntityInsertionAdapter.insertAndReturnId(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateOne(TransactionEntity entity) async {
    await _transactionEntityUpdateAdapter.update(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteOne(TransactionEntity entity) async {
    await _transactionEntityDeletionAdapter.delete(entity);
  }

  @override
  Future<void> insertIncomeExpenseAndAdjustBalance(
    TransactionEntity tx,
    AccountDao accountDao,
  ) async {
    if (database is sqflite.Transaction) {
      await super.insertIncomeExpenseAndAdjustBalance(tx, accountDao);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$AppDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.transactionDao
            .insertIncomeExpenseAndAdjustBalance(tx, accountDao);
      });
    }
  }

  @override
  Future<void> insertTransferPair(
    AccountDao accountDao,
    int fromAccountId,
    int toAccountId,
    double amount,
    DateTime date,
    String note,
  ) async {
    if (database is sqflite.Transaction) {
      await super.insertTransferPair(
          accountDao, fromAccountId, toAccountId, amount, date, note);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$AppDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.transactionDao.insertTransferPair(
            accountDao, fromAccountId, toAccountId, amount, date, note);
      });
    }
  }
}

class _$BudgetDao extends BudgetDao {
  _$BudgetDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _budgetEntityInsertionAdapter = InsertionAdapter(
            database,
            'budgets',
            (BudgetEntity item) => <String, Object?>{
                  'id': item.id,
                  'categoryId': item.categoryId,
                  'limitAmount': item.limitAmount,
                  'startDate': _dateTimeConverter.encode(item.startDate),
                  'endDate': _dateTimeConverter.encode(item.endDate)
                }),
        _budgetEntityUpdateAdapter = UpdateAdapter(
            database,
            'budgets',
            ['id'],
            (BudgetEntity item) => <String, Object?>{
                  'id': item.id,
                  'categoryId': item.categoryId,
                  'limitAmount': item.limitAmount,
                  'startDate': _dateTimeConverter.encode(item.startDate),
                  'endDate': _dateTimeConverter.encode(item.endDate)
                }),
        _budgetEntityDeletionAdapter = DeletionAdapter(
            database,
            'budgets',
            ['id'],
            (BudgetEntity item) => <String, Object?>{
                  'id': item.id,
                  'categoryId': item.categoryId,
                  'limitAmount': item.limitAmount,
                  'startDate': _dateTimeConverter.encode(item.startDate),
                  'endDate': _dateTimeConverter.encode(item.endDate)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<BudgetEntity> _budgetEntityInsertionAdapter;

  final UpdateAdapter<BudgetEntity> _budgetEntityUpdateAdapter;

  final DeletionAdapter<BudgetEntity> _budgetEntityDeletionAdapter;

  @override
  Future<List<BudgetEntity>> activeOn(DateTime date) async {
    return _queryAdapter.queryList(
        'SELECT * FROM budgets WHERE (startDate <= ?1 AND endDate >= ?1)',
        mapper: (Map<String, Object?> row) => BudgetEntity(
            id: row['id'] as int?,
            categoryId: row['categoryId'] as int,
            limitAmount: row['limitAmount'] as double,
            startDate: _dateTimeConverter.decode(row['startDate'] as int),
            endDate: _dateTimeConverter.decode(row['endDate'] as int)),
        arguments: [_dateTimeConverter.encode(date)]);
  }

  @override
  Future<int> insertOne(BudgetEntity entity) {
    return _budgetEntityInsertionAdapter.insertAndReturnId(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateOne(BudgetEntity entity) async {
    await _budgetEntityUpdateAdapter.update(entity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteOne(BudgetEntity entity) async {
    await _budgetEntityDeletionAdapter.delete(entity);
  }
}

class _$SettingDao extends SettingDao {
  _$SettingDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _settingEntityInsertionAdapter = InsertionAdapter(
            database,
            'settings',
            (SettingEntity item) =>
                <String, Object?>{'key': item.key, 'value': item.value});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SettingEntity> _settingEntityInsertionAdapter;

  @override
  Future<SettingEntity?> byKey(String key) async {
    return _queryAdapter.query('SELECT * FROM settings WHERE key = ?1',
        mapper: (Map<String, Object?> row) => SettingEntity(
            key: row['key'] as String, value: row['value'] as String),
        arguments: [key]);
  }

  @override
  Future<void> update(
    String key,
    String value,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE settings SET value = ?2 WHERE key = ?1',
        arguments: [key, value]);
  }

  @override
  Future<void> put(SettingEntity entity) async {
    await _settingEntityInsertionAdapter.insert(
        entity, OnConflictStrategy.abort);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
