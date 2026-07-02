import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_tracker/core/errors/failure.dart';
import 'package:expense_tracker/core/models/transaction_model.dart';
import 'package:expense_tracker/features/transactions/domain/usecases/delete_transaction_use_case.dart';
import 'package:expense_tracker/features/transactions/domain/usecases/edit_transaction_use_case.dart';
import 'package:expense_tracker/features/transactions/domain/usecases/get_all_transactions_use_case.dart';
import 'package:injectable/injectable.dart';

part 'transactions_event.dart';

part 'transactions_state.dart';

@injectable
class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final GetAllTransactionsUseCase getAllTransactionsUseCase;
  final EditTransactionUseCase editTransactionUseCase;
  final DeleteTransactionUseCase deleteTransactionUseCase;

  TransactionsBloc({
    required this.getAllTransactionsUseCase,
    required this.editTransactionUseCase,
    required this.deleteTransactionUseCase,
  }) : super(TransactionsState.initial()) {
    on<GetAllTransactionsEvent>(_onGetAllTransactions);
    on<EditTransactionEvent>(_onEditTransaction);
    on<DeleteTransactionEvent>(_onDeleteTransaction);
  }

  Future<void> _onGetAllTransactions(
    GetAllTransactionsEvent event,
    Emitter<TransactionsState> emit,
  ) async {
    emit(state.copyWith(transactionsRequest: TransactionsRequest.loading));

    final res = await getAllTransactionsUseCase.call();
    await Future.delayed(const Duration(milliseconds: 1500));
    res.fold(
      (l) {
        emit(
          state.copyWith(
            transactionsRequest: TransactionsRequest.error,
            transactionsFailure: ServerFailure(errMessage: l.errMessage),
          ),
        );
      },
      (transactions) {
        emit(
          state.copyWith(
            transactionsRequest: TransactionsRequest.success,
            transactions: transactions,
          ),
        );
      },
    );
  }

  Future<void> _onEditTransaction(
    EditTransactionEvent event,
    Emitter<TransactionsState> emit,
  ) async {
    emit(state.copyWith(editTransactionsRequest: TransactionsRequest.loading));

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

    res.fold(
      (l) {
        emit(
          state.copyWith(
            editTransactionsRequest: TransactionsRequest.error,
            editTransactionsFailure: ServerFailure(errMessage: l.errMessage),
          ),
        );
      },
      (transaction) {
        emit(
          state.copyWith(
            editTransactionsRequest: TransactionsRequest.success,
            transactionModel: transaction,
          ),
        );

        add(const GetAllTransactionsEvent());
      },
    );
  }

  Future<void> _onDeleteTransaction(
    DeleteTransactionEvent event,
    Emitter<TransactionsState> emit,
  ) async {
    emit(
      state.copyWith(deleteTransactionsRequest: TransactionsRequest.loading),
    );

    final res = await deleteTransactionUseCase.call(id: event.id);

    res.fold(
      (l) {
        emit(
          state.copyWith(
            deleteTransactionsRequest: TransactionsRequest.error,
            deleteTransactionsFailure: ServerFailure(errMessage: l.errMessage),
          ),
        );
      },
      (_) {
        final updatedTransactions = List<TransactionModel>.from(
          state.transactions,
        )..removeWhere((e) => e.id == event.id);

        emit(
          state.copyWith(
            deleteTransactionsRequest: TransactionsRequest.success,
            transactions: updatedTransactions,
          ),
        );
      },
    );
  }
}
