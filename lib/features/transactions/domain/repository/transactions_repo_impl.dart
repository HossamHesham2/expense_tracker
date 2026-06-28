import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/errors/failure.dart';
import 'package:expense_tracker/core/models/transaction_model.dart';
import 'package:expense_tracker/features/transactions/data/request/transactions_remote.dart';
import 'package:expense_tracker/features/transactions/domain/repository/transactions_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TransactionsRepo)
class TransactionsRepoImpl extends TransactionsRepo {
  final TransactionsRemote transactionsRemote;

  TransactionsRepoImpl({required this.transactionsRemote});

  @override
  Future<Either<Failure, List<TransactionModel>>> getAllTransactions() async {
    try {
      final result = await transactionsRemote.getAllTransactions();
      return Right(result);
    } catch (e) {
      throw Left(ServerFailure(errMessage: e.toString()));
    }
  }
}
