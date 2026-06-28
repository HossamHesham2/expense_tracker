import 'package:expense_tracker/core/models/transaction_model.dart';

abstract class TransactionsRemote {
  Future<List<TransactionModel>> getAllTransactions();
}