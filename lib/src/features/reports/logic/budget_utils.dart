import 'package:expense_tracker/src/data/local/app_db.dart';
import 'package:expense_tracker/src/data/local/entities.dart';

class BudgetProgress {
  final double spent; // expenses only
  final double limit;
  double get remaining => (limit - spent).clamp(0, limit);
  double get ratio => limit == 0 ? 0 : (spent / limit);
  const BudgetProgress(this.spent, this.limit);
}

Future<BudgetProgress> computeBudgetProgress(AppDatabase db, int categoryId, DateTime from, DateTime to) async {
  final txs = await db.transactionDao.between(from, to);
  final spent = txs.where((t) => t.categoryId == categoryId && t.type == 'expense').fold<double>(0, (s, t) => s + t.amount);

  final budgets = await db.budgetDao.activeOn(DateTime.now());
  final budget = budgets.firstWhere(
    (b) => b.categoryId == categoryId,
    orElse: () => BudgetEntity(id: null, categoryId: categoryId, limitAmount: 0, startDate: from, endDate: to),
  );
  return BudgetProgress(spent, budget.limitAmount);
}
