import 'package:expense_tracker/core/models/transaction_model.dart';

abstract class AddTransactionRemote {
  Future<TransactionModel> addTransaction({
    required String title,
    required double amount,
    required String category,
    required TransactionType transactionType,
    required AccountType accountType,
    required DateTime date,
    required String? note,
  });
}
