import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/errors/failure.dart';
import 'package:expense_tracker/core/models/transaction_model.dart';
import 'package:expense_tracker/features/add_transactions/domain/repository/add_transaction_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddTransactionUseCase {
  final AddTransactionRepo addTransactionRepo;

  AddTransactionUseCase({required this.addTransactionRepo});

  Future<Either<Failure, TransactionModel>> call({
    required String title,
    required double amount,
    required String category,
    required TransactionType transactionType,
    required AccountType accountType,
    required DateTime date,
    required String? note,
  }) {
    return addTransactionRepo.addTransaction(
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
