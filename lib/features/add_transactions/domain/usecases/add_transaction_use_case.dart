import 'package:expense_tracker/features/add_transactions/domain/repository/add_transaction_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddTransactionUseCase {
  final AddTransactionRepo addTransactionRepo;

  AddTransactionUseCase({required this.addTransactionRepo});

}
