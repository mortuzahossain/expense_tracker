import 'package:floor/floor.dart';
import '../../models/account.dart';

@dao
abstract class AccountDao {
  @Query('SELECT * FROM Account')
  Future<List<Account>> findAllAccounts();

  @Query('SELECT * FROM Account WHERE id = :id')
  Stream<Account?> findAccountById(int id);

  @insert
  Future<void> insertAccount(Account account);

  @update
  Future<void> updateAccount(Account account);

  @delete
  Future<void> deleteAccount(Account account);
}
