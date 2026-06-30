import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/errors/failure.dart';
import 'package:expense_tracker/core/models/transaction_model.dart';
import 'package:expense_tracker/features/transactions/domain/repository/transactions_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditTransactionUseCase {
  final TransactionsRepo transactionsRepo;

  EditTransactionUseCase({required this.transactionsRepo});

  Future<Either<Failure, TransactionModel>> call({
    required String id,
    required String title,
    required double amount,
    required String category,
    required TransactionType transactionType,
    required AccountType accountType,
    required DateTime date,
    required String? note,
  }) {
    return transactionsRepo.editTransaction(
      id: id,
      title: title,
      amount: amount,
      category: category,
      transactionType: transactionType,
      accountType: accountType,
      date: date,
      note: note,
    );
  }
}
