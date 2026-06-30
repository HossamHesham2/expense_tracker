import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_tracker/core/errors/failure.dart';
import 'package:expense_tracker/core/models/transaction_model.dart';
import 'package:expense_tracker/features/transactions/domain/usecases/edit_transaction_use_case.dart';
import 'package:expense_tracker/features/transactions/domain/usecases/get_all_transactions_use_case.dart';
import 'package:injectable/injectable.dart';

part 'transactions_event.dart';

part 'transactions_state.dart';

@injectable
class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final GetAllTransactionsUseCase getAllTransactionsUseCase;
  final EditTransactionUseCase editTransactionUseCase;

  TransactionsBloc({
    required this.getAllTransactionsUseCase,
    required this.editTransactionUseCase,
  }) : super(TransactionsState.initial()) {
    on<TransactionsEvent>((event, emit) async {
      switch (event) {
        case GetAllTransactionsEvent():
          emit(
            state.copyWith(transactionsRequest: TransactionsRequest.loading),
          );
          print("GetAllTransactionsEvent Fired");
          final res = await getAllTransactionsUseCase.call();

          res.fold(
            (l) => emit(
              state.copyWith(
                transactionsRequest: TransactionsRequest.error,
                transactionsFailure: ServerFailure(errMessage: l.errMessage),
              ),
            ),
            (r) {
              print("Transactions: ${r.map((e) => e.title).toList()}");

              emit(
              state.copyWith(
                transactionsRequest: TransactionsRequest.success,
                transactions: r,
              ),
            );
            },
          );

        case EditTransactionEvent():
          emit(
            state.copyWith(
              editTransactionsRequest: TransactionsRequest.loading,
            ),
          );
          
          final res = await editTransactionUseCase.call(
            id: event.id,
            title: event.title,
            amount: event.amount,
            category: event.category,
            transactionType: event.transactionType,
            accountType: event.accountType,
            date: event.date,
            note: event.note,
          );
          print("Edit Done");
          res.fold(
            (l) => emit(
              state.copyWith(
                editTransactionsRequest: TransactionsRequest.error,
                editTransactionsFailure: ServerFailure(
                  errMessage: l.errMessage,
                ),
              ),
            ),
            (r) => emit(
              state.copyWith(
                editTransactionsRequest: TransactionsRequest.success,
                transactionModel: r,
              ),
            ),
          );
      }
    });
  }
}
