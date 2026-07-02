import 'package:expense_tracker/core/models/transaction_model.dart';

abstract class TransactionsRemote {
  Future<List<TransactionModel>> getAllTransactions();

  Future<TransactionModel> editTransaction({
    required String id,
    required String title,
    required double amount,
    required String category,
    required TransactionType transactionType,
    required AccountType accountType,
    required DateTime date,
    required String? note,
  });

  Future<bool> deleteTransaction({required String id});
}
