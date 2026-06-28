import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_tracker/core/errors/failure.dart';
import 'package:expense_tracker/core/models/transaction_model.dart';
import 'package:expense_tracker/features/transactions/domain/usecases/get_all_transactions_use_case.dart';
import 'package:injectable/injectable.dart';

part 'transactions_event.dart';

part 'transactions_state.dart';
@injectable
class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final GetAllTransactionsUseCase getAllTransactionsUseCase;

  TransactionsBloc({required this.getAllTransactionsUseCase})
    : super(TransactionsState.initial()) {
    on<TransactionsEvent>((event, emit) async {
      switch (event) {
        case GetAllTransactionsEvent():
          emit(
            state.copyWith(transactionsRequest: TransactionsRequest.loading),
          );
          final res = await getAllTransactionsUseCase.call();

          res.fold(
            (l) => emit(
              state.copyWith(
                transactionsRequest: TransactionsRequest.error,
                transactionsFailure: ServerFailure(errMessage: l.errMessage),
              ),
            ),
            (r) => emit(
              state.copyWith(
                transactionsRequest: TransactionsRequest.success,
                transactions: r,
              ),
            ),
          );
      }
    });
  }
}
