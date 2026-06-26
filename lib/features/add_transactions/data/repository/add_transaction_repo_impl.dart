import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/errors/app_exceptions.dart';
import 'package:expense_tracker/core/errors/failure.dart';
import 'package:expense_tracker/core/models/transaction_model.dart';
import 'package:expense_tracker/features/add_transactions/data/request/add_transaction_remote.dart';
import 'package:expense_tracker/features/add_transactions/domain/repository/add_transaction_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddTransactionRepo)
class AddTransactionRepoImpl extends AddTransactionRepo {
  final AddTransactionRemote addTransactionRemote;

  AddTransactionRepoImpl({required this.addTransactionRemote});

  @override
  Future<Either<Failure, TransactionModel>> addTransaction({
    required String title,
    required double amount,
    required String category,
    required TransactionType transactionType,
    required AccountType accountType,
    required DateTime date,
    required String? note,
  }) async {
    try {
      final result = await addTransactionRemote.addTransaction(
        title: title,
        amount: amount,
        category: category,
        transactionType: transactionType,
        accountType: accountType,
        date: date,
        note: note,
      );
      return Right(result);
    } on RemoteException catch (e) {
      return Left(ServerFailure(errMessage: e.message));
    }
  }
}
