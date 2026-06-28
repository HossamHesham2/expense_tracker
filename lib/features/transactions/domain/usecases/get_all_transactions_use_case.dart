import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/errors/failure.dart';
import 'package:expense_tracker/core/models/transaction_model.dart';
import 'package:expense_tracker/features/transactions/domain/repository/transactions_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllTransactionsUseCase {
  final TransactionsRepo transactionsRepo;

  GetAllTransactionsUseCase({required this.transactionsRepo});

  Future<Either<Failure, List<TransactionModel>>> call() {
    return transactionsRepo.getAllTransactions();
  }
}
