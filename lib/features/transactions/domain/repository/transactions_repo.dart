import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/errors/failure.dart';
import 'package:expense_tracker/core/models/transaction_model.dart';

abstract class TransactionsRepo {
  Future<Either<Failure, List<TransactionModel>>> getAllTransactions();

  Future<Either<Failure, TransactionModel>> editTransaction({
    required String id,
    required String title,
    required double amount,
    required String category,
    required TransactionType transactionType,
    required AccountType accountType,
    required DateTime date,
    required String? note,
  });

  Future<Either<Failure, bool>> deleteTransaction({required String id});
}
