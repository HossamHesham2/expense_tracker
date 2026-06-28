import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/errors/failure.dart';
import 'package:expense_tracker/core/models/transaction_model.dart';

abstract class TransactionsRepo {
  Future<Either<Failure , List<TransactionModel>>> getAllTransactions();
}