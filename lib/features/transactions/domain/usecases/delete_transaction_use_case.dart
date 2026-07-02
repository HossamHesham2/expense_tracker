import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/errors/failure.dart';
import 'package:expense_tracker/features/transactions/domain/repository/transactions_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteTransactionUseCase {
  final TransactionsRepo transactionsRepo;

  DeleteTransactionUseCase({required this.transactionsRepo});

  Future<Either<Failure, bool>> call({required String id}) {
    return transactionsRepo.deleteTransaction(id: id);
  }
}
